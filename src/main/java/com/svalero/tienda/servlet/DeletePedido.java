package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.PedidoDAO;
import com.svalero.tienda.db.Database;
import com.svalero.tienda.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/remove-pedido")
public class DeletePedido extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Comprobar admin
        if (!isAdmin(request)) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Obtener id
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendError(400, "Falta el id del pedido");
            return;
        }

        int id = Integer.parseInt(idParam);

        try {
            Database.connect();

            PedidoDAO pedidoDAO = jdbi.onDemand(PedidoDAO.class);
            // Eliminar por id
            pedidoDAO.delete(id);

            response.sendRedirect("pedidos");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error al eliminar el pedido");
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