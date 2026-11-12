package com.mundial.app.repository;
import com.mundial.app.model.Fase;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface FaseRepository extends JpaRepository<Fase, Long> {
    
}