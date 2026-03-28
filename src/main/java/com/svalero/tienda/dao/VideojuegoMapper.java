package com.svalero.tienda.dao;

import com.svalero.tienda.model.Videojuego;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class VideojuegoMapper implements RowMapper<Videojuego> {
    @Override
    public Videojuego map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Videojuego(
                rs.getInt("id_videojuego"),
                rs.getString("titulo"),
                rs.getString("descripcion"),
                rs.getDouble("precio"),
                rs.getString("imagen"),
                rs.getBoolean("destacado"),
                rs.getDate("fecha_lanzamiento").toLocalDate(),
                rs.getInt("stock"),
                rs.getInt("id_categoria")
        );
    }
}