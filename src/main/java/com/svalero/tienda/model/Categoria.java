package com.svalero.tienda.model;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class Categoria {
    private int idCategoria;
    private String nombre;
    private String descripcion;
    private int edadRecomendada;
    private double descuentoBase;
    private LocalDate fechaCreacion;
    private boolean activa;
}
