package com.asistencia.crud.service;

import com.asistencia.crud.mapper.FeriadoMapper;
import com.asistencia.crud.model.Feriado;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

public class FeriadoServiceTest {

    private FeriadoMapper feriadoMapper;
    private FeriadoService feriadoService;

    @BeforeEach
    void setUp() {
        feriadoMapper = Mockito.mock(FeriadoMapper.class); // Creamos un objeto falso que se comporte como un FeriadoMapper
        feriadoService = new FeriadoService(feriadoMapper); // Internamente no guarda una copia, sino apunta a la misma referencia de feriadoMapper
    }

    @Test
    void buscarPorId_cuandoExiste_debeRetornarFeriado() {

        // Preparamos el escenario
        Integer id = 1;

        Feriado feriadoEsperado = new Feriado();
        feriadoEsperado.setIdFeriado(id);
        feriadoEsperado.setIdSucursal(1);
        feriadoEsperado.setFecha(LocalDate.of(2026, 7, 28));
        feriadoEsperado.setNombre("Fiestas Patrias");
        feriadoEsperado.setTipo("NACIONAL");
        feriadoEsperado.setLaborable(false);
        feriadoEsperado.setEstado("VIGENTE");

        /*
        * Cuando el Service solicite al Mapper el feriado con ID 1,
        * Mockito simula que la base de datos encontró este feriado.
        * */
        Mockito.when(feriadoMapper.buscarPorId(id))
                .thenReturn(feriadoEsperado);
        // Fin escenario

        // Método real que queremos probar
        Feriado resultado = feriadoService.buscarPorId(id);

        // Assert
        assertNotNull(resultado);
        assertEquals(id, resultado.getIdFeriado());
        assertEquals(1, resultado.getIdSucursal());
        assertEquals(LocalDate.of(2026, 7, 28), resultado.getFecha());
        assertEquals("Fiestas Patrias", resultado.getNombre());
        assertEquals("NACIONAL", resultado.getTipo());
        assertFalse(resultado.getLaborable());
        assertEquals("VIGENTE", resultado.getEstado());
    }

    @Test
    void buscarPorId_cuandoNoExiste_debeRetornarNull() {

        // Arrange
        Integer id = 99999;

        // Simulamos
        Mockito.when(feriadoMapper.buscarPorId(id))
                .thenReturn(null);

        // Método real que queremos probar
        Feriado resultado = feriadoService.buscarPorId(id);

        // Assert
        assertNull(resultado);
    }
}
