<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <?php include('include/includeBase.php'); ?> 
  <script src="js/index.js">
    $(document).ready(function() {
     
selectTiposInstituto();
   });
  </script> 
  <script src="js/funcoes.js"></script> 
     $(document).ready(function() {
     selectNacoesIsolado();
     tabelaDeleteUpdateEstados();
   });
</head>
<body>

  <div class="container mt-5">
    <h1 class="text-success"> index!</h1>
    

    <div id="selectNacao"></div>
    <div id="selectEstado"></div>
    <div id="selectMunicipio"></div>
  </div>

</body>
</html>
