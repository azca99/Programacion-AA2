# God of Games - Tienda online de videojuegos

## Descripción

Proyecto web desarrollado para la asignatura de **Programación de 1º DAM**.

La aplicación simula una tienda online de videojuegos llamada **God of Games**. Permite gestionar videojuegos, categorías, usuarios y pedidos mediante una aplicación web conectada a una base de datos **MariaDB**.

---

## Tecnologías utilizadas

- Java
- Jakarta Servlet
- JSP
- JDBI3
- MariaDB
- HTML
- CSS
- JavaScript
- AJAX
- Bootstrap 5
- Apache Tomcat
- Maven
- IntelliJ IDEA

---

## Funcionalidades principales

La aplicación permite:

- Ver una página principal con juegos destacados y accesos al catálogo.
- Ver un catálogo de videojuegos.
- Ver el detalle de cada videojuego.
- Crear, editar y eliminar videojuegos.
- Crear, editar y eliminar categorías.
- Crear, editar y eliminar usuarios.
- Crear, editar y eliminar pedidos.
- Buscar videojuegos por título y categoría.
- Buscar categorías por nombre y estado.
- Buscar usuarios por nombre/email y rol.
- Iniciar sesión.
- Cerrar sesión.
- Diferenciar permisos entre usuario administrador y usuario cliente.
- Subir imágenes asociadas a videojuegos.
- Mostrar mensajes de éxito y error mediante AJAX.
- Solicitar confirmación antes de guardar o eliminar datos.

---

## Roles de usuario

La aplicación contempla dos roles principales:

### Administrador

El usuario administrador puede:

- Acceder a la gestión de videojuegos.
- Acceder a la gestión de categorías.
- Acceder a la gestión de usuarios.
- Acceder a la gestión de pedidos.
- Crear, modificar y eliminar registros.
- Acceder a las páginas de administración.

### Cliente

El usuario cliente puede:

- Ver la página principal.
- Consultar el catálogo de videojuegos.
- Ver el detalle de los videojuegos.
- Cerrar sesión.

El usuario cliente no puede acceder a las páginas ni acciones de administración.

---

## Estructura del proyecto

La aplicación sigue una estructura basada en separación de responsabilidades:

- `src/main/java/com/svalero/tienda`
  - `dao`
    - `UsuarioDAO.java`
    - `CategoriaDAO.java`
    - `VideojuegoDAO.java`
    - `PedidoDAO.java`
    - `UsuarioMapper.java`
    - `CategoriaMapper.java`
    - `VideojuegoMapper.java`
    - `PedidoMapper.java`
  - `db`
    - `Database.java`
  - `model`
    - `Usuario.java`
    - `Categoria.java`
    - `Videojuego.java`
    - `Pedido.java`
  - `servlet`
    - `ListVideojuegos.java`
    - `ViewVideojuego.java`
    - `EditVideojuego.java`
    - `DeleteVideojuego.java`
    - `ListCategorias.java`
    - `ViewCategoria.java`
    - `EditCategoria.java`
    - `DeleteCategoria.java`
    - `ListUsuarios.java`
    - `ViewUsuario.java`
    - `EditUsuario.java`
    - `DeleteUsuario.java`
    - `ListPedidos.java`
    - `ViewPedido.java`
    - `EditPedido.java`
    - `DeletePedido.java`
    - `LoginServlet.java`
    - `LogoutServlet.java`

Las páginas JSP se encuentran en:

- `src/main/webapp`
  - `index.jsp`
  - `videojuegos.jsp`
  - `view-videojuego.jsp`
  - `edit-videojuego.jsp`
  - `categorias.jsp`
  - `view-categoria.jsp`
  - `edit-categoria.jsp`
  - `usuarios.jsp`
  - `view-usuario.jsp`
  - `edit-usuario.jsp`
  - `pedidos.jsp`
  - `view-pedido.jsp`
  - `edit-pedido.jsp`
  - `login.jsp`
  - `includes`
    - `header.jsp`
    - `footer.jsp`
  - `img`
    - `favicon.png`
    - imágenes estáticas utilizadas en la página principal

---

## Base de datos

La aplicación utiliza una base de datos MariaDB llamada:

```sql
CREATE DATABASE tienda;
```

### Tablas principales

- `usuario`
- `categoria`
- `videojuego`
- `pedido`

### Relaciones principales

- Una categoría puede clasificar muchos videojuegos.
- Un videojuego pertenece a una categoría.
- Un usuario puede tener muchos pedidos.
- Un pedido pertenece a un usuario.

---

## Configuración de imágenes

Las imágenes de los videojuegos **no se guardan dentro de la base de datos**.

La base de datos almacena únicamente el nombre del archivo de imagen.

Ejemplo:

