package com.svalero.tienda.model;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class Usuario {
    private int idUsuario;
    private String nombre;
    private String email;
    private String password;
    private String telefono;
    private double saldo;
    private LocalDate fechaRegistro;
    private String rol;
    private boolean activo;
}
