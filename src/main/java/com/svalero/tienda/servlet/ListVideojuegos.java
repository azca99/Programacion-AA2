package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.CategoriaDAO;
import com.svalero.tienda.db.Database;
import com.svalero.tienda.dao.VideojuegoDAO;
import com.svalero.tienda.model.Categoria;
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

            // DAO, conecta con la BD
            VideojuegoDAO videojuegoDAO = jdbi.onDemand(VideojuegoDAO.class);
            CategoriaDAO categoriasDAO = jdbi.onDemand(CategoriaDAO.class);

            // Recoger y dar formato a inputs
            String titulo = request.getParameter("titulo");
            String idCategoriaParam = request.getParameter("idCategoria");

            if (titulo == null) {
                titulo = "";
            }

            int idCategoria = 0;

            if (idCategoriaParam != null && !idCategoriaParam.isEmpty()) {
                idCategoria = Integer.parseInt(idCategoriaParam);
            }

            // Buscar videojuegos
            List<Videojuego> videojuegos = videojuegoDAO.search(titulo, idCategoria, idCategoria);
            // Cargar categorias
            List<Categoria> categorias = categoriasDAO.getAll();

            // MAndar datos al JSP
            request.setAttribute("videojuegos", videojuegos);
            request.setAttribute("categorias", categorias);
            request.setAttribute("tituloBuscado", titulo);
            request.setAttribute("idCategoriaBuscada", idCategoria);

            // Enviar al JSP
            request.getRequestDispatcher("videojuegos.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(500, "Error conectando con la base de datos");
        }
    }
}