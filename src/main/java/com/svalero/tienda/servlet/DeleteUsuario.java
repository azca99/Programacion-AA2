package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.UsuarioDAO;
import com.svalero.tienda.db.Database;
import com.svalero.tienda.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/remove-usuario")
public class DeleteUsuario extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ver usuario
        if (!isAdmin(request)) {
            response.sendRedirect("index.jsp");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendError(400, "Falta el id del usuario");
            return;
        }

        int id = Integer.parseInt(idParam);

        try {
            Database.connect();

            UsuarioDAO usuarioDAO = jdbi.onDemand(UsuarioDAO.class);
            usuarioDAO.delete(id);

            response.sendRedirect("usuarios");

        } catch (Exception e) {
            e.printStackTrace();

            response.getWriter().println(
                    "<div class='alert alert-danger' role='alert'>" +
                            "No se puede eliminar el usuario porque puede tener pedidos asociados." +
                            "</div>" +
                            "<a href='usuarios' class='btn btn-secondary'>Volver a usuarios</a>"
            );
        }
    }
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session == null) {
            return false;
        }

        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");

        return usuarioSesion != null && "admin".equals(usuarioSesion.getRol());
    }
}