<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>

<!-- HERO PRINCIPAL -->
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

      <a href="#" class="btn btn-outline-light btn-lg">
        Ofertas
      </a>
    </div>
  </div>
</section>

<!-- JUEGOS DESTACADOS -->
<section class="py-5">
  <div class="container">
    <h2 class="text-center mb-5">Juegos destacados</h2>

    <div class="row g-4">

      <!-- CARD 1 -->
      <div class="col-md-4">
        <div class="card h-100 shadow-sm">
          <img src="img/gow.jpg" class="card-img-top" alt="God of War">

          <div class="card-body">
            <h5 class="card-title">God of War</h5>
            <p class="card-text">Acción mitológica y aventura épica.</p>
            <p class="fw-bold text-primary">59,99 €</p>

            <a href="#" class="btn btn-dark w-100">
              Ver detalle
            </a>
          </div>
        </div>
      </div>

      <!-- CARD 2 -->
      <div class="col-md-4">
        <div class="card h-100 shadow-sm">
          <img src="img/fifa.jpg" class="card-img-top" alt="FIFA">

          <div class="card-body">
            <h5 class="card-title">FIFA 24</h5>
            <p class="card-text">El simulador de fútbol más popular.</p>
            <p class="fw-bold text-primary">49,99 €</p>

            <a href="#" class="btn btn-dark w-100">
              Ver detalle
            </a>
          </div>
        </div>
      </div>

      <!-- CARD 3 -->
      <div class="col-md-4">
        <div class="card h-100 shadow-sm">
          <img src="img/zelda.jpg" class="card-img-top" alt="Zelda">

          <div class="card-body">
            <h5 class="card-title">Zelda</h5>
            <p class="card-text">Exploración, puzles y fantasía.</p>
            <p class="fw-bold text-primary">54,99 €</p>

            <a href="#" class="btn btn-dark w-100">
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

      <div class="col-md-3">
        <div class="p-4 bg-white rounded shadow-sm">
          <h5>Acción</h5>
        </div>
      </div>

      <div class="col-md-3">
        <div class="p-4 bg-white rounded shadow-sm">
          <h5>RPG</h5>
        </div>
      </div>

      <div class="col-md-3">
        <div class="p-4 bg-white rounded shadow-sm">
          <h5>Deportes</h5>
        </div>
      </div>

      <div class="col-md-3">
        <div class="p-4 bg-white rounded shadow-sm">
          <h5>Retro</h5>
        </div>
      </div>

    </div>
  </div>
</section>

<!-- OFERTA -->
<section class="bg-primary text-white text-center py-5">
  <div class="container">
    <h2>Ofertas de la semana</h2>
    <p class="lead">Hasta un 30% de descuento en juegos seleccionados</p>

    <a href="#" class="btn btn-light btn-lg">
      Ver promociones
    </a>
  </div>
</section>

<%@ include file="includes/footer.jsp" %>