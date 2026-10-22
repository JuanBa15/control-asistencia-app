package com.asistencia.crud.controller;

import com.asistencia.crud.dto.SucursalRequest;
import com.asistencia.crud.model.Sucursal;
import com.asistencia.crud.service.SucursalService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/api/sucursales")
public class SucursalController {

    private final SucursalService sucursalService;

    public SucursalController(SucursalService sucursalService) {
        this.sucursalService = sucursalService;
    }

    @GetMapping
    public List<Sucursal> listar() {
        return sucursalService.listarTodos();
    }

    @GetMapping("/{id}")
    public Sucursal buscarPorId(@PathVariable Integer id) {
        Sucursal sucursal = sucursalService.buscarPorId(id);

        if (sucursal == null) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND,
                    "Sucursal no encontrada"
            );
        }

        return sucursal;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Sucursal registrar(@RequestBody SucursalRequest request) {
        return sucursalService.registrar(request);
    }

    @PutMapping("/{id}")
    public Sucursal actualizar(
            @PathVariable Integer id,
            @RequestBody SucursalRequest request
    ) {
        Sucursal sucursal = sucursalService.actualizar(id, request);

        if (sucursal == null) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND,
                    "Sucursal no encontrada"
            );
        }

        return sucursal;
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void eliminar(@PathVariable Integer id) {
        int filas = sucursalService.eliminar(id);

        if (filas == 0) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND,
                    "Sucursal no encontrada"
            );
        }
    }
}
