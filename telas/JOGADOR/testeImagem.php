<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8">
  <title>Contatos do Responsável</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <?php include('../../include/includeBase.php'); ?>
    <script src="../../js/funcoes.js"></script>
    <script src="../../js/jogador.js"></script>
</head>

<body>
  <div class="col-md-6 mb-3">
    <label for="imagemJogador" class="form-label">Foto do jogador:</label>
    <input class="form-control" type="file" id="imagemJogador" accept="image/*">
  </div>
</body>

<button onclick="gravarImagemJogador()">Gravar</button>

</html>