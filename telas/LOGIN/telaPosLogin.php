<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();
?>

<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <?php include('../../include/includeBase.php'); ?>
  <script src="../../js/funcoes.js"></script>
  <script src="../../js/login.js"></script>
  <script src="../../js/evento.js"></script>


<script>
    $(document).ready(function () {
      const usuario = <?php echo json_encode(value: $usuario); ?>;
      document.getElementById('nome').textContent = usuario.nome;

      proximosTresEventos(usuario.cod_tipoRole,usuario.cod_usuario);
    });
  </script>

  <title>Seja bem vindo</title>
</head>
<?php include('../../componentes/header.php'); ?>

<body>
  <div class="container mt-5">
    <div class="row align-items-center justify-content-center">

      <div class="col-md-4 text-center mb-4 mb-md-0">
        <img src="../../img/icone/icone2.png" alt="Ícone" class="img-fluid" style="max-width: 300px;">
      </div>

      <div class="col-md-6 ml-4">
        <h3 class="mb-4 fst-italic text-center text-md-start">
          Olá <span id="nome"></span>, seja bem vindo ao sistema!
        </h3>

        <div id="proximosTresEventos"></div>

      </div>
    </div>
  </div>
</body>

</html>