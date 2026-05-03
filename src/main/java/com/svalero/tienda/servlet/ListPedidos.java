package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.PedidoDAO;
import com.svalero.tienda.db.Database;
import com.svalero.tienda.model.Pedido;
import com.svalero.tienda.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/pedidos")
public class ListPedidos extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            Database.connect();

            PedidoDAO pedidoDAO = jdbi.onDemand(PedidoDAO.class);
            List<Pedido> pedidos = pedidoDAO.getAll();

            request.setAttribute("pedidos", pedidos);
            request.getRequestDispatcher("pedidos.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(500, "Error conectando con la base de datos");
        }
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