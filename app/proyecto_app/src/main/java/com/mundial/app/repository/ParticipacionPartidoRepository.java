package com.mundial.app.repository;

import com.mundial.app.model.ParticipacionPartido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ParticipacionPartidoRepository extends JpaRepository<ParticipacionPartido, Long> {
}