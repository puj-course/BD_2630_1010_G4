package com.mundial.app.repository;

import com.mundial.app.model.Estadio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EstadioRepository extends JpaRepository<Estadio, Long> {
    // Spring genera el CRUD automáticamente
}