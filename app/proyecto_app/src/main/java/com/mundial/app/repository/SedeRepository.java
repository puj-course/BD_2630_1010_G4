package com.mundial.app.repository;
import com.mundial.app.model.Sede;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
@Repository
public interface SedeRepository extends JpaRepository<Sede, Long> {

    
}