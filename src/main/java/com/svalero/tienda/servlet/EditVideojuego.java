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

        // Botones
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        // Validación básica
        String titulo = request.getParameter("titulo");
        if (titulo == null || titulo.isEmpty()) {
            sendError(response, "El videojuego debe tener título");
            return;
        }

        // Recoger campos
        String descripcion = request.getParameter("descripcion");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        LocalDate fechaLanzamiento = LocalDate.parse(request.getParameter("fechaLanzamiento"));
        boolean destacado = request.getParameter("destacado") != null;
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));

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

                String imagePath = "E:/grado superior programacion/programacion/webapp/Programacion-AA2/src/main/webapp/img";

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