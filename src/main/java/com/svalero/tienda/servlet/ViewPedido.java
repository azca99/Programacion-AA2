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

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/view-pedido")
public class ViewPedido extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("index.jsp");
            return;
        }

        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {
            response.sendError(400, "Falta el id del pedido");
            return;
        }

        try {
            Database.connect();

            PedidoDAO pedidoDAO = jdbi.onDemand(PedidoDAO.class);
            Pedido pedido = pedidoDAO.getById(Integer.parseInt(id));

            request.setAttribute("pedido", pedido);
            request.getRequestDispatcher("view-pedido.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error al cargar el pedido");
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