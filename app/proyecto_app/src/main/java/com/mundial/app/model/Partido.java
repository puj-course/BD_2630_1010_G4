package com.mundial.app.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "PARTIDO")
public class Partido {

    @Id
    @Column(name = "id_partido")
    private Long idPartido;

    @Column(name = "id_edicion")
    private Long idEdicion;

    @Column(name = "id_fase")
    private Long idFase;

    @Column(name = "id_estadio")
    private Long idEstadio;

    @Column(name = "fecha_hora", nullable = false)
    private LocalDateTime fechaHora;

    @Column(name = "asistencia_registrada")
    private Integer asistenciaRegistrada;

    public Partido() {}

    // Getters y Setters
    public Long getIdPartido() { return idPartido; }
    public void setIdPartido(Long idPartido) { this.idPartido = idPartido; }
    public Long getIdEdicion() { return idEdicion; }
    public void setIdEdicion(Long idEdicion) { this.idEdicion = idEdicion; }
    public Long getIdFase() { return idFase; }
    public void setIdFase(Long idFase) { this.idFase = idFase; }
    public Long getIdEstadio() { return idEstadio; }
    public void setIdEstadio(Long idEstadio) { this.idEstadio = idEstadio; }
    public LocalDateTime getFechaHora() { return fechaHora; }
    public void setFechaHora(LocalDateTime fechaHora) { this.fechaHora = fechaHora; }
    public Integer getAsistenciaRegistrada() { return asistenciaRegistrada; }
    public void setAsistenciaRegistrada(Integer asistenciaRegistrada) { this.asistenciaRegistrada = asistenciaRegistrada; }
}