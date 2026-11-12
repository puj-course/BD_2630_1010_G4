package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "ESTADIO")
public class Estadio {

    @Id
    @Column(name = "id_estadio")
    private Long idEstadio;

    @Column(name = "id_ciudad")
    private Long idCiudad;

    @Column(name = "id_edicion")
    private Long idEdicion;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "capacidad", nullable = false)
    private Integer capacidad;

    public Estadio() {}

    // Getters y Setters
    public Long getIdEstadio() { return idEstadio; }
    public void setIdEstadio(Long idEstadio) { this.idEstadio = idEstadio; }
    public Long getIdCiudad() { return idCiudad; }
    public void setIdCiudad(Long idCiudad) { this.idCiudad = idCiudad; }
    public Long getIdEdicion() { return idEdicion; }
    public void setIdEdicion(Long idEdicion) { this.idEdicion = idEdicion; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public Integer getCapacidad() { return capacidad; }
    public void setCapacidad(Integer capacidad) { this.capacidad = capacidad; }
}