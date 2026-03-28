package com.svalero.tienda.dao;

import com.svalero.tienda.model.Categoria;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CategoriaMapper implements RowMapper<Categoria> {
    @Override
    public Categoria map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Categoria(
                rs.getInt("id_categoria"),
                rs.getString("nombre"),
                rs.getString("descripcion"),
                rs.getInt("edad_recomendada"),
                rs.getDouble("descuento_base"),
                rs.getDate("fecha_creacion").toLocalDate(),
                rs.getBoolean("activa")
        );
    }
}
