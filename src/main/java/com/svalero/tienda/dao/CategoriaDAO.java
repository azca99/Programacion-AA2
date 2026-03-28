package com.svalero.tienda.dao;

import com.svalero.tienda.model.Categoria;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.time.LocalDate;
import java.util.List;

public interface CategoriaDAO {

    @SqlUpdate("INSERT INTO categoria (nombre, descripcion, edad_recomendada, descuento_base, fecha_creacion, activa) VALUES (?, ?, ?, ?, ?, ?)")
    void add(String nombre, String descripcion, int edadRecomendada, double descuentoBase, LocalDate fechaCreacion, boolean activa);

    @SqlUpdate("DELETE FROM categoria WHERE id_categoria = ?")
    void delete(int idCategoria);

    @SqlUpdate("UPDATE categoria SET nombre = ?, descripcion = ?, edad_recomendada = ?, descuento_base = ?, fecha_creacion = ?, activa = ? WHERE id_categoria = ?")
    void modify(String nombre, String descripcion, int edadRecomendada, double descuentoBase, LocalDate fechaCreacion, boolean activa, int idCategoria);

    @SqlQuery("SELECT * FROM categoria")
    @UseRowMapper(CategoriaMapper.class)
    List<Categoria> getAll();

    @SqlQuery("SELECT * FROM categoria WHERE id_categoria = ?")
    @UseRowMapper(CategoriaMapper.class)
    Categoria getById(int idCategoria);
}