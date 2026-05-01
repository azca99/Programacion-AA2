<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.svalero.tienda.model.Videojuego" %>

<%@ include file="includes/header.jsp" %>

<%
    Videojuego videojuego = (Videojuego) request.getAttribute("videojuego");
%>

<main class="container py-5">

    <% if (videojuego != null) { %>

    <div class="row g-5 align-items-start">

        <div class="col-md-6">
            <img src="img/<%= videojuego.getImagen() %>"
                 class="img-fluid rounded shadow"
                 alt="<%= videojuego.getTitulo() %>">
        </div>

        <div class="col-md-6">

            <h1 class="fw-bold"><%= videojuego.getTitulo() %></h1>

            <p class="text-muted mt-3">
                <%= videojuego.getDescripcion() %>
            </p>

            <p class="fs-3 fw-bold text-primary">
                <%= videojuego.getPrecio() %> €
            </p>

            <p>
                <strong>Stock:</strong>
                <%= videojuego.getStock() %> unidades
            </p>

            <p>
                <strong>Fecha de lanzamiento:</strong>
                <%= videojuego.getFechaLanzamiento() %>
            </p>

            <p>
                <strong>Destacado:</strong>
                <%= videojuego.isDestacado() ? "Sí" : "No" %>
            </p>

            <div class="mt-4 d-flex gap-2">
                <a href="videojuegos" class="btn btn-secondary">
                    Volver al catálogo
                </a>

                <a href="edit-videojuego.jsp?id=<%= videojuego.getIdVideojuego() %>"
                   class="btn btn-outline-primary">
                    Editar
                </a>

                <a href="#"
                   class="btn btn-success">
                    Comprar
                </a>
            </div>

        </div>

    </div>

    <% } else { %>

    <div class="alert alert-warning">
        No se ha encontrado el videojuego solicitado.
    </div>

    <a href="videojuegos" class="btn btn-secondary">
        Volver al catálogo
    </a>

    <% } %>

</main>

<%@ include file="includes/footer.jsp" %>