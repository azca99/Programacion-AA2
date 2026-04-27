<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.svalero.tienda.db.Database" %>
<%@ page import="com.svalero.tienda.dao.VideojuegoDAO" %>
<%@ page import="com.svalero.tienda.model.Videojuego" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@ include file="includes/header.jsp" %>

<main class="container py-5">

    <div class="mb-4">
        <h1 class="fw-bold">Catálogo de videojuegos</h1>
        <p class="text-muted">Estos son los videojuegos disponibles en God of Games.</p>

        <a href="edit-videojuego.jsp" class="btn btn-primary">
            Añadir videojuego
        </a>
    </div>

    <div class="row row-cols-1 row-cols-md-3 g-4">

        <%
            List<Videojuego> videojuegos = new ArrayList<>();

            try {
                Database.connect();

                VideojuegoDAO videojuegoDAO = Database.jdbi.onDemand(VideojuegoDAO.class);
                videojuegos.addAll(videojuegoDAO.getAll());

            } catch (Exception e) {
                e.printStackTrace();
            }

            for (Videojuego videojuego : videojuegos) {
        %>

        <div class="col">
            <div class="card h-100 shadow-sm">

                <a href="view-videojuego.jsp?id=<%= videojuego.getIdVideojuego() %>">
                    <img src="img/<%= videojuego.getImagen() %>"
                         class="card-img-top"
                         alt="<%= videojuego.getTitulo() %>"
                         style="height: 250px; object-fit: cover;">
                </a>

                <div class="card-body">
                    <h5 class="card-title"><%= videojuego.getTitulo() %></h5>

                    <p class="card-text text-muted">
                        <%= videojuego.getDescripcion() %>
                    </p>

                    <p class="fw-bold text-primary fs-5">
                        <%= videojuego.getPrecio() %> €
                    </p>
                </div>

                <div class="card-footer bg-white border-0 d-flex gap-2">
                    <a href="view-videojuego.jsp?id=<%= videojuego.getIdVideojuego() %>"
                       class="btn btn-dark w-100">
                        Ver detalle
                    </a>

                    <a href="edit-videojuego.jsp?id=<%= videojuego.getIdVideojuego() %>"
                       class="btn btn-outline-secondary">
                        Editar
                    </a>
                </div>

            </div>
        </div>

        <%
            }
        %>

    </div>

</main>

<%@ include file="includes/footer.jsp" %>