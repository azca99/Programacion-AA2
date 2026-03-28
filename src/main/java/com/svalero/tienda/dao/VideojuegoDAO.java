package com.svalero.tienda.dao;

import com.svalero.tienda.model.Videojuego;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.time.LocalDate;
import java.util.List;

public interface VideojuegoDAO {

    @SqlUpdate("INSERT INTO videojuego (titulo, descripcion, precio, imagen, destacado, fecha_lanzamiento, stock, id_categoria) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")
    void add(String titulo, String descripcion, double precio, String imagen, boolean destacado, LocalDate fechaLanzamiento, int stock, int idCategoria);

    @SqlUpdate("DELETE FROM videojuego WHERE id_videojuego = ?")
    void delete(int idVideojuego);

    @SqlUpdate("UPDATE videojuego SET titulo = ?, descripcion = ?, precio = ?, imagen = ?, destacado = ?, fecha_lanzamiento = ?, stock = ?, id_categoria = ? WHERE id_videojuego = ?")
    void modify(String titulo, String descripcion, double precio, String imagen, boolean destacado, LocalDate fechaLanzamiento, int stock, int idCategoria, int idVideojuego);

    @SqlQuery("SELECT * FROM videojuego")
    @UseRowMapper(VideojuegoMapper.class)
    List<Videojuego> getAll();

    @SqlQuery("SELECT * FROM videojuego WHERE id_videojuego = ?")
    @UseRowMapper(VideojuegoMapper.class)
    Videojuego getById(int idVideojuego);
}