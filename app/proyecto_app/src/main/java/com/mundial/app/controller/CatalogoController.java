package com.mundial.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.mundial.app.repository.ArbitroRepository;
import com.mundial.app.repository.EdicionMundialRepository;
import com.mundial.app.repository.EstadioRepository;
import com.mundial.app.repository.EstadisticaJugadorPartidoRepository;
import com.mundial.app.repository.IncidenciaRepository;
import com.mundial.app.repository.JugadorRepository;
import com.mundial.app.repository.ParticipacionPartidoRepository;
import com.mundial.app.repository.PartidoRepository;
import com.mundial.app.repository.SeleccionRepository;

@Controller
public class CatalogoController {

    @Autowired
    private EdicionMundialRepository edicionMundialRepository;

    @Autowired
    private EstadioRepository estadioRepository;

    @Autowired
    private SeleccionRepository seleccionRepository;

    @Autowired
    private JugadorRepository jugadorRepository;

    @GetMapping("/ediciones")
    public String listarEdiciones(Model model) {
        model.addAttribute("ediciones", edicionMundialRepository.findAll());
        return "ediciones"; // Busca ediciones.html en templates
    }

    @GetMapping("/estadios")
    public String listarEstadios(Model model) {
        model.addAttribute("estadios", estadioRepository.findAll());
        return "estadios"; // Busca estadios.html en templates
    }

    @GetMapping("/selecciones")
    public String listarSelecciones(Model model) {
        model.addAttribute("selecciones", seleccionRepository.findAll());
        return "selecciones"; // Busca selecciones.html en templates
    }

    @GetMapping("/jugadores")
    public String listarJugadores(Model model) {
        model.addAttribute("jugadores", jugadorRepository.findAll());
        return "jugadores"; // Busca jugadores.html en templates
    }

    @Autowired
    private PartidoRepository partidoRepository;

    @GetMapping("/partidos")
    public String listarPartidos(Model model) {
        model.addAttribute("partidos", partidoRepository.findAll());
        return "partidos";
    }

    @Autowired
    private ParticipacionPartidoRepository participacionPartidoRepository;

    @GetMapping("/resultados")
    public String listarResultados(Model model) {
        model.addAttribute("participaciones", participacionPartidoRepository.findAll());
        return "resultados";
    }

    @Autowired
    private EstadisticaJugadorPartidoRepository estadisticaJugadorPartidoRepository;

    @Autowired
    private IncidenciaRepository incidenciaRepository;

    @Autowired
    private ArbitroRepository arbitroRepository;

    @GetMapping("/estadisticas")
    public String listarEstadisticas(Model model) {
        model.addAttribute("estadisticas", estadisticaJugadorPartidoRepository.findAll());
        return "estadisticas";
    }

    @GetMapping("/incidencias")
    public String listarIncidencias(Model model) {
        model.addAttribute("incidencias", incidenciaRepository.findAll());
        return "incidencias";
    }

    @GetMapping("/arbitros")
    public String listarArbitros(Model model) {
        model.addAttribute("arbitros", arbitroRepository.findAll());
        return "arbitros";
    }
}