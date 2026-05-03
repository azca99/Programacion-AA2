package com.svalero.tienda.model;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class Pedido {
    private int idPedido;
    private String codigo;
    private double total;
    private boolean pagado;
    private LocalDate fechaPedido;
    private int cantidadArticulos;
    private int idUsuario;
}
