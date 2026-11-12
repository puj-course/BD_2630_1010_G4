package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "ASIGNACION_ARBITRAL")
public class AsignacionArbitral {

    @Id
    @Column(name = "id_asignacion")
    private Long idAsignacion;

    @Column(name = "id_arbitro", nullable = false)
    private Long idArbitro;

    @Column(name = "id_partido", nullable = false)
    private Long idPartido;

    @Column(name = "rol", nullable = false)
    private String rol;

    public AsignacionArbitral() {}

    // Getters y Setters
    public Long getIdAsignacion() { return idAsignacion; }
    public void setIdAsignacion(Long idAsignacion) { this.idAsignacion = idAsignacion; }
    public Long getIdArbitro() { return idArbitro; }
    public void setIdArbitro(Long idArbitro) { this.idArbitro = idArbitro; }
    public Long getIdPartido() { return idPartido; }
    public void setIdPartido(Long idPartido) { this.idPartido = idPartido; }
    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }
}