<%@ page import="com.svalero.tienda.model.Categoria" %>
<%@ page import="com.svalero.tienda.db.Database" %>
<%@ page import="com.svalero.tienda.dao.CategoriaDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="includes/header.jsp" %>

<%
    if (usuarioSesion == null || !"admin".equals(usuarioSesion.getRol())) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!-- Formulario con AJAX sin recorgar página -->
<script>
    $(document).ready(function () {
        $("#new-button").click(function (event) {
            event.preventDefault();

            // Buscar el formulario
            const form = $("#new-form")[0];

            // Validación
            if (!form.checkValidity()) {
                form.reportValidity();
                return;
            }

            // Pedir confirmación
            if (!confirm("¿Seguro que quieres guardar esta categoría?")) {
                return;
            }

            // Crear formulario
            const data = new FormData(form);

            $("#new-button").prop("disabled", true);

            // Enviar al servlet
            $.ajax({
                type: "POST",
                url: "edit-categoria",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    $("#result").html(data);
                    $("#new-button").prop("disabled", false);
                },
                error: function (error) {
                    $("#result").html(error.responseText);
                    $("#new-button").prop("disabled", false);
                }
            });
        });
    });
</script>

<%
    // Recoger id
    String id = request.getParameter("id");
    String action = "Registrar";

    Categoria categoria = null;

    try {
        // Editar si hay id
        if (id != null && !id.isEmpty()) {
            action = "Editar";

            Database.connect();
            CategoriaDAO categoriaDAO = Database.jdbi.onDemand(CategoriaDAO.class);
            categoria = categoriaDAO.getById(Integer.parseInt(id));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<main class="container py-5">

    <!-- Título dinámico -->
    <h1 class="fw-bold mb-4">
        <%= action.equals("Registrar") ? "Añadir categoría" : "Editar categoría" %>
    </h1>

    <form id="new-form" class="row g-3" method="post">

        <div class="col-md-6">
            <label class="form-label">Nombre</label>
            <input type="text"
                   class="form-control"
                   name="nombre"
                   value="<%= categoria != null ? categoria.getNombre() : "" %>"
                   required
                   minlength="2"
                   maxlength="100">
        </div>

        <div class="col-md-6">
            <label class="form-label">Edad recomendada</label>
            <input type="number"
                   class="form-control"
                   name="edadRecomendada"
                   value="<%= categoria != null ? categoria.getEdadRecomendada() : "" %>"
                   required
                   min="0">
        </div>

        <div class="col-md-6">
            <label class="form-label">Descuento base (%)</label>
            <input type="number"
                   class="form-control"
                   name="descuentoBase"
                   value="<%= categoria != null ? categoria.getDescuentoBase() : "" %>"
                   required
                   min="0"
                   step="0.01">
        </div>

        <div class="col-md-6">
            <label class="form-label">Fecha de creación</label>
            <input type="date"
                   class="form-control"
                   name="fechaCreacion"
                   value="<%= categoria != null ? categoria.getFechaCreacion() : "" %>"
                   required>
        </div>

        <div class="col-12">
            <label class="form-label">Descripción</label>
            <textarea class="form-control"
                      name="descripcion"
                      rows="4"
                      maxlength="255"><%= categoria != null ? categoria.getDescripcion() : "" %></textarea>
        </div>

        <div class="col-12">
            <div class="form-check">
                <input type="checkbox"
                       class="form-check-input"
                       name="activa"
                       id="activa"
                    <%= categoria == null || categoria.isActiva() ? "checked" : "" %>>

                <label class="form-check-label" for="activa">
                    Categoría activa
                </label>
            </div>
        </div>

        <div class="col-12">
            <button id="new-button" class="btn btn-primary">
                <%= action %>
            </button>

            <a href="categorias" class="btn btn-secondary">
                Volver
            </a>
        </div>

        <input type="hidden" name="id" value="<%= id != null ? id : "" %>"/>
        <input type="hidden" name="action" value="<%= action %>"/>

    </form>

    <br/>

    <div id="result"></div>

</main>

<%@ include file="includes/footer.jsp" %>