<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.svalero.tienda.db.Database" %>
<%@ page import="com.svalero.tienda.dao.VideojuegoDAO" %>
<%@ page import="com.svalero.tienda.model.Videojuego" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.svalero.tienda.model.Categoria" %>

<%@ include file="includes/header.jsp" %>

<%
    List<Videojuego> videojuegos = (List<Videojuego>) request.getAttribute("videojuegos");
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");

    String tituloBuscado = (String) request.getAttribute("tituloBuscado");
    Integer idCategoriaBuscada = (Integer) request.getAttribute("idCategoriaBuscada");

    if (tituloBuscado == null) {
        tituloBuscado = "";
    }

    if (idCategoriaBuscada == null) {
        idCategoriaBuscada = 0;
    }
%>

<main class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="fw-bold">Catálogo de videojuegos</h1>
        <p class="text-muted mb-0">Estos son los videojuegos disponibles en God of Games.</p>

        <% if (esAdmin) { %>
            <a href="edit-videojuego.jsp" class="btn btn-primary">
                Añadir videojuego
            </a>
        <% } %>
    </div>

    <!-- Formulario de búsqueda -->
    <form action="videojuegos" method="get" class="row g-3 mb-4">

        <div class="col-md-5">
            <label class="form-label">Título</label>
            <input type="text"
                   name="titulo"
                   class="form-control"
                   placeholder="Buscar por título"
                   value="<%= tituloBuscado %>">
        </div>

        <div class="col-md-5">
            <label class="form-label">Categoría</label>
            <select name="idCategoria" class="form-select">
                <option value="0">Todas las categorías</option>

                <%
                    if (categorias != null) {
                        for (Categoria categoria : categorias) {
                            boolean selected = idCategoriaBuscada == categoria.getIdCategoria();
                %>

                <option value="<%= categoria.getIdCategoria() %>" <%= selected ? "selected" : "" %>>
                    <%= categoria.getNombre() %>
                </option>

                <%
                        }
                    }
                %>
            </select>
        </div>

        <div class="col-md-2 d-flex align-items-end">
            <button type="submit" class="btn btn-primary w-100">
                Buscar
            </button>
        </div>

    </form>

    <div class="row g-4">

        <%
            if (videojuegos != null && !videojuegos.isEmpty()) {
                for (Videojuego videojuego : videojuegos) {
        %>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm">

                <a href="view-videojuego?id=<%= videojuego.getIdVideojuego() %>">
                    <img src="/tienda_images/<%= videojuego.getImagen() %>"
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
                    <a href="view-videojuego?id=<%= videojuego.getIdVideojuego() %>"
                       class="btn btn-dark w-100">
                        Ver detalle
                    </a>

                    <% if (esAdmin) { %>
                    <a href="edit-videojuego.jsp?id=<%= videojuego.getIdVideojuego() %>"
                       class="btn btn-outline-secondary">
                        Editar
                    </a>

                    <a href="remove-videojuego?id=<%= videojuego.getIdVideojuego() %>"
                       class="btn btn-outline-danger"
                       onclick="return confirm('¿Seguro que quieres eliminar este videojuego?')">
                        Eliminar
                    </a>
                    <% } %>
                </div>
            </div>
        </div>

        <%
            }
        } else {
        %>

        <div class="col-12">
            <div class="alert alert-warning">
                No se han encontrado videojuegos con esos criterios.
            </div>
        </div>

        <%
            }
        %>

    </div>

</main>

<%@ include file="includes/footer.jsp" %>