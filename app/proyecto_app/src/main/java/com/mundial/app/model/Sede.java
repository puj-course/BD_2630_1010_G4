package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "SEDE")
public class Sede {

    @Id
    @Column(name = "id_sede")
    private Long idSede;

    @Column(name = "id_edicion", nullable = false)
    private Long idEdicion;

    @Column(name = "pais", nullable = false)
    private String pais;

    public Sede() {}

    // Getters y Setters
    public Long getIdSede() { return idSede; }
    public void setIdSede(Long idSede) { this.idSede = idSede; }
    public Long getIdEdicion() { return idEdicion; }
    public void setIdEdicion(Long idEdicion) { this.idEdicion = idEdicion; }
    public String getPais() { return pais; }
    public void setPais(String pais) { this.pais = pais; }
}