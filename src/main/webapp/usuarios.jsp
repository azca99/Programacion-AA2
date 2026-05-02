<%@ page import="com.svalero.tienda.model.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="includes/header.jsp" %>

<%
    if (usuarioSesion == null || !"admin".equals(usuarioSesion.getRol())) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");

    // Cliente no puede acceder a lista de usuarios
    if (usuarioSesion == null || !"admin".equals(usuarioSesion.getRol())) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Búsqueda
    String textoBuscado = (String) request.getAttribute("textoBuscado");
    String rolBuscado = (String) request.getAttribute("rolBuscado");

    if (textoBuscado == null) {
        textoBuscado = "";
    }

    if (rolBuscado == null) {
        rolBuscado = "";
    }
%>

<main class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1 class="fw-bold">Usuarios</h1>
            <p class="text-muted mb-0">
                Gestiona los usuarios registrados en la tienda.
            </p>
        </div>

        <a href="edit-usuario.jsp" class="btn btn-primary">
            Añadir usuario
        </a>
    </div>

    <!-- Formulario de búsqueda -->
    <form action="usuarios" method="get" class="row g-3 mb-4">

        <div class="col-md-5">
            <label class="form-label">Nombre o email</label>
            <input type="text"
                   name="texto"
                   class="form-control"
                   placeholder="Buscar por nombre o email"
                   value="<%= textoBuscado %>">
        </div>

        <div class="col-md-5">
            <label class="form-label">Rol</label>
            <select name="rol" class="form-select">
                <option value="" <%= "".equals(rolBuscado) ? "selected" : "" %>>
                    Todos los roles
                </option>

                <option value="admin" <%= "admin".equals(rolBuscado) ? "selected" : "" %>>
                    Admin
                </option>

                <option value="cliente" <%= "cliente".equals(rolBuscado) ? "selected" : "" %>>
                    Cliente
                </option>
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
            if (usuarios != null && !usuarios.isEmpty()) {
                for (Usuario usuario : usuarios) {
        %>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm">

                <div class="card-body">
                    <h5 class="card-title">
                        <%= usuario.getNombre() %>
                    </h5>

                    <p class="card-text text-muted mb-2">
                        <%= usuario.getEmail() %>
                    </p>

                    <p class="mb-1">
                        <strong>Teléfono:</strong>
                        <%= usuario.getTelefono() %>
                    </p>

                    <p class="mb-1">
                        <strong>Saldo:</strong>
                        <%= usuario.getSaldo() %> €
                    </p>

                    <p class="mb-1">
                        <strong>Rol:</strong>
                        <%= usuario.getRol() %>
                    </p>

                    <p class="mb-0">
                        <strong>Estado:</strong>
                        <span class="<%= usuario.isActivo() ? "text-success" : "text-danger" %>">
                            <%= usuario.isActivo() ? "Activo" : "Inactivo" %>
                        </span>
                    </p>
                </div>

                <div class="card-footer bg-white border-0 d-flex gap-2">
                    <a href="view-usuario?id=<%= usuario.getIdUsuario() %>"
                       class="btn btn-dark w-100">
                        Ver detalle
                    </a>

                    <a href="edit-usuario.jsp?id=<%= usuario.getIdUsuario() %>"
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
                No hay usuarios registrados.
            </div>
        </div>

        <%
            }
        %>

    </div>

</main>

<%@ include file="includes/footer.jsp" %>