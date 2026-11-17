package com.mundial.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.mundial.app.repository.CiudadRepository;
import com.mundial.app.repository.ConvocatoriaJugadorRepository;
import com.mundial.app.repository.EdicionMundialRepository;
import com.mundial.app.repository.EstadioRepository;
import com.mundial.app.repository.GrupoRepository;
import com.mundial.app.repository.JugadorRepository;
import com.mundial.app.repository.ParticipacionPartidoRepository;
import com.mundial.app.repository.PartidoRepository;
import com.mundial.app.repository.SedeRepository;
import com.mundial.app.repository.SeleccionRepository;

@Controller
public class CatalogoController {

    @Autowired
    private EdicionMundialRepository edicionMundialRepository;

    @Autowired
    private SedeRepository sedeRepository;

    @Autowired
    private CiudadRepository ciudadRepository;

    @Autowired
    private EstadioRepository estadioRepository;

    @Autowired
    private GrupoRepository grupoRepository;

    @Autowired
    private SeleccionRepository seleccionRepository;

    @Autowired
    private JugadorRepository jugadorRepository;

    @Autowired
    private ConvocatoriaJugadorRepository convocatoriaJugadorRepository;

    @Autowired
    private PartidoRepository partidoRepository;

    @Autowired
    private ParticipacionPartidoRepository participacionPartidoRepository;

    @GetMapping("/ediciones")
    public String listarEdiciones(Model model) {
        model.addAttribute("ediciones", edicionMundialRepository.findAll());
        return "ediciones";
    }

    @GetMapping("/sedes")
    public String listarSedes(Model model) {
        model.addAttribute("sedes", sedeRepository.findAll());
        return "sedes";
    }

    @GetMapping("/ciudades")
    public String listarCiudades(Model model) {
        model.addAttribute("ciudades", ciudadRepository.findAll());
        return "ciudades";
    }

    @GetMapping("/estadios")
    public String listarEstadios(Model model) {
        model.addAttribute("estadios", estadioRepository.findAll());
        return "estadios";
    }

    @GetMapping("/grupos")
    public String listarGrupos(Model model) {
        model.addAttribute("grupos", grupoRepository.findAll());
        return "grupos";
    }

    @GetMapping("/selecciones")
    public String listarSelecciones(Model model) {
        model.addAttribute("selecciones", seleccionRepository.findAll());
        return "selecciones";
    }

    @GetMapping("/jugadores")
    public String listarJugadores(Model model) {
        model.addAttribute("jugadores", jugadorRepository.findAll());
        return "jugadores";
    }

    @GetMapping("/convocatorias")
    public String listarConvocatorias(Model model) {
        model.addAttribute("convocatorias", convocatoriaJugadorRepository.findAll());
        return "convocatorias";
    }

    @GetMapping("/partidos")
    public String listarPartidos(Model model) {
        model.addAttribute("partidos", partidoRepository.findAll());
        return "partidos";
    }

    @GetMapping("/resultados")
    public String listarResultados(Model model) {
        model.addAttribute("participaciones", participacionPartidoRepository.findAll());
        return "resultados";
    }
}