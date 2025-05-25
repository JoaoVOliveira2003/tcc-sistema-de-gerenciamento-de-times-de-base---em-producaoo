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
  <script>
    $(document).ready(function () {
      const usuario = <?php echo json_encode($usuario); ?>;
      

      document.getElementById('nome').textContent = usuario.nome;

    });
  </script>

  <title>Seja bem vindo</title>
</head>

<body>
  <div class="container mt-5">
    <div class="row align-items-center justify-content-center">

      <div class="col-md-4 text-center mb-4 mb-md-0">
        <img src="../../img/icone/icone2.png" alt="Ícone" class="img-fluid" style="max-width: 300px;">
      </div>

      <div class="col-md-6 ml-4">
        <h3 class="mb-4 fst-italic text-center text-md-start">
          Olá <span id="nome"></span>, seja bem vindo ao sistema.
        </h3>


        <table class="table">
          <thead>
            <tr>
              <th scope="col">#</th>
              <th scope="col">Primeiro</th>
              <th scope="col">Último</th>
              <th scope="col">Nickname</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <th scope="row">1</th>
              <td>Mark</td>
              <td>Otto</td>
              <td>@mdo</td>
            </tr>
            <tr>
              <th scope="row">2</th>
              <td>Jacob</td>
              <td>Thornton</td>
              <td>@fat</td>
            </tr>
            <tr>
              <th scope="row">3</th>
              <td>Larry</td>
              <td>the Bird</td>
              <td>@twitter</td>
            </tr>
          </tbody>
        </table>


      </div>
    </div>
  </div>
</body>

</html>