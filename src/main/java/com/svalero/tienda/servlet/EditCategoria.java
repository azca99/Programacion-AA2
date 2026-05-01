package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.CategoriaDAO;
import com.svalero.tienda.db.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/edit-categoria")
@MultipartConfig
public class EditCategoria extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");

        // Validaciones
        String nombre = request.getParameter("nombre");
        if (isEmpty(nombre)) {
            sendError(response, "La categoría debe tener nombre");
            return;
        }

        String edadParam = request.getParameter("edadRecomendada");
        if (!isPositiveInt(edadParam)) {
            sendError(response, "La edad recomendada debe ser un número igual o mayor que 0");
            return;
        }

        String descuentoParam = request.getParameter("descuentoBase");
        if (!isPositiveDoubleOrZero(descuentoParam)) {
            sendError(response, "El descuento base debe ser un número igual o mayor que 0");
            return;
        }

        String fechaParam = request.getParameter("fechaCreacion");
        if (isEmpty(fechaParam)) {
            sendError(response, "La fecha de creación es obligatoria");
            return;
        }

        String descripcion = request.getParameter("descripcion");

        int edadRecomendada;
        double descuentoBase;
        LocalDate fechaCreacion;

        // Pasar datos al formato correcto
        try {
            edadRecomendada = Integer.parseInt(edadParam);
            descuentoBase = Double.parseDouble(descuentoParam);
            fechaCreacion = LocalDate.parse(fechaParam);
        } catch (Exception e) {
            sendError(response, "Hay campos con un formato incorrecto");
            return;
        }

        boolean activa = request.getParameter("activa") != null;

        // Registrar o modificar
        try {
            Database.connect();
            CategoriaDAO categoriaDAO = jdbi.onDemand(CategoriaDAO.class);

            if ("Registrar".equals(action)) {

                categoriaDAO.add(
                        nombre,
                        descripcion,
                        edadRecomendada,
                        descuentoBase,
                        fechaCreacion,
                        activa
                );

                sendSuccess(response, "Se ha añadido la categoría correctamente");

            } else {

                if (isEmpty(id)) {
                    sendError(response, "No se ha encontrado la categoría que quieres editar");
                    return;
                }

                categoriaDAO.modify(
                        nombre,
                        descripcion,
                        edadRecomendada,
                        descuentoBase,
                        fechaCreacion,
                        activa,
                        Integer.parseInt(id)
                );

                sendSuccess(response, "Se ha modificado la categoría correctamente");
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, "Error al guardar la categoría");
        }
    }

    // Métodos
    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isPositiveInt(String value) {
        try {
            return Integer.parseInt(value) >= 0;
        } catch (Exception e) {
            return false;
        }
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
}