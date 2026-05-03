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
import java.time.LocalDate;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/edit-usuario")
@MultipartConfig
public class EditUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ver usuarios
        if (!isAdmin(request)) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        String id = request.getParameter("id");

        // Validaciones
        String nombre = request.getParameter("nombre");
        if (isEmpty(nombre)) {
            sendError(response, "El usuario debe tener nombre");
            return;
        }

        String email = request.getParameter("email");
        if (isEmpty(email)) {
            sendError(response, "El email es obligatorio");
            return;
        }

        String password = request.getParameter("password");
        if (isEmpty(password)) {
            sendError(response, "La contraseña es obligatoria");
            return;
        }

        String telefono = request.getParameter("telefono");

        String saldoParam = request.getParameter("saldo");
        if (!isPositiveDoubleOrZero(saldoParam)) {
            sendError(response, "El saldo debe ser un número igual o mayor que 0");
            return;
        }

        String fechaParam = request.getParameter("fechaRegistro");
        if (isEmpty(fechaParam)) {
            sendError(response, "La fecha de registro es obligatoria");
            return;
        }

        String rol = request.getParameter("rol");
        if (isEmpty(rol)) {
            sendError(response, "Debes seleccionar un rol");
            return;
        }

        double saldo;
        LocalDate fechaRegistro;

        // Pasar datos al formato correcto
        try {
            saldo = Double.parseDouble(saldoParam);
            fechaRegistro = LocalDate.parse(fechaParam);
        } catch (Exception e) {
            sendError(response, "Hay campos con un formato incorrecto");
            return;
        }

        boolean activo = request.getParameter("activo") != null;

        // Registrar o modificar
        try {
            Database.connect();
            UsuarioDAO usuarioDAO = jdbi.onDemand(UsuarioDAO.class);

            if ("Registrar".equals(action)) {

                usuarioDAO.add(
                        nombre,
                        email,
                        password,
                        telefono,
                        saldo,
                        fechaRegistro,
                        rol,
                        activo
                );

                sendSuccess(response, "Se ha añadido el usuario correctamente");

            } else {

                if (isEmpty(id)) {
                    sendError(response, "No se ha encontrado el usuario que quieres editar");
                    return;
                }

                usuarioDAO.modify(
                        nombre,
                        email,
                        password,
                        telefono,
                        saldo,
                        fechaRegistro,
                        rol,
                        activo,
                        Integer.parseInt(id)
                );

                sendSuccess(response, "Se ha modificado el usuario correctamente");
            }
        // Capturar error específico de e-mail duplicado
        } catch (Exception e) {
            e.printStackTrace();

            if (e.getMessage() != null && e.getMessage().contains("Duplicate entry")) {
                sendError(response, "Ya existe un usuario registrado con ese email");
            } else {
                sendError(response, "Error al guardar el usuario");
            }
        }
    }

    // Métodos
    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isPositiveDoubleOrZero(String value) {
        try {
            return Double.parseDouble(value) >= 0;
        } catch (Exception e) {
            return false;
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
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session == null) {
            return false;
        }

        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");

        return usuarioSesion != null && "admin".equals(usuarioSesion.getRol());
    }
}