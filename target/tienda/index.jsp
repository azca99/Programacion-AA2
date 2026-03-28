<%@ page import="com.svalero.tienda.db.Database" %>
<%@ page import="com.svalero.tienda.dao.UsuarioDAO" %>
<%@ page import="static com.svalero.tienda.db.Database.jdbi" %>
<%@ page import="com.svalero.tienda.model.Usuario" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tienda</title>
</head>
<body>
<%
    List<Usuario> allUsuarios = new ArrayList<>();

    Database.connect();
    UsuarioDAO usuarioDAO = Database.jdbi.onDemand(UsuarioDAO.class);
    allUsuarios.addAll(usuarioDAO.getAll());
%>
    <p>Hola</p>
<h1><%= allUsuarios %></h1>
</body>
</html>