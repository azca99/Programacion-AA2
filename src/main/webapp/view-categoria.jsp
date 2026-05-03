<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.svalero.tienda.model.Categoria" %>

<%@ include file="includes/header.jsp" %>

<%
    Categoria categoria = (Categoria) request.getAttribute("categoria");
%>

<main class="container py-5">

    <% if (categoria != null) { %>

    <div class="card shadow-sm">

        <div class="card-body">

            <h1 class="fw-bold mb-3">
                <%= categoria.getNombre() %>
            </h1>

            <p class="text-muted">
                <%= categoria.getDescripcion() %>
            </p>

            <p class="mb-2">
                <strong>Edad recomendada:</strong>
                <%= categoria.getEdadRecomendada() %>+
            </p>

            <p class="mb-2">
                <strong>Descuento base:</strong>
                <%= categoria.getDescuentoBase() %> %
            </p>

            <p class="mb-2">
                <strong>Fecha de creación:</strong>
                <%= categoria.getFechaCreacion() %>
            </p>

            <p class="mb-0">
                <strong>Estado:</strong>
                <span class="<%= categoria.isActiva() ? "text-success" : "text-danger" %>">
                    <%= categoria.isActiva() ? "Activa" : "Inactiva" %>
                </span>
            </p>

        </div>

        <div class="card-footer bg-white border-0 d-flex gap-2">

            <a href="categorias" class="btn btn-secondary">
                Volver
            </a>

            <% if (esAdmin) { %>
                <a href="edit-categoria.jsp?id=<%= categoria.getIdCategoria() %>"
                   class="btn btn-outline-primary">
                    Editar
                </a>

                <a href="remove-categoria?id=<%= categoria.getIdCategoria() %>"
                   class="btn btn-danger"
                   onclick="return confirm('¿Seguro que quieres eliminar esta categoría?')">
                    Eliminar
                </a>
            <% } %>

        </div>

    </div>

    <% } else { %>

    <div class="alert alert-warning">
        No se ha encontrado la categoría solicitada.
    </div>

    <a href="categorias" class="btn btn-secondary">
        Volver a categorías
    </a>

    <% } %>

</main>

<%@ include file="includes/footer.jsp" %>