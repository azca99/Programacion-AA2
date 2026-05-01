<%@ page import="com.svalero.tienda.model.Videojuego" %>
<%@ page import="com.svalero.tienda.model.Categoria" %>
<%@ page import="com.svalero.tienda.db.Database" %>
<%@ page import="com.svalero.tienda.dao.VideojuegoDAO" %>
<%@ page import="com.svalero.tienda.dao.CategoriaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="includes/header.jsp" %>

<%
    if (usuarioSesion == null || !"admin".equals(usuarioSesion.getRol())) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<script>
    $(document).ready(function () {
      $("#new-button").click(function (event) {
          event.preventDefault();

          const form = $("#new-form")[0];

          if (!form.checkValidity()) {
              form.reportValidity();
              return;
          }

          const data = new FormData(form);

          $("#new-button").prop("disabled", true);

          $.ajax({
              type: "POST",
              enctype: "multipart/form-data",
              url: "edit-videojuego",
              data: data,
              processData: false,
              contentType: false,
              cache: false,
              timeout: 60000,
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

    // Variables
    Videojuego videojuego = null;
    List<Categoria> categorias = new ArrayList<>();

    // Cargar categorias
    try {
        Database.connect();

        CategoriaDAO categoriaDAO = Database.jdbi.onDemand(CategoriaDAO.class);
        categorias.addAll(categoriaDAO.getAll());

        // Cargar equipo (editar)
        if (id != null) {
            action = "Editar";

            VideojuegoDAO videojuegoDAO = Database.jdbi.onDemand(VideojuegoDAO.class);
            videojuego = videojuegoDAO.getById(Integer.parseInt(id));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<main class="container">
    <h1 class="">
        <%= action.equals("Registrar") ? "Añadir videojuego" : "Editar videojuego" %>
    </h1>

    <form id="new-form" class="row g-3" method="post" enctype="multipart/form-data">
        <div class="col-md-6">
            <label class="form-label">Título</label>
            <input type="text"
                   class="form-control"
                   name="titulo"
                   value="<%= videojuego != null ? videojuego.getTitulo() : "" %>"
                   required
                   minlength="2"
                   maxlength="120">
        </div>
        <div class="col-md-6">
            <label class="form-label">Precio</label>
            <input type="number"
                   step="0.50"
                   min="0.50"
                   class="form-control"
                   name="precio"
                   value="<%= videojuego != null ? videojuego.getPrecio() : "" %>"
                   required>
        </div>
        <div class="col-md-6">
            <label class="form-label">Descripción</label>
            <textarea class="form-control"
                      name="descripcion"
                      rows="4"
                      maxlength="255"><%= videojuego != null ? videojuego.getDescripcion() : "" %></textarea>
        </div>
        <div class="col-md-6">
            <label class="form-label">Stock</label>
            <input type="number"
                   min="0"
                   class="form-control"
                   name="stock"
                   value="<%= videojuego != null ? videojuego.getStock() : "" %>"
                   required>
        </div>
        <div class="col-md-4">
            <label class="form-label">Fecha de lanzamiento</label>
            <input type="date"
                   class="form-control"
                   name="fechaLanzamiento"
                   value="<%= videojuego != null ? videojuego.getFechaLanzamiento() : "" %>"
                   required>
        </div>
        <div class="col-md-4">
            <label class="form-label">Categoría</label>
            <select class="form-select" name="idCategoria" required>
                <option value="">Selecciona una categoría</option>

                <%
                    for (Categoria categoria : categorias) {
                        boolean selected = videojuego != null
                                && videojuego.getIdCategoria() == categoria.getIdCategoria();
                %>

                <option value="<%= categoria.getIdCategoria() %>" <%= selected ? "selected" : "" %>>
                    <%= categoria.getNombre() %>
                </option>

                <%
                    }
                %>
            </select>
        </div>

        <div class="col-md-4">
            <label class="form-label">Imagen</label>
            <input type="file"
                   class="form-control"
                   name="imagen">

            <% if (videojuego != null && videojuego.getImagen() != null ) { %>
                <small class="text-muted">
                    Imagen actual: <%= videojuego.getImagen() %>
                </small>
            <% } %>
        </div>

        <div class="col-md-4">
            <div class="form-check">
                <input type="checkbox"
                       class="form-check-input"
                       name="destacado"
                       id="destacado"
                        <%= videojuego != null && videojuego.isDestacado() ? "checked" : "" %>>
                <label class="form-check-label" for="destacado">
                    Videojuego destacado
                </label>
            </div>
        </div>
        <div class="col-md-4">
            <button id="new-button" class="btn btn-primary">
                <%= action %>
            </button>
            <a href="videojuegos" class="btn btn-secondary">
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