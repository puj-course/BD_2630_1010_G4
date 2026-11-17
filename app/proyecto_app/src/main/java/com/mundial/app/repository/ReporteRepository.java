package com.mundial.app.repository;

import com.mundial.app.model.Seleccion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReporteRepository extends JpaRepository<Seleccion, Long> {

    // 1. Tabla de Posiciones Oficial
    @Query(value = """
        SELECT 
            s.id_seleccion,
            s.pais,
            g.nombre AS grupo,
            COUNT(pp.id_partido) AS pj,
            SUM(CASE WHEN pp.goles_marcados > rival.goles_marcados THEN 1 ELSE 0 END) AS pg,
            SUM(CASE WHEN pp.goles_marcados = rival.goles_marcados THEN 1 ELSE 0 END) AS pe,
            SUM(CASE WHEN pp.goles_marcados < rival.goles_marcados THEN 1 ELSE 0 END) AS pp,
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
        """, nativeQuery = true)
    List<Object[]> obtenerTablaPosiciones();

    // 2. Ranking de Goleadores (Corregido sin campos inválidos)
    @Query(value = """
        SELECT 
            j.nombre AS jugador,
            s.pais AS seleccion,
            SUM(e.goles) AS total_goles,
            SUM(e.asistencias) AS total_asistencias
        FROM estadistica_jugador_partido e
        JOIN convocatoria_jugador c ON e.id_jugador = c.id_jugador
        JOIN jugador j ON c.id_jugador = j.id_jugador
        JOIN seleccion s ON c.id_seleccion = s.id_seleccion
        GROUP BY j.nombre, s.pais
        HAVING SUM(e.goles) > 0
        ORDER BY total_goles DESC, total_asistencias DESC
        """, nativeQuery = true)
    List<Object[]> obtenerGoleadores();

    // 3. Registro de Actividad y Trazabilidad del Torneo
    @Query(value = """
        SELECT id_auditoria, tabla_afectada, operacion, id_registro, usuario_bd, TO_CHAR(fecha_operacion, 'YYYY-MM-DD HH24:MI:SS') AS fecha, detalle
        FROM auditoria_bd
        ORDER BY fecha_operacion DESC
        """, nativeQuery = true)
    List<Object[]> obtenerIncidenciasAuditoria();
}