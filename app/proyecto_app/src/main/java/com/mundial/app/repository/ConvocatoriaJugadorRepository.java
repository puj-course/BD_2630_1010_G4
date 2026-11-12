package com.mundial.app.repository;
import com.mundial.app.model.ConvocatoriaJugador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface ConvocatoriaJugadorRepository extends JpaRepository<ConvocatoriaJugador, Long> {}