package com.asistencia.crud.controller;

import com.asistencia.crud.enums.feriado.EstadoFeriado;
import com.asistencia.crud.enums.feriado.TipoFeriado;
import com.asistencia.crud.model.Feriado;
import com.asistencia.crud.service.FeriadoService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

public class FeriadoControllerTest {

    private FeriadoService feriadoService;
    private FeriadoController feriadoController;

    @BeforeEach
    void setUp() {
        feriadoService = Mockito.mock(FeriadoService.class);
        feriadoController = new FeriadoController(feriadoService);
    }

    @Test
    void buscarPorId_cuandoExiste_debeRetornarFeriado() {

        Integer id = 1;

        Feriado feriadoEsperado = new Feriado();
        feriadoEsperado.setIdFeriado(id);
        feriadoEsperado.setIdSucursal(1);
        feriadoEsperado.setFecha(LocalDate.of(2026, 7, 28));
        feriadoEsperado.setNombre("Fiestas Patrias");
        feriadoEsperado.setTipo(TipoFeriado.NACIONAL);
        feriadoEsperado.setLaborable(false);
        feriadoEsperado.setEstado(EstadoFeriado.VIGENTE);

        // Cuando el Controller solicite al Service el feriado 1, responde con este objeto.
        Mockito.when(feriadoService.buscarPorId(id))
                .thenReturn(feriadoEsperado);

        // Método real que queremos probar
        Feriado resultado = feriadoController.buscarPorId(id);

        // Assert
        assertNotNull(resultado);
        assertEquals(id, resultado.getIdFeriado());
        assertEquals(1, resultado.getIdSucursal());
        assertEquals(LocalDate.of(2026, 7, 28), resultado.getFecha());
        assertEquals("Fiestas Patrias", resultado.getNombre());
        assertEquals(TipoFeriado.NACIONAL, resultado.getTipo());
        assertFalse(resultado.getLaborable());
        assertEquals(EstadoFeriado.VIGENTE, resultado.getEstado());
    }

    @Test
    void buscarPorId_cuandoNoExiste_debeRetornarNotFound() {

        Integer id = 99999;

        Mockito.when(feriadoService.buscarPorId(id))
                .thenReturn(null);

        // Método real que queremos probar
        ResponseStatusException excepcion = assertThrows(
                ResponseStatusException.class,
                () -> feriadoController.buscarPorId(id)
        );

        // Assert
        assertEquals(404, excepcion.getStatusCode().value());
        assertEquals("Feriado no encontrado", excepcion.getReason());
    }
}
