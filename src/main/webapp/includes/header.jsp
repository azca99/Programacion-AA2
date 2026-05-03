<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.tienda.model.Usuario" %>

<%
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    boolean esAdmin = usuarioSesion != null && "admin".equals(usuarioSesion.getRol());
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>God of Games</title>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="img/favicon.png">
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">God of Games</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="videojuegos">Catálogo</a>
                </li>
                <!-- pestañas solo para admins -->
                <% if (esAdmin) { %>

                    <li class="nav-item">
                        <a class="nav-link" href="categorias">Categorías</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="usuarios">Usuarios</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="pedidos">Pedidos</a>
                    </li>

                <% } %>
                <!-- Usuario login -->
                <% if (usuarioSesion == null) { %>

                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>

                <% } else { %>

                <li class="nav-item">
                    <span class="nav-link">
                        Hola, <%= usuarioSesion.getNombre() %> (<%= usuarioSesion.getRol() %>)
                    </span>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="logout">Cerrar sesión</a>
                </li>

                <% } %>
            </ul>
        </div>
    </div>
</nav>