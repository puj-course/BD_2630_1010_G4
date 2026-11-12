package com.mundial.app.repository;
import com.mundial.app.model.Ciudad;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface CiudadRepository extends JpaRepository<Ciudad, Long> {
    
}