package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "SELECCION")
public class Seleccion {

    @Id
    @Column(name = "id_seleccion")
    private Long idSeleccion;

    @Column(name = "id_edicion")
    private Long idEdicion;

    @Column(name = "id_federacion")
    private Long idFederacion;

    @Column(name = "id_grupo")
    private Long idGrupo;

    @Column(name = "pais", nullable = false)
    private String pais;

    public Seleccion() {}

    // Getters y Setters
    public Long getIdSeleccion() { return idSeleccion; }
    public void setIdSeleccion(Long idSeleccion) { this.idSeleccion = idSeleccion; }
    public Long getIdEdicion() { return idEdicion; }
    public void setIdEdicion(Long idEdicion) { this.idEdicion = idEdicion; }
    public Long getIdFederacion() { return idFederacion; }
    public void setIdFederacion(Long idFederacion) { this.idFederacion = idFederacion; }
    public Long getIdGrupo() { return idGrupo; }
    public void setIdGrupo(Long idGrupo) { this.idGrupo = idGrupo; }
    public String getPais() { return pais; }
    public void setPais(String pais) { this.pais = pais; }
}