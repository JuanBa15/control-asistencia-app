package com.asistencia.crud.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SucursalRequest {

    private String nombre;
    private String pais;
    private String ciudad;
    private String zonaHoraria;
    private String estado;

    /*
    * No agregamos idSucursal ni fechaCreacion, porque son datos que el propio
    * Postgres SQL da valor automáticamente cuando se crea un nuevo registro
    * Y solo cuando se registra algo nuevo, se modifican esos datos
    * */

}
