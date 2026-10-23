package com.asistencia.crud.model;

import lombok.Getter;
import lombok.Setter;

import java.time.OffsetDateTime;

@Getter
@Setter
public class Sucursal {

    private Integer idSucursal;
    private String nombre;
    private String pais;
    private String ciudad;
    private String zonaHoraria;
    private String estado;
    // Se utiliza OffsetDateTime porque fecha_creacion es TIMESTAMPTZ en PostgreSQL,
    // lo que permite representar la fecha y hora junto con su desplazamiento respecto a UTC.
    private OffsetDateTime fechaCreacion;

}
