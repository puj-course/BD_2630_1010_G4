package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "ARBITRO")
public class Arbitro {

    @Id
    @Column(name = "id_arbitro")
    private Long idArbitro;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "nacionalidad", nullable = false)
    private String nacionalidad;

    public Arbitro() {}

    // Getters y Setters
    public Long getIdArbitro() { return idArbitro; }
    public void setIdArbitro(Long idArbitro) { this.idArbitro = idArbitro; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getNacionalidad() { return nacionalidad; }
    public void setNacionalidad(String nacionalidad) { this.nacionalidad = nacionalidad; }
}