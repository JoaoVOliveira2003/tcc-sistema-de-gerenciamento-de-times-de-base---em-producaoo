<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
  <title>Modal sobre Modal</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    /* Corrigir sobreposição do segundo modal e backdrop */
    .modal-backdrop.show:nth-of-type(2) {
      z-index: 1055;
    }

    #modal2 {
      z-index: 1060;
    }
  </style>
</head>
<body class="p-5">

  <!-- Botão que abre o primeiro modal -->
  <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal1">
    Abrir Modal 1
  </button>

  <!-- Modal 1 -->
  <div class="modal fade" id="modal1" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Modal 1</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
        </div>
        <div class="modal-body">
          Este é o primeiro modal.
          <hr>
          <!-- Botão que abre o segundo modal por cima -->
          <button type="button" class="btn btn-secondary" onclick="abrirModal2()">
            Abrir Modal 2 (por cima)
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal 2 -->
  <div class="modal fade" id="modal2" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Modal 2</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
        </div>
        <div class="modal-body">
          Este é o segundo modal (acima do primeiro).
        </div>
      </div>
    </div>
  </div>

  <!-- Scripts Bootstrap -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    function abrirModal2() {
      const modal2 = new bootstrap.Modal(document.getElementById('modal2'));
      modal2.show();
    }
  </script>
</body>
</html>
