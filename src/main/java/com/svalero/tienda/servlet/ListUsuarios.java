package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.UsuarioDAO;
import com.svalero.tienda.db.Database;
import com.svalero.tienda.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/usuarios")
public class ListUsuarios extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Database.connect();

            UsuarioDAO usuarioDAO = jdbi.onDemand(UsuarioDAO.class);
            List<Usuario> usuarios = usuarioDAO.getAll();

            request.setAttribute("usuarios", usuarios);
            request.getRequestDispatcher("usuarios.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(500, "Error conectando con la base de datos");
        }
    }
}