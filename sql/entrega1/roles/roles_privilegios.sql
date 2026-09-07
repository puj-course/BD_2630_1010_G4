
    //ARCHIVO: sql/entrega1/roles/roles_privilegios.sql
    CREATE ROLE rol_consulta;
    CREATE ROLE rol_operador_partido;
    
    //premisos lectura
    GRANT SELECT ON EDICION_MUNDIAL TO rol_consulta;
    GRANT SELECT ON ESTADIO TO rol_consulta;
    GRANT SELECT ON SELECCION TO rol_consulta;
    GRANT SELECT ON PARTIDO TO rol_consulta;
    GRANT SELECT ON PARTICIPACION_PARTIDO TO rol_consulta;


//Actualizar y modificar partidos y marcadoress
        GRANT SELECT ON EDICION_MUNDIAL TO rol_operador_partido;
        GRANT SELECT ON ESTADIO TO rol_operador_partido;
        GRANT SELECT ON SELECCION TO rol_operador_partido;   
        GRANT SELECT, INSERT, UPDATE ON PARTIDO TO rol_operador_partido;
        
        GRANT SELECT, INSERT, UPDATE ON PARTICIPACION_PARTIDO TO rol_operador_partido;
      
    
    //grant a la vista antigua
    GRANT SELECT ON v_partido_completo TO rol_operador_partido;
    //no debe cambiar fechas de partidos 
    REVOKE UPDATE ON PARTIDO FROM rol_operador_partido;
    
    //prueba
    SELECT role, table_name, privilege 
    FROM role_tab_privs 
    WHERE role IN ('ROL_CONSULTA', 'ROL_OPERADOR_PARTIDO')
    ORDER BY role, table_name, privilege;
//Puede usar la vista
SELECT * FROM v_partido_completo;

//inserta datos
INSERT INTO SELECCION (id_seleccion, id_edicion, pais, confederacion, grupo)
VALUES (99, 1, 'País Prueba', 'CONMEBOL', 'A');
// falla por solo lectura

//el arbitraje puede modificar marcador y esta permitido
UPDATE PARTICIPACION_PARTIDO 
SET goles_marcados = 2 
WHERE id_participacion = 1;

// actualizar paritdo pero solo en tabla propia
UPDATE PARTIDO 
SET fase = 'FINAL' 
WHERE id_partido = 1;


//Se bloquea 
DELETE FROM PARTIDO WHERE id_partido = 1;
