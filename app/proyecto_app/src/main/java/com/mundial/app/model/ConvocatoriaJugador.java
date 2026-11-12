package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "CONVOCATORIA_JUGADOR")
public class ConvocatoriaJugador {

    @Id
    @Column(name = "id_convocatoria")
    private Long idConvocatoria;

    @Column(name = "id_jugador", nullable = false)
    private Long idJugador;

    @Column(name = "id_seleccion", nullable = false)
    private Long idSeleccion;

    @Column(name = "dorsal", nullable = false)
    private Integer dorsal;

    @Column(name = "es_capitan", nullable = false)
    private String esCapitan; // 'SI' o 'NO'

    public ConvocatoriaJugador() {}

    // Getters y Setters
    public Long getIdConvocatoria() { return idConvocatoria; }
    public void setIdConvocatoria(Long idConvocatoria) { this.idConvocatoria = idConvocatoria; }
    public Long getIdJugador() { return idJugador; }
    public void setIdJugador(Long idJugador) { this.idJugador = idJugador; }
    public Long getIdSeleccion() { return idSeleccion; }
    public void setIdSeleccion(Long idSeleccion) { this.idSeleccion = idSeleccion; }
    public Integer getDorsal() { return dorsal; }
    public void setDorsal(Integer dorsal) { this.dorsal = dorsal; }
    public String getEsCapitan() { return esCapitan; }
    public void setEsCapitan(String esCapitan) { this.esCapitan = esCapitan; }
}