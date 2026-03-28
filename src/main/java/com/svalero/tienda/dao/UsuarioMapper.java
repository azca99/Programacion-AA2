package com.svalero.tienda.dao;

import com.svalero.tienda.model.Usuario;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioMapper implements RowMapper<Usuario> {
    @Override
    public Usuario map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Usuario(
                rs.getInt("id_usuario"),
                rs.getString("nombre"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("telefono"),
                rs.getDouble("saldo"),
                rs.getDate("fecha_registro").toLocalDate(),
                rs.getString("rol"),
                rs.getBoolean("activo")
        );
    }
}
