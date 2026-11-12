package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "FEDERACION")
public class Federacion {

    @Id
    @Column(name = "id_federacion")
    private Long idFederacion;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "sigla", nullable = false)
    private String sigla;

    @Column(name = "confederacion", nullable = false)
    private String confederacion;

    public Federacion() {}

    // Getters y Setters
    public Long getIdFederacion() { return idFederacion; }
    public void setIdFederacion(Long idFederacion) { this.idFederacion = idFederacion; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getSigla() { return sigla; }
    public void setSigla(String sigla) { this.sigla = sigla; }
    public String getConfederacion() { return confederacion; }
    public void setConfederacion(String confederacion) { this.confederacion = confederacion; }
}