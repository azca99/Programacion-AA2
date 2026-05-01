package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.CategoriaDAO;
import com.svalero.tienda.db.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/remove-categoria")
public class DeleteCategoria extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendError(400, "Falta el id de la categoría");
            return;
        }

        int id = Integer.parseInt(idParam);

        try {
            Database.connect();

            CategoriaDAO categoriaDAO = jdbi.onDemand(CategoriaDAO.class);
            categoriaDAO.delete(id);

            response.sendRedirect("categorias");

        } catch (Exception e) {
            e.printStackTrace();

            response.getWriter().println(
                    "<div class='alert alert-danger' role='alert'>" +
                            "No se puede eliminar la categoría porque puede tener videojuegos asociados." +
                            "</div>" +
                            "<a href='categorias' class='btn btn-secondary'>Volver a categorías</a>"
            );
        }
    }
}