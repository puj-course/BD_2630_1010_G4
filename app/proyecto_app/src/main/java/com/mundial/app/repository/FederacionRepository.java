package com.mundial.app.repository;
import com.mundial.app.model.Federacion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface FederacionRepository extends JpaRepository<Federacion, Long> {
    
}