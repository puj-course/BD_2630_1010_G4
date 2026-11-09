package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "ESTADIO")
public class Estadio {

    @Id
    @Column(name = "id_estadio")
    private Long idEstadio;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "capacidad")
    private Integer capacidad;

    // Constructor vacío obligatorio para JPA
    public Estadio() {}

    // Getters y Setters
    public Long getIdEstadio() { return idEstadio; }
    public void setIdEstadio(Long idEstadio) { this.idEstadio = idEstadio; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public Integer getCapacidad() { return capacidad; }
    public void setCapacidad(Integer capacidad) { this.capacidad = capacidad; }
}