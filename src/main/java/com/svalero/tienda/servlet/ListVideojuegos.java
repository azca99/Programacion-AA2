package com.svalero.tienda.servlet;

import com.svalero.tienda.db.Database;
import com.svalero.tienda.dao.VideojuegoDAO;
import com.svalero.tienda.model.Videojuego;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/videojuegos")
public class ListVideojuegos extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Database.connect();

            // DAO
            VideojuegoDAO videojuegoDAO = jdbi.onDemand(VideojuegoDAO.class);
            List<Videojuego> videojuegos = videojuegoDAO.getAll();

            // MAndar datos al JSP
            request.setAttribute("videojuegos", videojuegos);
            request.getRequestDispatcher("videojuegos.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(500, "Error conectando con la base de datos");
        }
    }
}