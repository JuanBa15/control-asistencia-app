package com.asistencia.crud.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class Feriado {

    private Integer idFeriado;
    private Integer idSucursal;
    private LocalDate fecha;
    private String nombre;
    private String tipo;
    private Boolean laborable;
    private String estado;

}
