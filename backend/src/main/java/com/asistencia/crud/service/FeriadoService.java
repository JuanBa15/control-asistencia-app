package com.asistencia.crud.service;

import com.asistencia.crud.mapper.FeriadoMapper;
import com.asistencia.crud.model.Feriado;
import org.springframework.stereotype.Service;
import com.asistencia.crud.dto.FeriadoRequest;

import java.util.List;

@Service
public class FeriadoService {

    private final FeriadoMapper feriadoMapper;

    public FeriadoService(FeriadoMapper feriadoMapper) {

        this.feriadoMapper = feriadoMapper;
    }

    public List<Feriado> listarTodos() {

        return feriadoMapper.listarTodos();
    }

    public Feriado buscarPorId(Integer id) {
        return feriadoMapper.buscarPorId(id);
    }

    public Feriado registrar(FeriadoRequest request) {

        Feriado feriado = new Feriado();

        feriado.setIdSucursal(request.getIdSucursal());
        feriado.setFecha(request.getFecha());
        feriado.setNombre(request.getNombre());
        feriado.setTipo(request.getTipo());
        feriado.setLaborable(request.getLaborable());
        feriado.setEstado(request.getEstado());

        feriadoMapper.registrar(feriado);

        return feriado;
    }

    public Feriado actualizar(Integer id, FeriadoRequest request) {

        Feriado feriado = new Feriado();

        feriado.setIdFeriado(id);
        feriado.setIdSucursal(request.getIdSucursal());
        feriado.setFecha(request.getFecha());
        feriado.setNombre(request.getNombre());
        feriado.setTipo(request.getTipo());
        feriado.setLaborable(request.getLaborable());
        feriado.setEstado(request.getEstado());

        int filas = feriadoMapper.actualizar(feriado);

        if (filas == 0) {
            return null;
        }

        return feriado;
    }

    public int eliminar(Integer id) {
        return feriadoMapper.eliminar(id);
    }
}
