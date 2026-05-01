<%@ page import="com.svalero.tienda.model.Usuario" %>
<%@ page import="com.svalero.tienda.db.Database" %>
<%@ page import="com.svalero.tienda.dao.UsuarioDAO" %>
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

      // Buscar formulario
      const form = $("#new-form")[0];

      // Validación
      if (!form.checkValidity()) {
        form.reportValidity();
        return;
      }

      // Crear formulario
      const data = new FormData(form);

      $("#new-button").prop("disabled", true);

      // Enviar al servlet
      $.ajax({
        type: "POST",
        url: "edit-usuario",
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

  Usuario usuario = null;

  try {
    // Editar si hay id
    if (id != null && !id.isEmpty()) {
      action = "Editar";

      Database.connect();
      UsuarioDAO usuarioDAO = Database.jdbi.onDemand(UsuarioDAO.class);
      usuario = usuarioDAO.getById(Integer.parseInt(id));
    }
  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<main class="container py-5">

  <!-- Título dinámico -->
  <h1 class="fw-bold mb-4">
    <%= action.equals("Registrar") ? "Añadir usuario" : "Editar usuario" %>
  </h1>

  <form id="new-form" class="row g-3" method="post">

    <div class="col-md-6">
      <label class="form-label">Nombre</label>
      <input type="text"
             class="form-control"
             name="nombre"
             value="<%= usuario != null ? usuario.getNombre() : "" %>"
             required
             minlength="2"
             maxlength="100">
    </div>

    <div class="col-md-6">
      <label class="form-label">Email</label>
      <input type="email"
             class="form-control"
             name="email"
             value="<%= usuario != null ? usuario.getEmail() : "" %>"
             required
             maxlength="120">
    </div>

    <div class="col-md-6">
      <label class="form-label">Contraseña</label>
      <input type="text"
             class="form-control"
             name="password"
             value="<%= usuario != null ? usuario.getPassword() : "" %>"
             required
             minlength="4"
             maxlength="255">
    </div>

    <div class="col-md-6">
      <label class="form-label">Teléfono</label>
      <input type="text"
             class="form-control"
             name="telefono"
             value="<%= usuario != null ? usuario.getTelefono() : "" %>"
             maxlength="20">
    </div>

    <div class="col-md-6">
      <label class="form-label">Saldo</label>
      <input type="number"
             class="form-control"
             name="saldo"
             value="<%= usuario != null ? usuario.getSaldo() : "" %>"
             required
             min="0"
             step="0.01">
    </div>

    <div class="col-md-6">
      <label class="form-label">Fecha de registro</label>
      <input type="date"
             class="form-control"
             name="fechaRegistro"
             value="<%= usuario != null ? usuario.getFechaRegistro() : "" %>"
             required>
    </div>

    <div class="col-md-6">
      <label class="form-label">Rol</label>
      <select class="form-select" name="rol" required>
        <option value="">Selecciona un rol</option>
        <option value="admin" <%= usuario != null && "admin".equals(usuario.getRol()) ? "selected" : "" %>>
          Admin
        </option>
        <option value="cliente" <%= usuario != null && "cliente".equals(usuario.getRol()) ? "selected" : "" %>>
          Cliente
        </option>
      </select>
    </div>

    <div class="col-md-6 d-flex align-items-end">
      <div class="form-check">
        <input type="checkbox"
               class="form-check-input"
               name="activo"
               id="activo"
          <%= usuario == null || usuario.isActivo() ? "checked" : "" %>>

        <label class="form-check-label" for="activo">
          Usuario activo
        </label>
      </div>
    </div>

    <div class="col-12">
      <button id="new-button" class="btn btn-primary">
        <%= action %>
      </button>

      <a href="usuarios" class="btn btn-secondary">
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