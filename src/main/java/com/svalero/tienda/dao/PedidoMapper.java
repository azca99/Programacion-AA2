package com.svalero.tienda.dao;

import com.svalero.tienda.model.Pedido;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PedidoMapper implements RowMapper<Pedido> {
    @Override
    public Pedido map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Pedido(
                rs.getInt("id_pedido"),
                rs.getString("codigo"),
                rs.getDouble("total"),
                rs.getBoolean("pagado"),
                rs.getDate("fecha_pedido").toLocalDate(),
                rs.getInt("cantidad_articulos"),
                rs.getInt("id_usuario")
        );
    }
}
