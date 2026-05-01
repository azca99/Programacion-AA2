<%@ page import="com.svalero.tienda.model.Categoria" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="includes/header.jsp" %>

<%
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
%>

<main class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1 class="fw-bold">Categorías</h1>
            <p class="text-muted mb-0">
                Gestiona las categorías de videojuegos de la tienda.
            </p>
        </div>

        <a href="edit-categoria.jsp" class="btn btn-primary">
            Añadir categoría
        </a>
    </div>

    <div class="row g-4">

        <%
            if (categorias != null && !categorias.isEmpty()) {
                for (Categoria categoria : categorias) {
        %>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm">

                <div class="card-body">
                    <h5 class="card-title">
                        <%= categoria.getNombre() %>
                    </h5>

                    <p class="card-text text-muted">
                        <%= categoria.getDescripcion() %>
                    </p>

                    <p class="mb-1">
                        <strong>Edad recomendada:</strong>
                        <%= categoria.getEdadRecomendada() %>+
                    </p>

                    <p class="mb-1">
                        <strong>Descuento base:</strong>
                        <%= categoria.getDescuentoBase() %> %
                    </p>

                    <p class="mb-0">
                        <strong>Estado:</strong>
                        <%= categoria.isActiva() ? "Activa" : "Inactiva" %>
                    </p>
                </div>

                <div class="card-footer bg-white border-0 d-flex gap-2">
                    <a href="view-categoria?id=<%= categoria.getIdCategoria() %>"
                       class="btn btn-dark w-100">
                        Ver detalle
                    </a>

                    <a href="edit-categoria.jsp?id=<%= categoria.getIdCategoria() %>"
                       class="btn btn-outline-secondary">
                        Editar
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
                No hay categorías registradas.
            </div>
        </div>

        <%
            }
        %>

    </div>

</main>

<%@ include file="includes/footer.jsp" %>