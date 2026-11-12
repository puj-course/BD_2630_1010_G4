package com.mundial.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "ESTADISTICA_JUGADOR_PARTIDO")
public class EstadisticaJugadorPartido {

    @Id
    @Column(name = "id_estadistica")
    private Long idEstadistica;

    @Column(name = "id_partido", nullable = false)
    private Long idPartido;

    @Column(name = "id_jugador", nullable = false)
    private Long idJugador;

    @Column(name = "goles", nullable = false)
    private Integer goles;

    @Column(name = "asistencias", nullable = false)
    private Integer asistencias;

    @Column(name = "tarjetas_amarillas", nullable = false)
    private Integer tarjetasAmarillas;

    @Column(name = "tarjetas_rojas", nullable = false)
    private Integer tarjetasRojas;

    @Column(name = "tiros", nullable = false)
    private Integer tiros;

    @Column(name = "minutos_jugados", nullable = false)
    private Integer minutosJugados;

    public EstadisticaJugadorPartido() {}

    // Getters y Setters
    public Long getIdEstadistica() { return idEstadistica; }
    public void setIdEstadistica(Long idEstadistica) { this.idEstadistica = idEstadistica; }
    public Long getIdPartido() { return idPartido; }
    public void setIdPartido(Long idPartido) { this.idPartido = idPartido; }
    public Long getIdJugador() { return idJugador; }
    public void setIdJugador(Long idJugador) { this.idJugador = idJugador; }
    public Integer getGoles() { return goles; }
    public void setGoles(Integer goles) { this.goles = goles; }
    public Integer getAsistencias() { return asistencias; }
    public void setAsistencias(Integer asistencias) { this.asistencias = asistencias; }
    public Integer getTarjetasAmarillas() { return tarjetasAmarillas; }
    public void setTarjetasAmarillas(Integer tarjetasAmarillas) { this.tarjetasAmarillas = tarjetasAmarillas; }
    public Integer getTarjetasRojas() { return tarjetasRojas; }
    public void setTarjetasRojas(Integer tarjetasRojas) { this.tarjetasRojas = tarjetasRojas; }
    public Integer getTiros() { return tiros; }
    public void setTiros(Integer tiros) { this.tiros = tiros; }
    public Integer getMinutosJugados() { return minutosJugados; }
    public void setMinutosJugados(Integer minutosJugados) { this.minutosJugados = minutosJugados; }
}