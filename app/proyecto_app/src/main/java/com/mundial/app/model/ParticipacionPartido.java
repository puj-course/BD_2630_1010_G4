package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "PARTICIPACION_PARTIDO")
public class ParticipacionPartido {

    @Id
    @Column(name = "id_participacion")
    private Long idParticipacion;

    @Column(name = "id_partido", nullable = false)
    private Long idPartido;

    @Column(name = "id_seleccion", nullable = false)
    private Long idSeleccion;

    @Column(name = "condicion", nullable = false)
    private String condicion; // 'LOCAL' o 'VISITANTE'

    @Column(name = "goles_marcados", nullable = false)
    private Integer golesMarcados;

    public ParticipacionPartido() {}

    // Getters y Setters
    public Long getIdParticipacion() { return idParticipacion; }
    public void setIdParticipacion(Long idParticipacion) { this.idParticipacion = idParticipacion; }
    public Long getIdPartido() { return idPartido; }
    public void setIdPartido(Long idPartido) { this.idPartido = idPartido; }
    public Long getIdSeleccion() { return idSeleccion; }
    public void setIdSeleccion(Long idSeleccion) { this.idSeleccion = idSeleccion; }
    public String getCondicion() { return condicion; }
    public void setCondicion(String condicion) { this.condicion = condicion; }
    public Integer getGolesMarcados() { return golesMarcados; }
    public void setGolesMarcados(Integer golesMarcados) { this.golesMarcados = golesMarcados; }
}