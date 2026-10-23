package com.asistencia.crud.dto;

import com.asistencia.crud.enums.feriado.EstadoFeriado;
import com.asistencia.crud.enums.feriado.TipoFeriado;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class FeriadoRequest {

    private Integer idSucursal;
    private LocalDate fecha;
    private String nombre;
    private TipoFeriado tipo;
    private Boolean laborable;
    private EstadoFeriado estado;

}
