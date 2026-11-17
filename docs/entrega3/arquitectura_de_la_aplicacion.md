# Arquitectura de la Aplicación - Portal FIFA World Cup

Este documento describe la arquitectura general del sistema web desarrollado para la administración y seguimiento de las Copas Mundiales de la FIFA, detallando el flujo de comunicación entre la interfaz de usuario, el backend en Java y la base de datos.

---

## 1. Visión General y Stack Tecnológico

La aplicación fue creada con Spring (un framework para webs con java), y se usa:

* **Frontend (Vistas):** HTML, donde cada vista tiene su propio archivo .html (unificado bajo una plantilla maestra `layout.html`).
* **Backend (Servidor de Aplicación):** **Spring Boot 3** (Java), estructurado en controladores web, entidades JPA (API de java para representar tablas de modelos relacionales) y repositorios/interfaces de JPA.
* **Base de Datos:** **Base de datos de Oracle de la universidad**, encargada del almacenamiento relacional (16 entidades principales + tabla de auditoría (donde se registran los cambios en los datos)) y de la ejecución de reglas de negocio mediante funciones y triggers PL/SQL.

---

## 2. Flujo de Comunicación y Conexión a Base de Datos

1. **Conexión JDBC / JPA:** Spring Boot se conecta a Oracle mediante el driver oficial `ojdbc` configurado en `application.properties`, gestionando la conexión a través de Spring Data JPA.
2. **Petición del Usuario:** Cuando un administrador navega por el portal (por ejemplo, consultando catálogos, posiciones o validando una convocatoria), el navegador envía una petición HTTP (`GET`) al controlador correspondiente.
3. **Procesamiento en Repositorios:** El controlador solicita los datos a la capa de repositorios:
   * Para consultas estándar de catálogos, utiliza métodos heredados de `JpaRepository` (`findAll()`).
   * Para reportes analíticos y llamados a lógica almacenada, ejecuta consultas SQL nativas mediante `@Query`.
4. **Renderizado:** El controlador inyecta los resultados en el objeto `Model` de Spring y Thymeleaf renderiza la vista HTML final hacia el navegador.

---

## 3. Estructura de Capas del Backend

### A. Controladores (`com.mundial.app.controller`)
* **`CatalogoController`:** Gestiona las rutas de consulta de los 9 catálogos principales del torneo (`/ediciones`, `/sedes`, `/ciudades`, `/estadios`, `/grupos`, `/selecciones`, `/jugadores`, `/convocatorias` y `/partidos`).
* **`ReporteController`:** Gestiona la pantalla principal (`/`), los reportes estadísticos (`/reportes/posiciones`, `/reportes/goleadores`), el visor de auditoría (`/reportes/incidencias`) y el módulo de control normativo (`/pruebas/plsql` y `/pruebas/ejecutar`). Captura excepciones provenientes de Oracle para presentar mensajes claros al usuario.

### B. Repositorios (`com.mundial.app.repository`)
* **Repositorios de Entidad (16 interfaces):** Respaldan cada tabla del modelo relacional (`EdicionMundialRepository`, `SeleccionRepository`, `JugadorRepository`, `PartidoRepository`, etc.).
* **`ReporteRepository`:** Ejecuta consultas SQL nativas con agregaciones y cruces (`JOIN`) para construir la tabla de posiciones, el ranking de goleadores y el historial de actividad.
* **`PlSqlFunctionRepository`:** Sirve como puente directo entre Java y las funciones almacenadas en Oracle.

---

## 4. Consultas SQL Clave Implementadas en Java

### Tabla de Posiciones (`ReporteRepository`)
Cruza las selecciones con sus participaciones en partidos frente a sus rivales para calcular partidos jugados, ganados, empatados, perdidos, goles y puntos, invocando además la función almacenada de diferencia de gol:

