package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "INCIDENCIA")
public class Incidencia {

    @Id
    @Column(name = "id_incidencia")
    private Long idIncidencia;

    @Column(name = "id_partido", nullable = false)
    private Long idPartido;

    @Column(name = "tipo", nullable = false)
    private String tipo;

    @Column(name = "descripcion")
    private String descripcion;

    @Column(name = "minuto")
    private Integer minuto;

    public Incidencia() {}

    // Getters y Setters
    public Long getIdIncidencia() { return idIncidencia; }
    public void setIdIncidencia(Long idIncidencia) { this.idIncidencia = idIncidencia; }
    public Long getIdPartido() { return idPartido; }
    public void setIdPartido(Long idPartido) { this.idPartido = idPartido; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public Integer getMinuto() { return minuto; }
    public void setMinuto(Integer minuto) { this.minuto = minuto; }
}