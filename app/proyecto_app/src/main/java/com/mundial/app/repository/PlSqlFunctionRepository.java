package com.mundial.app.repository;

import com.mundial.app.model.Seleccion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface PlSqlFunctionRepository extends JpaRepository<Seleccion, Long> {

    // 1. fn_diferencia_gol_seleccion
    @Query(value = "SELECT fn_diferencia_gol_seleccion(:p_id_seleccion) FROM DUAL", nativeQuery = true)
    Integer ejecutarDiferenciaGol(@Param("p_id_seleccion") Long pIdSeleccion);

    // 2. fn_validar_cupo_convocatoria
    @Query(value = "SELECT fn_validar_cupo_convocatoria(:p_id_seleccion, :p_limite_maximo) FROM DUAL", nativeQuery = true)
    String ejecutarValidarCupoConvocatoria(@Param("p_id_seleccion") Long pIdSeleccion, 
    @Param("p_limite_maximo") Integer pLimiteMaximo);

    // 3. fn_verificar_dorsal_disponible
    @Query(value = "SELECT fn_verificar_dorsal_disponible(:p_id_seleccion, :p_dorsal, :p_id_jugador) FROM DUAL", nativeQuery = true)
    String ejecutarVerificarDorsalDisponible(@Param("p_id_seleccion") Long pIdSeleccion, 
    @Param("p_dorsal") Integer pDorsal, @Param("p_id_jugador") Long pIdJugador);
}