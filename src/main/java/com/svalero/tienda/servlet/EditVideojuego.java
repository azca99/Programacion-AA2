package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.VideojuegoDAO;
import com.svalero.tienda.db.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import com.svalero.tienda.model.Usuario;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.UUID;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/edit-videojuego")
@MultipartConfig
public class EditVideojuego extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Comprobación usuario
        if (!isAdmin(request)) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Botones
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        // Validaciones
        String titulo = request.getParameter("titulo");
        if (isEmpty(titulo)) {
            sendError(response, "El videojuego debe tener título");
            return;
        }

        String precioParam = request.getParameter("precio");
        if (!isPositiveDouble(precioParam)) {
            sendError(response, "El precio debe ser un número mayor que 0");
            return;
        }

        String stockParam = request.getParameter("stock");
        if (!isPositiveInt(stockParam)) {
            sendError(response, "El stock debe ser un número igual o mayor que 0");
            return;
        }

        String fechaParam = request.getParameter("fechaLanzamiento");
        if (isEmpty(fechaParam)) {
            sendError(response, "La fecha de lanzamiento es obligatoria");
            return;
        }

        String idCategoriaParam = request.getParameter("idCategoria");
        if (isEmpty(idCategoriaParam)) {
            sendError(response, "Debes seleccionar una categoría");
            return;
        }

        // Recoger datos
        String descripcion = request.getParameter("descripcion");

        double precio;
        int stock;
        LocalDate fechaLanzamiento;
        int idCategoria;

        try {
            precio = Double.parseDouble(precioParam);
            stock = Integer.parseInt(stockParam);
            fechaLanzamiento = LocalDate.parse(fechaParam);
            idCategoria = Integer.parseInt(idCategoriaParam);
        } catch (Exception e) {
            sendError(response, "Hay campos con un formato incorrecto");
            return;
        }

        boolean destacado = request.getParameter("destacado") != null;

        // Recoger imagen (archivo)
        Part imagen = request.getPart("imagen");

        try {
            // BD
            Database.connect();
            VideojuegoDAO videojuegoDAO = jdbi.onDemand(VideojuegoDAO.class);

            // Si no sube imagen
            String filename = "no-image.png";

            // Si sube imagen
            if (imagen != null && imagen.getSize() > 0) {
                filename = UUID.randomUUID() + ".png";

                String imagePath = "E:/Tomcat/webapps/tienda_images";

                // Guarda imagen en servidor
                InputStream inputStream = imagen.getInputStream();
                Files.copy(inputStream, Paths.get(imagePath + "/" + filename));
            }

            // Registrar o modificar
            if ("Registrar".equals(action)) {

                videojuegoDAO.add(
                        titulo,
                        descripcion,
                        precio,
                        filename,
                        destacado,
                        fechaLanzamiento,
                        stock,
                        idCategoria
                );

                sendSuccess(response, "Se ha añadido el videojuego correctamente");

            } else {

                if (imagen == null || imagen.getSize() == 0) {
                    videojuegoDAO.modifyWithoutImage(
                            titulo,
                            descripcion,
                            precio,
                            destacado,
                            fechaLanzamiento,
                            stock,
                            idCategoria,
                            Integer.parseInt(id)
                    );
                } else {
                    videojuegoDAO.modify(
                            titulo,
                            descripcion,
                            precio,
                            filename,
                            destacado,
                            fechaLanzamiento,
                            stock,
                            idCategoria,
                            Integer.parseInt(id)
                    );
                }

                sendSuccess(response, "Se ha modificado el videojuego correctamente");
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, "Error al guardar el videojuego");
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isPositiveDouble(String value) {
        try {
            return Double.parseDouble(value) > 0;
        } catch (Exception e) {
            return false;
        }
    }

    private boolean isPositiveInt(String value) {
        try {
            return Integer.parseInt(value) >= 0;
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