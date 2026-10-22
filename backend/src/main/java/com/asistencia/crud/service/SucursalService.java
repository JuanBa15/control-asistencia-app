package com.asistencia.crud.service;

import com.asistencia.crud.dto.SucursalRequest;
import com.asistencia.crud.mapper.SucursalMapper;
import com.asistencia.crud.model.Sucursal;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SucursalService {

    private final SucursalMapper sucursalMapper;

    public SucursalService(SucursalMapper sucursalMapper) {
        this.sucursalMapper = sucursalMapper;
    }

    public List<Sucursal> listarTodos() {
        return sucursalMapper.listarTodos();
    }

    public Sucursal buscarPorId(Integer id) {
        return sucursalMapper.buscarPorId(id);
    }

    public Sucursal registrar(SucursalRequest request) {
        Sucursal sucursal = new Sucursal();

        sucursal.setNombre(request.getNombre());
        sucursal.setPais(request.getPais());
        sucursal.setCiudad(request.getCiudad());
        sucursal.setZonaHoraria(request.getZonaHoraria());
        sucursal.setEstado(request.getEstado());

        sucursalMapper.registrar(sucursal);

        return sucursalMapper.buscarPorId(sucursal.getIdSucursal());
    }

    public Sucursal actualizar(Integer id, SucursalRequest request) {
        Sucursal sucursal = new Sucursal();

        sucursal.setIdSucursal(id);
        sucursal.setNombre(request.getNombre());
        sucursal.setPais(request.getPais());
        sucursal.setCiudad(request.getCiudad());
        sucursal.setZonaHoraria(request.getZonaHoraria());
        sucursal.setEstado(request.getEstado());

        int filas = sucursalMapper.actualizar(sucursal);

        if (filas == 0) {
            return null;
        }

        return sucursalMapper.buscarPorId(id);
    }

    public int eliminar(Integer id) {
        return sucursalMapper.eliminar(id);
    }
}
