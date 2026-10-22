package com.asistencia.crud.controller;

import com.asistencia.crud.model.Feriado;
import com.asistencia.crud.service.FeriadoService;
import com.asistencia.crud.dto.FeriadoRequest;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/api/feriados")
public class FeriadoController {

    private final FeriadoService feriadoService;

    public FeriadoController(FeriadoService feriadoService) {
        this.feriadoService = feriadoService;
    }

    @GetMapping
    public List<Feriado> listar() {
        return feriadoService.listarTodos();
    }

    @GetMapping("/{id}")
    public Feriado buscarPorId(@PathVariable Integer id) {

        Feriado feriado = feriadoService.buscarPorId(id);

        if (feriado == null) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND,
                    "Feriado no encontrado"
            );
        }

        return feriado;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Feriado registrar(@RequestBody FeriadoRequest request) {
        return feriadoService.registrar(request);
    }

    @PutMapping("/{id}")
    public Feriado actualizar(
            @PathVariable Integer id,
            @RequestBody FeriadoRequest request) {

        Feriado feriado = feriadoService.actualizar(id, request);

        if (feriado == null) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND,
                    "Feriado no encontrado"
            );
        }

        return feriado;
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void eliminar(@PathVariable Integer id) {

        int filas = feriadoService.eliminar(id);

        if (filas == 0) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND,
                    "Feriado no encontrado"
            );
        }
    }

}
