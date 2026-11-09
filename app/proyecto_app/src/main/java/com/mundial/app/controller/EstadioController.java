package com.mundial.app.controller;

import com.mundial.app.repository.EstadioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EstadioController {

    @Autowired
    private EstadioRepository estadioRepository;

    @GetMapping("/estadios")
    public String listarEstadios(Model model) {
        // Trae todos los estadios de la BD de Oracle y los envuelve en el modelo para la vista
        model.addAttribute("estadios", estadioRepository.findAll());
        return "estadios"; // Busca un archivo llamado estadios.html en templates
    }
}