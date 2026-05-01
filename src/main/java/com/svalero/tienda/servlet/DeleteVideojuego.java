package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.VideojuegoDAO;
import com.svalero.tienda.db.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.svalero.tienda.model.Usuario;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/remove-videojuego")
public class DeleteVideojuego extends HttpServlet {

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
            response.sendError(400, "Falta el id del videojuego");
            return;
        }

        int id = Integer.parseInt(idParam);

        try {
            Database.connect();

            VideojuegoDAO videojuegoDAO = jdbi.onDemand(VideojuegoDAO.class);
            videojuegoDAO.delete(id);

            response.sendRedirect("videojuegos");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(500, "Error al eliminar el videojuego");
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