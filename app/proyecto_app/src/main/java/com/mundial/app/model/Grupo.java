package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "GRUPO")
public class Grupo {

    @Id
    @Column(name = "id_grupo")
    private Long idGrupo;

    @Column(name = "id_edicion", nullable = false)
    private Long idEdicion;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    public Grupo() {}

    // Getters y Setters
    public Long getIdGrupo() { return idGrupo; }
    public void setIdGrupo(Long idGrupo) { this.idGrupo = idGrupo; }
    public Long getIdEdicion() { return idEdicion; }
    public void setIdEdicion(Long idEdicion) { this.idEdicion = idEdicion; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
}