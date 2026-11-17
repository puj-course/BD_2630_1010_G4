package com.mundial.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mundial.app.repository.PlSqlFunctionRepository;
import com.mundial.app.repository.ReporteRepository;

@Controller
public class ReporteController {

    @Autowired
    private ReporteRepository reporteRepository;

    @Autowired
    private PlSqlFunctionRepository plSqlRepo;

    @GetMapping("/")
    public String inicio() {
        return "index";
    }

    @GetMapping("/reportes/posiciones")
    public String verTablaPosiciones(Model model) {
        try {
            model.addAttribute("tablaPosiciones", reporteRepository.obtenerTablaPosiciones());
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar la tabla de posiciones: " + e.getMessage());
        }
        return "tabla_posiciones";
    }

    @GetMapping("/reportes/goleadores")
    public String verGoleadores(Model model) {
        try {
            model.addAttribute("goleadores", reporteRepository.obtenerGoleadores());
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar el ranking de goleadores: " + e.getMessage());
        }
        return "goleadores";
    }

    @GetMapping("/reportes/incidencias")
    public String verIncidencias(Model model) {
        try {
            model.addAttribute("incidencias", reporteRepository.obtenerIncidenciasAuditoria());
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar las incidencias de auditoría: " + e.getMessage());
        }
        return "incidencias";
    }

    @GetMapping("/pruebas/plsql")
    public String verPanelPruebas() {
        return "prueba_plsql";
    }

    @GetMapping("/pruebas/ejecutar")
    public String probarFunciones(
            @RequestParam(required = false) Long idSeleccion,
            @RequestParam(required = false) Long idJugador,
            @RequestParam(required = false) Integer dorsal,
            @RequestParam(required = false) Integer limiteMaximo,
            Model model) {

        try {
            if (idSeleccion != null) {
                int limite = (limiteMaximo != null) ? limiteMaximo : 26;
                String cupo = plSqlRepo.ejecutarValidarCupoConvocatoria(idSeleccion, limite);
                model.addAttribute("resultadoCupo", "Validación de cupo (Límite " + limite + ") = " + cupo);
            }

            if (idSeleccion != null && dorsal != null) {
                String estadoDorsal = plSqlRepo.ejecutarVerificarDorsalDisponible(idSeleccion, dorsal, idJugador);
                model.addAttribute("resultadoDorsal", "Disponibilidad del dorsal " + dorsal + " = " + estadoDorsal);
            }

        } catch (Exception e) {
            model.addAttribute("error", "Restricción de Integridad / Validación de Base de Datos: " + e.getMessage());
        }

        return "prueba_plsql";
    }
}