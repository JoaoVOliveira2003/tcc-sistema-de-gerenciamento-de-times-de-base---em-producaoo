<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <?php include('../../include/includeBase.php'); ?>
  <script src="../../js/funcoes.js"></script>
  <script src="../../js/ti.js"></script>
  <script>
    $(document).ready(function () {
      selectNacoesIsolado();
      tabelaDeleteUpdateEstados();
    });
  </script>
</head>
<?php include('../../componentes/header.php'); ?>

<body>
  <div class="container">
    <div class=" mt-4">
      <h2 class="mb-4">Gerenciamento de <b>estados</b></h2>

      <h4 class="text-success mb-3">Inserir novo estado</h4>
      <div id="selectNacao" class="mb-3"></div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="desc_estado" class="form-label">Nome do estado:</label>
          <input type="text" class="form-control" id="desc_estado" placeholder="Digite algo...">
        </div>
        <div class="col-md-6 mb-3">
          <label for="sigla_estado" class="form-label">Sigla do estado:</label>
          <input type="text" class="form-control" id="sigla_estado" maxlength="3" placeholder="Digite algo...">
        </div>
      </div>

      <div class="">
        <button type="button" class="btn btn-primary" onclick="gravarEstado()">Gravar</button>
      </div>
      <h4 class="text-success mt-3">Vizualizar e atualizar dados</h4>

      <div id="tabelaDeleteUpdate" class="mt-4"></div>
      <div id="modalContainer"></div>

    </div>
  </div>



</body>

</html>