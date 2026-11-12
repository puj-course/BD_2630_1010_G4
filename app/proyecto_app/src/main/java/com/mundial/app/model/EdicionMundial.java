package com.mundial.app.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "EDICION_MUNDIAL")
public class EdicionMundial {

    @Id
    @Column(name = "id_edicion")
    private Long idEdicion;

    @Column(name = "anio", nullable = false)
    private Integer anio;

    @Column(name = "lema")
    private String lema;

    @Column(name = "fecha_inicio", nullable = false)
    private LocalDate fechaInicio;

    @Column(name = "fecha_fin", nullable = false)
    private LocalDate fechaFin;

    public EdicionMundial() {}

    // Getters y Setters
    public Long getIdEdicion() { return idEdicion; }
    public void setIdEdicion(Long idEdicion) { this.idEdicion = idEdicion; }
    public Integer getAnio() { return anio; }
    public void setAnio(Integer anio) { this.anio = anio; }
    public String getLema() { return lema; }
    public void setLema(String lema) { this.lema = lema; }
    public LocalDate getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(LocalDate fechaInicio) { this.fechaInicio = fechaInicio; }
    public LocalDate getFechaFin() { return fechaFin; }
    public void setFechaFin(LocalDate fechaFin) { this.fechaFin = fechaFin; }
}