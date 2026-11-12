package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "FASE")
public class Fase {

    @Id
    @Column(name = "id_fase")
    private Long idFase;

    @Column(name = "id_edicion", nullable = false)
    private Long idEdicion;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "tipo", nullable = false)
    private String tipo;

    public Fase() {}

    // Getters y Setters
    public Long getIdFase() { return idFase; }
    public void setIdFase(Long idFase) { this.idFase = idFase; }
    public Long getIdEdicion() { return idEdicion; }
    public void setIdEdicion(Long idEdicion) { this.idEdicion = idEdicion; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
}