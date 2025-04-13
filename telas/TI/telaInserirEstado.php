<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <?php include('../../include/includeBase.php'); ?>
  <script src="../../js/funcoes.js"></script>
  <script src="../../js/ti.js"></script>

</head>

<body>

<div class="container mt-5">
  <h1 class="text-success">Dados dos estado:</h1>
  

  <div id="selectNacao"></div>

  <div class="row">
    <div class="col-6">
      <label for="sigla_estado" class="form-label">Nome do estado:</label>
      <input type="text" class="form-control" id="sigla_estado" placeholder="Digite algo...">
    </div>
    <div class="col-6">
      <label for="desc_nacao" class="form-label">Sigla do estado:</label>
      <input type="text" class="form-control" id="desc_nacao" maxlength="3" placeholder="Digite algo...">
    </div>
  </div>

  <div class="mt-3">
    <button type="button" class="btn btn-sm btn-primary" onclick="gravarEstado()">Gravar</button>
  </div>

  <div id="tabelaDeleteUpdate"></div>
</div>


</body>

</html>