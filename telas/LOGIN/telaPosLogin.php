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


        <table class="table table-bordered">
          <caption style="caption-side: top; text-align: left; font-weight: bold; font-size: 1.2em;">PRÓXIMOS TRÊS
            EVENTOS</caption>
          <thead class="thead-light">
            <tr>
              <th>Data</th>
              <th>Local</th>
              <th>Título</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>25/05/2025</td>
              <td>Monza</td>
              <td>Treino sub-20</td>
            </tr>
            <tr>
              <td>10/06/2025</td>
              <td>Maracanã</td>
              <td>Peneira</td>
            </tr>
            <tr>
              <td>15/07/2025</td>
              <td>Guaraituba</td>
              <td>Aula de salsa</td>
            </tr>
            <td colspan="3">
              <div style=" margin-left: 64%;">
                <button class="btn btn-sm btn-secondary">Ver eventos por completo</button>
              </div>
            </td>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</body>

</html>