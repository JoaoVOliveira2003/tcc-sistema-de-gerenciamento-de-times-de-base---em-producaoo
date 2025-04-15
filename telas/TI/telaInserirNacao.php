<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <?php include('../../include/includeBase.php'); ?>
  <script src="../../js/funcoes.js"></script>
  <script src="../../js/ti.js"></script>
  <script>
    $(document).ready(function() {
      tabelaDeleteUpdateNacao();
   });
  </script>

</head>

<body>


<div class="container">
  <div class=" mt-4">
    <h2 class="mb-4">Gerenciamento de <b>nações </b></h2>

    <h4 class="text-success mb-3">Inserir nova nacão</h4>
     <div class="row">

      <div class="col-md-6 mb-3">
        <label for="desc_nacao" class="form-label">Nome da nacão:</label>
        <input type="text" class="form-control" id="desc_nacao" placeholder="Digite algo...">
      </div>
      <div class="col-md-6 mb-3">
        <label for="sigla_nacao" class="form-label">Sigla da nacão:</label>
        <input type="text" class="form-control" id="sigla_nacao" maxlength="3" placeholder="Digite algo...">
      </div>
    </div>

    <div class="">
      <button type="button" class="btn btn-primary" onclick="gravarNacao()">Gravar</button>
    </div>
    <h4 class="text-success mt-3">Vizualizar e atualizar dados</h4>

    <div id="tabelaDeleteUpdate" class="mt-4"></div>
    <div id="modalContainer"></div>
  </div>
</div>



</body>

</html>