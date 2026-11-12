package com.mundial.app.repository;

import com.mundial.app.model.EstadisticaJugadorPartido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EstadisticaJugadorPartidoRepository extends JpaRepository<EstadisticaJugadorPartido, Long> {}