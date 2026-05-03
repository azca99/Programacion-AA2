package com.svalero.tienda.dao;

import com.svalero.tienda.model.Usuario;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.time.LocalDate;
import java.util.List;

public interface UsuarioDAO {

    @SqlUpdate("INSERT INTO usuario (nombre, email, password, telefono, saldo, fecha_registro, rol, activo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")
    void add(String nombre, String email, String password, String telefono, double saldo, LocalDate fechaRegistro, String rol, boolean activo);

    @SqlUpdate("DELETE FROM usuario WHERE id_usuario = ?")
    void delete(int idUsuario);

    @SqlUpdate("UPDATE usuario SET nombre = ?, email = ?, password = ?, telefono = ?, saldo = ?, fecha_registro = ?, rol = ?, activo = ? WHERE id_usuario = ?")
    void modify(String nombre, String email, String password, String telefono, double saldo, LocalDate fechaRegistro, String rol, boolean activo, int idUsuario);

    @SqlQuery("SELECT * FROM usuario")
    @UseRowMapper(UsuarioMapper.class)
    List<Usuario> getAll();

    @SqlQuery("SELECT * FROM usuario WHERE id_usuario = ?")
    @UseRowMapper(UsuarioMapper.class)
    Usuario getById(int idUsuario);

    @SqlQuery("SELECT * FROM usuario WHERE email = ? AND password = ? AND activo = true")
    @UseRowMapper(UsuarioMapper.class)
    Usuario login(String email, String password);

    @SqlQuery("SELECT * FROM usuario WHERE (nombre LIKE CONCAT('%', ?, '%') OR email LIKE CONCAT('%', ?, '%')) AND (? = '' OR rol = ?)")
    @UseRowMapper(UsuarioMapper.class)
    List<Usuario> search(String textoNombre, String textoEmail, String rolFiltro, String rol);
}
