# BD_PROYECTO — Repositorio del Equipo
## Sistema de Información para la Gestión Integral de la Copa Mundial de la FIFA

Este repositorio se utiliza para desarrollar el proyecto de Bases de Datos desde la Semana 4 hasta la Semana 16 del curso, cubriendo la Entrega 1, la Entrega 2 y la Entrega 3, usando Git como herramienta de seguimiento del progreso.

Este README es el documento principal de lineamientos. Existen dos documentos complementarios:

- **README_CRONOGRAMA.md** — detalle semana a semana de entregables, nombres de archivo, contenido esperado y estructura de carpetas.
- **README_SERVIDOR_ENTREGA1.md** — guía de conexión al servidor de base de datos dispuesto por el curso para la Entrega 1 (modelo inicial).

Lee los tres documentos antes de empezar a trabajar.

---

## Contexto académico

El proyecto se basa en el enunciado "Sistema de Información para la Gestión Integral de la Copa Mundial de la FIFA" (Ing. Luis Gabriel Moreno Sandoval, PhD. — Bases de Datos, PUJ). El trabajo se organiza según el siguiente cronograma académico del curso:

| Entrega | Semanas académicas | Semanas de trabajo | Cierre |
|---|---|---|---|
| Entrega 1 | Semana 4 a Semana 7 | 4 semanas | Semana 8 |
| Entrega 2 | Semana 9 a Semana 12 | 4 semanas | Semana 13 |
| Entrega 3 | Semana 14 a Semana 16 | 3 semanas | Semana 17 |

El detalle de qué se entrega cada semana específica está en README_CRONOGRAMA.md.

---

## Metodología de Trabajo

### 1. Trabajo por Ramas

Cada tarea/entregable debe realizarse en una rama diferente, creada a partir de `main`.

**Nombre sugerido:**
```
feature/<descripcion>
```

**Ejemplos:**
```
feature/consultas-joins-semana1
feature/modelo-logico
feature/triggers-auditoria
feature/documento-tecnico
```

#### Flujo recomendado:

**1. Crear la rama desde `main`**
```bash
git checkout main
git pull
git checkout -b feature/nombre-tarea
```

**2. Commits del progreso** (frecuentes, no solo uno al final de la semana)
```bash
git add .
git commit -m "Mensaje de commit descriptivo"
```

**3. Subir la rama al repositorio:**
```bash
git push origin feature/nombre-tarea
```

**4. Crear un Pull Request** para integrar los cambios en `main`, y fusionarlo antes del cierre de la semana correspondiente.

---

### 2. Registro del Progreso — CHANGELOG.md

Cada semana (de las 12 semanas de trabajo del proyecto) se debe actualizar el archivo `CHANGELOG.md` agregando una nueva entrada, sin borrar las anteriores. Formato sugerido por semana:

```markdown
## Semana X — Entrega Y — [rango de fechas]

Objetivos: metas de la semana según README_CRONOGRAMA.md

Tareas realizadas: lo que se completó (con referencia a los archivos/carpetas entregados)

Responsables: integrantes a cargo de cada tarea

Ramas utilizadas: nombres de las ramas creadas/fusionadas esta semana

Problemas: inconvenientes encontrados y cómo se resolvieron (o si siguen pendientes)
```

Este registro, junto con los commits y Pull Requests, es la evidencia principal de que todos los integrantes participaron de forma semanal.

---

## Ventana de tiempo válida para el aporte semanal

Cada semana de trabajo del proyecto se evalúa dentro de la ventana:

```
Lunes 12:00 a.m. (00:00) — Domingo 11:59 p.m. (23:59), hora Colombia (UTC-5)
```

Los commits, ramas, Pull Requests y la actualización del `CHANGELOG.md` deben quedar registrados dentro de esa ventana para contar como aporte de esa semana específica.

---

## Evaluación del progreso semanal

El progreso del repositorio se revisa de forma semanal, considerando la actividad registrada en el historial de Git (commits, ramas, Pull Requests), la actualización del `CHANGELOG.md`, y la revisión del contenido técnico entregado.

Es indispensable seguir exactamente los nombres de archivo, extensiones y rutas indicadas en README_CRONOGRAMA.md.

No seguir los nombres de archivo, formatos o ubicaciones especificadas en README_CRONOGRAMA.md baja la nota, incluso si el contenido técnico es correcto, porque dificulta tanto la revisión manual como la automática.

---

## Participación individual

Es requisito indispensable que todos los integrantes registren actividad semanal verificable en el repositorio (commits con su propio correo, contribuciones en ramas, participación en Pull Requests o registro en el CHANGELOG). Los integrantes que no demuestren avances semanales verificables no serán tenidos en cuenta en la calificación de la entrega correspondiente.

---

## Estructura General de Carpetas del Proyecto

```text
BD_PROYECTO/
│
├── app/                          ---> Entrega 3 (aplicación funcional)
│
├── docs/                         ---> Documentos, modelos, diagramas, diccionario de datos
│   ├── entrega1/
│   ├── entrega2/
│   └── entrega3/
│
├── sql/
│   ├── entrega1/
│   │   ├── consultas/
│   │   ├── ddl/
│   │   ├── dml/
│   │   ├── vistas/
│   │   ├── roles/
│   │   └── algebra_relacional/
│   │
│   ├── entrega2/
│   │   ├── consultas/
│   │   ├── ddl/
│   │   ├── dml/
│   │   └── roles/
│   │
│   └── entrega3/
│       ├── funciones/
│       ├── procedimientos/
│       └── triggers/
│
├── tests/
│   ├── entrega1/
│   ├── entrega2/
│   └── entrega3/
│
├── .gitignore
├── CHANGELOG.md
├── README.md
├── README_CRONOGRAMA.md
└── README_SERVIDOR_ENTREGA1.md
```

El detalle exacto de qué archivo va dentro de cada subcarpeta, semana a semana, está en README_CRONOGRAMA.md. Esa estructura es la que se debe seguir de forma precisa.

---

## Contacto

De presentar alguna inquietud con respecto al proyecto, uso de Git para este o los parámetros planteados, contactar a la monitora:

**Viviana Gómez**
Teams o Correo: [gomezlv@javeriana.edu.co](mailto:gomezlv@javeriana.edu.co)
