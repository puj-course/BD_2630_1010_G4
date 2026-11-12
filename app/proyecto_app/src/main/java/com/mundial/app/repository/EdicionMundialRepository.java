package com.mundial.app.repository;

import com.mundial.app.model.EdicionMundial;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EdicionMundialRepository extends JpaRepository<EdicionMundial, Long> {}