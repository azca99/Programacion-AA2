package com.svalero.tienda.dao;

import com.svalero.tienda.model.Pedido;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.time.LocalDate;
import java.util.List;

public interface PedidoDAO {

    @SqlUpdate("INSERT INTO pedido (codigo, total, pagado, fecha_pedido, cantidad_articulos, id_usuario) VALUES (?, ?, ?, ?, ?, ?)")
    void add(String codigo, double total, boolean pagado, LocalDate fechaPedido, int cantidadArticulos, int idUsuario);

    @SqlUpdate("DELETE FROM pedido WHERE id_pedido = ?")
    void delete(int idPedido);

    @SqlUpdate("UPDATE pedido SET codigo = ?, total = ?, pagado = ?, fecha_pedido = ?, cantidad_articulos = ?, id_usuario = ? WHERE id_pedido = ?")
    void modify(String codigo, double total, boolean pagado, LocalDate fechaPedido, int cantidadArticulos, int idUsuario, int idPedido);

    @SqlQuery("SELECT * FROM pedido")
    @UseRowMapper(PedidoMapper.class)
    List<Pedido> getAll();

    @SqlQuery("SELECT * FROM pedido WHERE id_pedido = ?")
    @UseRowMapper(PedidoMapper.class)
    Pedido getById(int idPedido);
}