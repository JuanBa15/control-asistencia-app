package com.asistencia.crud.model;

import java.time.LocalDate;

public class Feriado {
    private Integer idFeriado;
    private Integer idSucursal;
    private LocalDate fecha;
    private String nombre;
    private String tipo;
    private Boolean laborable;
    private String estado;

    public Integer getIdFeriado() {

        return idFeriado;
    }

    public void setIdFeriado(Integer idFeriado) {

        this.idFeriado = idFeriado;
    }

    public Integer getIdSucursal() {

        return idSucursal;
    }

    public void setIdSucursal(Integer idSucursal) {

        this.idSucursal = idSucursal;
    }

    public LocalDate getFecha() {

        return fecha;
    }

    public void setFecha(LocalDate fecha) {

        this.fecha = fecha;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {

        this.nombre = nombre;
    }

    public String getTipo() {

        return tipo;
    }

    public void setTipo(String tipo) {

        this.tipo = tipo;
    }

    public Boolean getLaborable() {

        return laborable;
    }

    public void setLaborable(Boolean laborable) {

        this.laborable = laborable;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {

        this.estado = estado;
    }
}
