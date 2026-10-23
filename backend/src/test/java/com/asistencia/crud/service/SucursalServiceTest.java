package com.asistencia.crud.service;

import com.asistencia.crud.enums.sucursal.EstadoSucursal;
import com.asistencia.crud.enums.sucursal.Pais;
import com.asistencia.crud.mapper.SucursalMapper;
import com.asistencia.crud.model.Sucursal;
import com.asistencia.crud.service.SucursalService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.time.OffsetDateTime;

import static org.junit.jupiter.api.Assertions.*;

public class SucursalServiceTest {

    private SucursalMapper sucursalMapper;
    private SucursalService sucursalService;

    @BeforeEach
    void setUp() {
        sucursalMapper = Mockito.mock(SucursalMapper.class);
        sucursalService = new SucursalService(sucursalMapper);
    }

    @Test
    void buscarPorId_cuandoExiste_debeRetornarSucursal() {
        Integer id = 1;

        OffsetDateTime fechaCreacion =
                OffsetDateTime.parse("2026-10-21T00:47:05.19731Z");

        Sucursal sucursalEsperada = new Sucursal();
        sucursalEsperada.setIdSucursal(id);
        sucursalEsperada.setNombre("Sucursal Lima");
        sucursalEsperada.setPais(Pais.PERU);
        sucursalEsperada.setCiudad("Lima");
        sucursalEsperada.setZonaHoraria("America/Lima");
        sucursalEsperada.setEstado(EstadoSucursal.ACTIVA);
        sucursalEsperada.setFechaCreacion(fechaCreacion);

        Mockito.when(sucursalMapper.buscarPorId(id))
                .thenReturn(sucursalEsperada);

        Sucursal resultado = sucursalService.buscarPorId(id);

        assertNotNull(resultado);
        assertEquals(id, resultado.getIdSucursal());
        assertEquals("Sucursal Lima", resultado.getNombre());
        assertEquals(Pais.PERU, resultado.getPais());
        assertEquals("Lima", resultado.getCiudad());
        assertEquals("America/Lima", resultado.getZonaHoraria());
        assertEquals(EstadoSucursal.ACTIVA, resultado.getEstado());
        assertEquals(fechaCreacion, resultado.getFechaCreacion());
    }

    @Test
    void buscarPorId_cuandoNoExiste_debeRetornarNull() {
        Integer id = 99999;

        Mockito.when(sucursalMapper.buscarPorId(id))
                .thenReturn(null);

        Sucursal resultado = sucursalService.buscarPorId(id);

        assertNull(resultado);
    }
}
