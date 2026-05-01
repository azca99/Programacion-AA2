package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.VideojuegoDAO;
import com.svalero.tienda.db.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/remove-videojuego")
public class DeleteVideojuego extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

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
}