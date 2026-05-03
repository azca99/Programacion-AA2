package com.svalero.tienda.servlet;

import com.svalero.tienda.dao.PedidoDAO;
import com.svalero.tienda.db.Database;
import com.svalero.tienda.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

import static com.svalero.tienda.db.Database.jdbi;

@WebServlet("/edit-pedido")
@MultipartConfig
public class EditPedido extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Comprobar admin
        if (!isAdmin(request)) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Variables
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        // Validaciones
        String codigo = request.getParameter("codigo");
        if (isEmpty(codigo)) {
            sendError(response, "El pedido debe tener código");
            return;
        }

        String totalParam = request.getParameter("total");
        if (!isPositiveDouble(totalParam)) {
            sendError(response, "El total debe ser un número mayor que 0");
            return;
        }

        String fechaParam = request.getParameter("fechaPedido");
        if (isEmpty(fechaParam)) {
            sendError(response, "La fecha del pedido es obligatoria");
            return;
        }

        String cantidadParam = request.getParameter("cantidadArticulos");
        if (!isPositiveInt(cantidadParam)) {
            sendError(response, "La cantidad de artículos debe ser un número igual o mayor que 1");
            return;
        }

        String idUsuarioParam = request.getParameter("idUsuario");
        if (isEmpty(idUsuarioParam)) {
            sendError(response, "Debes seleccionar un usuario");
            return;
        }

        // Dar formato a los datos
        double total;
        LocalDate fechaPedido;
        int cantidadArticulos;
        int idUsuario;

        try {
            total = Double.parseDouble(totalParam);
            fechaPedido = LocalDate.parse(fechaParam);
            cantidadArticulos = Integer.parseInt(cantidadParam);
            idUsuario = Integer.parseInt(idUsuarioParam);
        } catch (Exception e) {
            sendError(response, "Hay campos con un formato incorrecto");
            return;
        }

        boolean pagado = request.getParameter("pagado") != null;

        // Registrar o modificar
        try {
            Database.connect();
            PedidoDAO pedidoDAO = jdbi.onDemand(PedidoDAO.class);

            if ("Registrar".equals(action)) {

                pedidoDAO.add(
                        codigo,
                        total,
                        pagado,
                        fechaPedido,
                        cantidadArticulos,
                        idUsuario
                );

                sendSuccess(response, "Se ha añadido el pedido correctamente");

            } else {

                if (isEmpty(id)) {
                    sendError(response, "No se ha encontrado el pedido que quieres editar");
                    return;
                }

                pedidoDAO.modify(
                        codigo,
                        total,
                        pagado,
                        fechaPedido,
                        cantidadArticulos,
                        idUsuario,
                        Integer.parseInt(id)
                );

                sendSuccess(response, "Se ha modificado el pedido correctamente");
            }

        } catch (Exception e) {
            e.printStackTrace();

            if (e.getMessage() != null && e.getMessage().contains("Duplicate entry")) {
                sendError(response, "Ya existe un pedido con ese código");
            } else {
                sendError(response, "Error al guardar el pedido");
            }
        }
    }

    // Métodos
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session == null) {
            return false;
        }

        Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");

        return usuarioSesion != null && "admin".equals(usuarioSesion.getRol());
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isPositiveDouble(String value) {
        try {
            return Double.parseDouble(value) > 0;
        } catch (Exception e) {
            return false;
        }
    }

    private boolean isPositiveInt(String value) {
        try {
            return Integer.parseInt(value) >= 1;
        } catch (Exception e) {
            return false;
        }
    }

    private void sendSuccess(HttpServletResponse response, String message) throws IOException {
        sendMessage(response, "success", message);
    }

    private void sendError(HttpServletResponse response, String message) throws IOException {
        sendMessage(response, "danger", message);
    }

    private void sendMessage(HttpServletResponse response, String type, String message) throws IOException {
        response.getWriter().println("<div class=\"alert alert-" + type + "\" role=\"alert\">\n" + message + "</div>");
    }
}