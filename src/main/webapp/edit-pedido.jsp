<%@ page import="com.svalero.tienda.model.Pedido" %>
<%@ page import="com.svalero.tienda.model.Usuario" %>
<%@ page import="com.svalero.tienda.db.Database" %>
<%@ page import="com.svalero.tienda.dao.PedidoDAO" %>
<%@ page import="com.svalero.tienda.dao.UsuarioDAO" %>
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

      // Pedir confirmación
      if (!confirm("¿Seguro que quieres guardar este pedido?")) {
        return;
      }

      // Crear formulario
      const data = new FormData(form);

      $("#new-button").prop("disabled", true);

      // Enviar al servlet
      $.ajax({
        type: "POST",
        url: "edit-pedido",
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

  Pedido pedido = null;
  List<Usuario> usuarios = new ArrayList<>();

  try {
    Database.connect();

    UsuarioDAO usuarioDAO = Database.jdbi.onDemand(UsuarioDAO.class);
    usuarios.addAll(usuarioDAO.getAll());

    // Editar si hay id
    if (id != null && !id.isEmpty()) {
      action = "Editar";

      PedidoDAO pedidoDAO = Database.jdbi.onDemand(PedidoDAO.class);
      pedido = pedidoDAO.getById(Integer.parseInt(id));
    }
  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<main class="container py-5">

  <!-- Título dinámico -->
  <h1 class="fw-bold mb-4">
    <%= action.equals("Registrar") ? "Añadir pedido" : "Editar pedido" %>
  </h1>

  <form id="new-form" class="row g-3" method="post">

    <div class="col-md-6">
      <label class="form-label">Código</label>
      <input type="text"
             class="form-control"
             name="codigo"
             value="<%= pedido != null ? pedido.getCodigo() : "" %>"
             required
             minlength="2"
             maxlength="30">
    </div>

    <div class="col-md-6">
      <label class="form-label">Total</label>
      <input type="number"
             class="form-control"
             name="total"
             value="<%= pedido != null ? pedido.getTotal() : "" %>"
             required
             min="0.01"
             step="0.01">
    </div>

    <div class="col-md-6">
      <label class="form-label">Fecha del pedido</label>
      <input type="date"
             class="form-control"
             name="fechaPedido"
             value="<%= pedido != null ? pedido.getFechaPedido() : "" %>"
             required>
    </div>

    <div class="col-md-6">
      <label class="form-label">Cantidad de artículos</label>
      <input type="number"
             class="form-control"
             name="cantidadArticulos"
             value="<%= pedido != null ? pedido.getCantidadArticulos() : "" %>"
             required
             min="1">
    </div>

    <div class="col-md-6">
      <label class="form-label">Usuario</label>
      <select class="form-select" name="idUsuario" required>
        <option value="">Selecciona un usuario</option>

        <%
          for (Usuario usuario : usuarios) {
            boolean selected = pedido != null && pedido.getIdUsuario() == usuario.getIdUsuario();
        %>

        <option value="<%= usuario.getIdUsuario() %>" <%= selected ? "selected" : "" %>>
          <%= usuario.getNombre() %> - <%= usuario.getEmail() %>
        </option>

        <%
          }
        %>
      </select>
    </div>

    <div class="col-md-6 d-flex align-items-end">
      <div class="form-check">
        <input type="checkbox"
               class="form-check-input"
               name="pagado"
               id="pagado"
          <%= pedido != null && pedido.isPagado() ? "checked" : "" %>>

        <label class="form-check-label" for="pagado">
          Pedido pagado
        </label>
      </div>
    </div>

    <div class="col-12">
      <button id="new-button" class="btn btn-primary">
        <%= action %>
      </button>

      <a href="pedidos" class="btn btn-secondary">
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