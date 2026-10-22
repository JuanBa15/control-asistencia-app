package com.asistencia.crud.dto;

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

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getZonaHoraria() {
        return zonaHoraria;
    }

    public void setZonaHoraria(String zonaHoraria) {
        this.zonaHoraria = zonaHoraria;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
