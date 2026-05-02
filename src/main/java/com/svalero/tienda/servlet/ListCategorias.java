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
import java.util.List;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/categorias")
public class ListCategorias extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Database.connect();

            CategoriaDAO categoriaDAO = jdbi.onDemand(CategoriaDAO.class);

            // Recoger, validar y dar formato a los inputs
            String nombre = request.getParameter("nombre");
            String activaParam = request.getParameter("activa");

            if (nombre == null) {
                nombre = "";
            }

            int activa = -1;

            if (activaParam != null && !activaParam.isEmpty()) {
                activa = Integer.parseInt(activaParam);
            }

            List<Categoria> categorias = categoriaDAO.search(nombre, activa, activa);

            // Mandar los datos a JSP
            request.setAttribute("categorias", categorias);
            request.setAttribute("nombreBuscado", nombre);
            request.setAttribute("activaBuscada", activa);

            // Enviar datos al JSP
            request.getRequestDispatcher("categorias.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(500, "Error conectando con la base de datos");
        }
    }
}
