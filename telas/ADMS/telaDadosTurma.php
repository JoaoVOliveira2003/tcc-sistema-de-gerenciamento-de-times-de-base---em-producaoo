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
  <script src="../../js/adms.js"></script>
  <script>
    $(document).ready(function () {
      tabelaDeleteUpdateTurma();
      selectSubInstituicoes();
    });
  </script>
</head>
<?php include('../../componentes/header.php'); ?>

<body>


  <div class="container">
    <div class=" mt-4">
      <h2 class="mb-4">Gerenciamento de <b>Turmas</b></h2>
      <h4 class="text-success mb-3">Inserir nova turma.</h4>
      <div class="row">
        <div class="col-md-6 mb-3">
          <div id="selectSubInstituicao" class="mb-3"></div>
        </div>
        <div class="col-md-6 mb-3">
          <label for="desc_turma" class="form-label">Nome da turma:</label>
          <input type="text" class="form-control" id="desc_turma" placeholder="Digite algo...">
        </div>
      </div>
        <button type="button" class="btn btn-primary" onclick="gravarTurma()">Gravar</button>
      <h4 class="text-success mt-3">Vizualizar e atualizar dados</h4>
      <div id="tabelaDeleteUpdate" class="mt-4"></div>
      <div id="modalContainer"></div>

    </div>
  </div>



</body>

</html>