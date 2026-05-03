package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.UsuarioDAO;
import com.svalero.tienda.db.Database;
import com.svalero.tienda.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/login")
@MultipartConfig
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recoger datos del formulario
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validaciones
        if (email == null || email.isEmpty()) {
            sendError(response, "El email es obligatorio");
            return;
        }

        if (password == null || password.isEmpty()) {
            sendError(response, "La contraseña es obligatoria");
            return;
        }

        // Iniciar sesión
        try {
            Database.connect();

            UsuarioDAO usuarioDAO = jdbi.onDemand(UsuarioDAO.class);
            Usuario usuario = usuarioDAO.login(email, password);

            if (usuario == null) {
                sendError(response, "Email o contraseña incorrectos");
                return;
            }

            // Guardar usuario durante la sesion
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);

            sendSuccess(response, "Inicio de sesión correcto");

        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, "Error al iniciar sesión");
        }
    }

    private void sendSuccess(HttpServletResponse response, String message) throws IOException {
        sendMessage(response, "success", message);
    }

    private void sendError(HttpServletResponse response, String message) throws IOException {
        sendMessage(response, "danger", message);
    }

    private void sendMessage(HttpServletResponse response, String type, String message) throws IOException {
        response.getWriter().println("<div class=\"alert alert-" + type + "\" role=\"alert\">\n" + message + "</div>");
    }
}