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
import java.util.List;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/usuarios")
public class ListUsuarios extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ver usuario
        if (!isAdmin(request)) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            Database.connect();

            UsuarioDAO usuarioDAO = jdbi.onDemand(UsuarioDAO.class);

            // Recoger, validar y dar formato a inputs
            String texto = request.getParameter("texto");
            String rol = request.getParameter("rol");

            if (texto == null) {
                texto = "";
            }

            if  (rol == null) {
                rol = "";
            }

            List<Usuario> usuarios = usuarioDAO.search(texto, texto, rol, rol);

            // Mandar datos al  JSP
            request.setAttribute("usuarios", usuarios);
            request.setAttribute("textoBuscado", texto);
            request.setAttribute("rolBuscado", rol);

            // Enviar datos al JSP
            request.getRequestDispatcher("usuarios.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(500, "Error conectando con la base de datos");
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