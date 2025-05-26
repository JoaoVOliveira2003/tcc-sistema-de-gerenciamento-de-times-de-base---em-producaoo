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
      tabelaDeleteUpdateMunicipio();
      selectNacoes();
   });
  </script>

</head>

<body>
<?php include('../../componentes/header.php'); ?>
<div class="container">
  <div class=" mt-4">
    <h2 class="mb-4">Gerenciamento de <b>municipios </b></h2>
    
    <h4 class="text-success mb-3">Inserir novo municipio</h4>

    <div id="selectNacao"></div>
    <div id="selectEstado"></div>
    <div class="row">
      <div class="col-md-6 mb-3">
        <label for="desc_municipio" class="form-label">Nome do municipio:</label>
        <input type="text" class="form-control" id="desc_municipio" placeholder="Digite algo...">
      </div>
      <div class="col-md-6 mb-3">
        <label for="sigla_municipio" class="form-label">Sigla do municipio:</label>
        <input type="text" class="form-control" id="sigla_municipio" maxlength="3" placeholder="Digite algo...">
      </div>
    </div>

    <div class="">
      <button type="button" class="btn btn-primary" onclick="gravarMunicipio()">Gravar</button>
    </div>

    <h4 class="text-success mt-3">Vizualizar e atualizar dados</h4>
    <div id="tabelaDeleteUpdate" class="mt-4"></div>
    <div id="modalContainer"></div>
  
   </div>
</div>



</body>

</html>