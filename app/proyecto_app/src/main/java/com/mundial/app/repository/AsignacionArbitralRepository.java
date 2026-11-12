package com.mundial.app.repository;
import com.mundial.app.model.AsignacionArbitral;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface AsignacionArbitralRepository extends JpaRepository<AsignacionArbitral, Long> {
    
}