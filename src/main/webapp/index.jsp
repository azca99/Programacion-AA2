<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>

<!-- HERO  -->
<section class="bg-dark text-white text-center py-5">
  <div class="container">
    <h1 class="display-3 fw-bold">God of Games</h1>
    <p class="lead mt-3">
      Tu tienda online de videojuegos clásicos y actuales
    </p>

    <div class="mt-4">
      <a href="videojuegos" class="btn btn-primary btn-lg me-2">
        Ver catálogo
      </a>

    </div>
  </div>
</section>

<!-- JUEGOS DESTACADOS -->
<section class="py-5">
  <div class="container">
    <h2 class="text-center mb-5">Juegos destacados</h2>

    <div class="row g-4">

      <!-- JUEGO1 -->
      <div class="col-md-4">
        <div class="card h-100 shadow-sm">
          <div style="height: 250px; overflow: hidden;">
            <img src="/tienda_images/witcher3.jpg"
                 class="card-img-top"
                 alt="The Witcher 3"
                 style="object-fit: cover">
          </div>

          <div class="card-body">
            <h5 class="card-title">The Witcher 3</h5>
            <p class="card-text">RPG de fantasía.</p>
            <p class="fw-bold text-primary">39,99 €</p>

            <a href="view-videojuego?id=3" class="btn btn-dark w-100">
              Ver detalle
            </a>
          </div>
        </div>
      </div>

      <!-- JUEGO 2 -->
      <div class="col-md-4">
        <div class="card h-100 shadow-sm">
          <div style="height: 250px; overflow: hidden;">
            <img src="/tienda_images/ea-sports-fc-26.jpg"
                 class="card-img-top"
                 alt="FIFA"
                 style="object-fit: cover">
          </div>

          <div class="card-body">
            <h5 class="card-title">EA Sports FC 26</h5>
            <p class="card-text">El simulador de fútbol más popular.</p>
            <p class="fw-bold text-primary">69,99 €</p>

            <a href="view-videojuego?id=6" class="btn btn-dark w-100">
              Ver detalle
            </a>
          </div>
        </div>
      </div>

      <!-- JUEGO 3 -->
      <div class="col-md-4">
        <div class="card h-100 shadow-sm">
          <div style="height: 250px; overflow: hidden;">
            <img src="/tienda_images/zelda-botw.jpg"
                 class="card-img-top"
                 alt="Zelda"
                 style="object-fit: cover">
          </div>

          <div class="card-body">
            <h5 class="card-title">Zelda</h5>
            <p class="card-text">Exploración, puzles y fantasía.</p>
            <p class="fw-bold text-primary">49,99 €</p>

            <a href="view-videojuego?id=5" class="btn btn-dark w-100">
              Ver detalle
            </a>
          </div>
        </div>
      </div>

    </div>
  </div>
</section>

<!-- CATEGORÍAS -->
<section class="bg-light py-5">
  <div class="container">
    <h2 class="text-center mb-5">Categorías</h2>

    <div class="row text-center g-4">

      <div class="col-12 col-sm-6 col-md-3">
        <a href="videojuegos?idCategoria=1" class="text-decoration-none text-dark">
          <div class="card shadow-sm h-100 text-center p-4 hover-card">
            <h5 class="mb-0 fw-semibold">Acción</h5>
          </div>
        </a>
      </div>

      <div class="col-12 col-sm-6 col-md-3">
        <a href="videojuegos?idCategoria=3" class="text-decoration-none text-dark">
          <div class="card shadow-sm h-100 text-center p-4 hover-card">
            <h5 class="mb-0 fw-semibold">RPG</h5>
          </div>
        </a>
      </div>

      <div class="col-12 col-sm-6 col-md-3">
        <a href="videojuegos?idCategoria=2" class="text-decoration-none text-dark">
          <div class="card shadow-sm h-100 text-center p-4 hover-card">
            <h5 class="mb-0 fw-semibold">Deportes</h5>
          </div>
        </a>
      </div>

      <div class="col-12 col-sm-6 col-md-3">
        <a href="videojuegos?idCategoria=5" class="text-decoration-none text-dark">
          <div class="card shadow-sm h-100 text-center p-4 hover-card">
            <h5 class="mb-0 fw-semibold">Aventura</h5>
          </div>
        </a>
      </div>

    </div>
  </div>
</section>

<!-- CATÁLOGO -->
<section class="bg-primary text-white text-center py-5">
  <div class="container">
    <h2>Explora nuestro catálogo</h2>
    <p class="lead">Encuentra videojuegos clásicos, actuales y destacados</p>

    <a href="videojuegos" class="btn btn-light btn-lg">
      Ver catálogo
    </a>
  </div>
</section>

<%@ include file="includes/footer.jsp" %>