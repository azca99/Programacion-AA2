<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="includes/header.jsp" %>

<!-- Formulario con AJAX sin recorgar página -->
<script>
  $(document).ready(function () {
    $("#login-button").click(function (event) {
      event.preventDefault();

      // Buscar formulario
      const form = $("#login-form")[0];

      // Validación
      if (!form.checkValidity()) {
        form.reportValidity();
        return;
      }

      // Crear formulario
      const data = new FormData(form);

      $("#login-button").prop("disabled", true);

      // Enviar al servlet
      $.ajax({
        type: "POST",
        url: "login",
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
          $("#result").html(data);
          $("#login-button").prop("disabled", false);

          // Volver al index
          if (data.includes("alert-success")) {
            setTimeout(function () {
              window.location.href = "index.jsp";
            }, 800);
          }
        },
        error: function (error) {
          $("#result").html(error.responseText);
          $("#login-button").prop("disabled", false);
        }
      });
    });
  });
</script>

<main class="container py-5">

  <div class="row justify-content-center">
    <div class="col-md-5">

      <div class="card shadow-sm">
        <div class="card-body">

          <h1 class="fw-bold mb-4">Iniciar sesión</h1>

          <form id="login-form" method="post">

            <div class="mb-3">
              <label class="form-label">Email</label>
              <input type="email"
                     class="form-control"
                     name="email"
                     required>
            </div>

            <div class="mb-3">
              <label class="form-label">Contraseña</label>
              <input type="password"
                     class="form-control"
                     name="password"
                     required>
            </div>

            <button id="login-button" class="btn btn-primary w-100">
              Entrar
            </button>

          </form>

          <br/>

          <div id="result"></div>

        </div>
      </div>

    </div>
  </div>

</main>

<%@ include file="includes/footer.jsp" %>