```text
godofwar.jpg
```

Las imágenes se guardan en una carpeta externa dentro de Tomcat:

```text
webapps/tienda_images
```

Ejemplo en Windows:

```text
E:/Tomcat/webapps/tienda_images
```

Ejemplo según la instalación concreta de Tomcat:

```text
E:/apache-tomcat-11.0.18/webapps/tienda_images
```

La aplicación muestra las imágenes usando rutas de este tipo:

```text
/tienda_images/nombre-imagen.jpg
```

### Instrucciones para configurar imágenes

Antes de ejecutar la aplicación, se debe crear manualmente la carpeta `tienda_images` dentro de la carpeta `webapps` de Tomcat.

Ejemplo:

```text
apache-tomcat-11.0.18
└── webapps
    ├── tienda
    └── tienda_images
```

Las imágenes subidas desde el formulario de videojuegos se guardarán automáticamente en esa carpeta.

Si se clona el proyecto en otro ordenador, será necesario:

- Crear la carpeta `tienda_images` dentro de `webapps`.
- Revisar la ruta usada en `EditVideojuego.java` para que coincida con la instalación local de Tomcat.
- Copiar en esa carpeta las imágenes iniciales si se quieren conservar las referencias ya insertadas en la base de datos.

---

## Configuración de la base de datos

La conexión a la base de datos se configura en la clase:

```text
Database.java
```

Se debe comprobar que los datos de conexión coincidan con la configuración local:

```java
String url = "jdbc:mariadb://localhost:3306/tienda";
String username = "root";
String password = "";
```

Estos valores pueden variar según la configuración de cada equipo.

---

## Despliegue en Tomcat

Comandos básicos con Maven:

### Desplegar

```bash
mvn tomcat7:deploy
```

### Redesplegar

```bash
mvn tomcat7:redeploy
```

### Quitar despliegue

```bash
mvn tomcat7:undeploy
```

### Limpiar y empaquetar

```bash
mvn clean package
```

### Comando recomendado si hay problemas

```bash
mvn clean package
mvn tomcat7:redeploy
```

---

## Rutas principales

- `/index.jsp`
- `/videojuegos`
- `/categorias`
- `/usuarios`
- `/pedidos`
- `/login.jsp`
- `/logout`

---

## Usuarios de prueba

### Usuario administrador

- Email: `admin@tienda.com`
- Contraseña: `admin123`
- Rol: `admin`

### Usuario cliente

- Email: `cliente@tienda.com`
- Contraseña: `cliente123`
- Rol: `cliente`

Estos datos pueden variar según los registros insertados en la base de datos.

---

## Decisiones tomadas

### Uso de DAO

Se utiliza el patrón DAO para separar la lógica de acceso a datos del resto de la aplicación.

De esta forma, los servlets no contienen SQL directamente, sino que llaman a métodos definidos en los DAO.

### Uso de mappers

Los mappers convierten los resultados de la base de datos en objetos Java.

Por ejemplo, una fila de la tabla `videojuego` se convierte en un objeto `Videojuego`.

### Uso de servlets

Los servlets actúan como controladores.

Reciben las peticiones del usuario, llaman a los DAO y envían los datos a las páginas JSP.

### Uso de JSP

Las páginas JSP se utilizan como vistas.

Su función principal es mostrar los datos recibidos desde los servlets o mostrar formularios de alta y edición.

### Uso de Bootstrap

Bootstrap se utiliza para crear una interfaz visual sencilla, ordenada y responsive.

Se emplean componentes como navbar, cards, botones, formularios y alertas.

### Uso de AJAX

Se utiliza AJAX en los formularios de alta y modificación para enviar los datos sin recargar completamente la página.

También permite mostrar mensajes de éxito o error dentro de la propia página.

### Gestión de imágenes

Las imágenes se guardan fuera del proyecto desplegado para evitar que se pierdan al hacer redeploy de la aplicación.

La base de datos solo almacena el nombre del archivo, no la imagen completa.

### Roles y permisos

Se diferencian dos roles:

- `admin`
- `cliente`

El rol `admin` puede gestionar las entidades principales de la aplicación.

El rol `cliente` puede navegar por la parte pública, pero no puede acceder a la administración.

---

## Estado del proyecto

El proyecto incluye las funcionalidades principales solicitadas:

- Base de datos relacional con 4 tablas.
- CRUD completo de videojuegos.
- CRUD completo de categorías.
- CRUD completo de usuarios.
- CRUD básico de pedidos.
- Login y logout.
- Roles de usuario.
- Búsquedas con varios criterios.
- Validaciones en formularios.
- Subida de imágenes.
- Uso de Bootstrap.
- Uso de AJAX.
- Confirmaciones antes de guardar o eliminar datos.