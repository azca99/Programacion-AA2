package com.svalero.tienda.model;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class Videojuego {
    private int idVideojuego;
    private String titulo;
    private String descripcion;
    private double precio;
    private String imagen;
    private boolean destacado;
    private LocalDate fechaLanzamiento;
    private int stock;
    private int idCategoria;
}
