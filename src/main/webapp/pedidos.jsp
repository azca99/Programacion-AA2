<%@ page import="com.svalero.tienda.model.Pedido" %>
<%@ page import="com.svalero.tienda.model.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="includes/header.jsp" %>

<%
    if (usuarioSesion == null || !"admin".equals(usuarioSesion.getRol())) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Pedido> pedidos = (List<Pedido>) request.getAttribute("pedidos");
%>

<main class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1 class="fw-bold">Pedidos</h1>
            <p class="text-muted mb-0">
                Gestiona los pedidos registrados en la tienda.
            </p>
        </div>

        <a href="edit-pedido.jsp" class="btn btn-primary">
            Añadir pedido
        </a>
    </div>

    <div class="row g-4">

        <%
            if (pedidos != null && !pedidos.isEmpty()) {
                for (Pedido pedido : pedidos) {
        %>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm">

                <div class="card-body">
                    <h5 class="card-title">
                        Pedido <%= pedido.getCodigo() %>
                    </h5>

                    <p class="mb-1">
                        <strong>Total:</strong>
                        <%= pedido.getTotal() %> €
                    </p>

                    <p class="mb-1">
                        <strong>Cantidad artículos:</strong>
                        <%= pedido.getCantidadArticulos() %>
                    </p>

                    <p class="mb-1">
                        <strong>Fecha:</strong>
                        <%= pedido.getFechaPedido() %>
                    </p>

                    <p class="mb-0">
                        <strong>Estado:</strong>
                        <span class="<%= pedido.isPagado() ? "text-success" : "text-danger" %>">
                            <%= pedido.isPagado() ? "Pagado" : "Pendiente" %>
                        </span>
                    </p>
                </div>

                <div class="card-footer bg-white border-0 d-flex gap-2">
                    <a href="view-pedido?id=<%= pedido.getIdPedido() %>"
                       class="btn btn-dark w-100">
                        Ver detalle
                    </a>

                    <a href="edit-pedido.jsp?id=<%= pedido.getIdPedido() %>"
                       class="btn btn-outline-secondary">
                        Editar
                    </a>

                    <a href="remove-pedido?id=<%= pedido.getIdPedido() %>"
                       class="btn btn-outline-danger"
                       onclick="return confirm('¿Seguro que quieres eliminar este pedido?')">
                        Eliminar
                    </a>
                </div>

            </div>
        </div>

        <%
            }
        } else {
        %>

        <div class="col-12">
            <div class="alert alert-warning">
                No hay pedidos registrados.
            </div>
        </div>

        <%
            }
        %>

    </div>

</main>

<%@ include file="includes/footer.jsp" %>