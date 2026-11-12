package com.mundial.app.repository;
import com.mundial.app.model.Grupo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface GrupoRepository extends JpaRepository<Grupo, Long> {
    
}