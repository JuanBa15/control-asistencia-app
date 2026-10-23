package com.asistencia.crud.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class FeriadoRequest {

    private Integer idSucursal;
    private LocalDate fecha;
    private String nombre;
    private String tipo;
    private Boolean laborable;
    private String estado;

}
