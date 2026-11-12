package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "CIUDAD")
public class Ciudad {

    @Id
    @Column(name = "id_ciudad")
    private Long idCiudad;

    @Column(name = "id_sede", nullable = false)
    private Long idSede;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    public Ciudad() {}

    // Getters y Setters
    public Long getIdCiudad() { return idCiudad; }
    public void setIdCiudad(Long idCiudad) { this.idCiudad = idCiudad; }
    public Long getIdSede() { return idSede; }
    public void setIdSede(Long idSede) { this.idSede = idSede; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
}