```sql
SELECT 
    s.id_seleccion,
    s.pais,
    g.nombre AS grupo,
    COUNT(pp.id_partido) AS pj,
    SUM(CASE WHEN pp.goles_marcados > rival.goles_marcados THEN 1 ELSE 0 END) AS pg,
    SUM(CASE WHEN pp.goles_marcados = rival.goles_marcados THEN 1 ELSE 0 END) AS pe,
    SUM(CASE WHEN pp.goles_marcados < rival.goles_marcados THEN 1 ELSE 0 END) AS pp,
    COALESCE(SUM(pp.goles_marcados), 0) AS gf,
    COALESCE(SUM(rival.goles_marcados), 0) AS gc,
    fn_diferencia_gol_seleccion(s.id_seleccion) AS dg,
    SUM(CASE 
        WHEN pp.goles_marcados > rival.goles_marcados THEN 3
        WHEN pp.goles_marcados = rival.goles_marcados THEN 1
        ELSE 0 
    END) AS pts
FROM seleccion s
LEFT JOIN grupo g ON s.id_grupo = g.id_grupo
LEFT JOIN participacion_partido pp ON s.id_seleccion = pp.id_seleccion
LEFT JOIN participacion_partido rival ON pp.id_partido = rival.id_partido AND pp.id_seleccion <> rival.id_seleccion
GROUP BY s.id_seleccion, s.pais, g.nombre
ORDER BY g.nombre ASC, pts DESC, dg DESC
```

### Ranking de Goleadores (`ReporteRepository`)
Consolida los goles y asistencias individuales por jugador y selección:

```sql
SELECT 
    j.nombre AS jugador,
    s.pais AS seleccion,
    SUM(e.goles) AS total_goles,
    SUM(e.asistencias) AS total_asistencias
FROM estadistica_jugador_partido e
JOIN jugador j ON e.id_jugador = j.id_jugador
JOIN convocatoria_jugador c ON j.id_jugador = c.id_jugador
JOIN seleccion s ON c.id_seleccion = s.id_seleccion
GROUP BY j.id_jugador, j.nombre, s.pais
HAVING SUM(e.goles) > 0
ORDER BY total_goles DESC, total_asistencias DESC
```

### Consulta de Trazabilidad (`ReporteRepository`)
Obtiene los eventos registrados automáticamente por los triggers de auditoría:

```sql
SELECT id_auditoria, tabla_afectada, operacion, id_registro, usuario_bd, fecha_operacion, detalle
FROM auditoria_bd
ORDER BY fecha_operacion DESC
```

---

## 5. Integración de Lógica de Base de Datos (Funciones y Triggers)

### Uso de Funciones PL/SQL en la Aplicación
Las funciones encapsulan cálculos y validaciones reglamentarias invocadas directamente desde los repositorios Java:

| Función PL/SQL | Módulo Web donde se utiliza | Propósito en la Aplicación |
| :--- | :--- | :--- |
| `fn_diferencia_gol_seleccion` | **Tabla de Posiciones** (`/reportes/posiciones`) | Calcula la diferencia neta ($GF - GC$) de cada selección para ordenarla en la clasificación. |
| `fn_validar_cupo_convocatoria` | **Control Normativo** (`/pruebas/plsql`) | Verifica en tiempo real si una selección cumple con el límite máximo de jugadores inscritos (26 por defecto). |
| `fn_verificar_dorsal_disponible` | **Control Normativo** (`/pruebas/plsql`) | Valida que el número de dorsal esté en un rango reglamentario (1–99) y que no esté asignado a otro futbolista de la misma selección. |

### Funcionamiento de los Triggers en el Sistema
Los triggers operan de forma automática y transparente en Oracle 19c ante operaciones de escritura (`INSERT`, `UPDATE`, `DELETE`), protegiendo la integridad de los datos sin depender de validaciones exclusivas del frontend:

| Trigger | Tabla Vigilada | Integración y Efecto en la Plataforma |
| :--- | :--- | :--- |
| `trg_auditoria_partido` | `PARTIDO` | Registra automáticamente cada creación, edición o eliminación de partidos en `auditoria_bd`, alimentando la pantalla **Registro de Actividad**. |
| `trg_auditoria_estadisticas` | `ESTADISTICA_JUGADOR_PARTIDO` | Registra automáticamente cualquier cambio en goles o asistencias individuales en `auditoria_bd`, visible en **Registro de Actividad**. |
| `trg_validacion_rangos` | `ESTADISTICA_JUGADOR_PARTIDO` | Impide almacenar goles o asistencias negativas (`ORA-20001` / `ORA-20002`), protegiendo la exactitud del ranking de goleadores. |
| `trg_anti_duplicidad` | `PARTICIPACION_PARTIDO` | Evita que una misma selección sea registrada dos veces en un mismo encuentro (`ORA-20003`), garantizando la consistencia de la tabla de posiciones. |
| `trg_consistencia_goles` | `ESTADISTICA_JUGADOR_PARTIDO` | Asegura que la suma de goles individuales de los jugadores no supere el marcador oficial del equipo en el partido (`ORA-20004`). |
