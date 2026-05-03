package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.VideojuegoDAO;
import com.svalero.tienda.db.Database;
import com.svalero.tienda.model.Videojuego;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/view-videojuego")
public class ViewVideojuego extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        // Validación id
        if (id == null || id.isEmpty()) {
            response.sendError(400, "Falta el id del videojuego");
            return;
        }

        try {
            Database.connect();

            // DAO
            VideojuegoDAO videojuegoDAO = jdbi.onDemand(VideojuegoDAO.class);
            Videojuego videojuego = videojuegoDAO.getById(Integer.parseInt(id));

            // Mandar datos al JSP
            request.setAttribute("videojuego", videojuego);
            request.getRequestDispatcher("view-videojuego.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error al cargar el videojuego");
        }
    }
}