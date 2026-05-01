package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.CategoriaDAO;
import com.svalero.tienda.db.Database;
import com.svalero.tienda.model.Categoria;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/view-categoria")
public class ViewCategoria extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {
            response.sendError(400, "Falta el id de la categoría");
            return;
        }

        try {
            Database.connect();

            CategoriaDAO categoriaDAO = jdbi.onDemand(CategoriaDAO.class);
            Categoria categoria = categoriaDAO.getById(Integer.parseInt(id));

            request.setAttribute("categoria", categoria);
            request.getRequestDispatcher("view-categoria.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error al cargar la categoría");
        }
    }
}