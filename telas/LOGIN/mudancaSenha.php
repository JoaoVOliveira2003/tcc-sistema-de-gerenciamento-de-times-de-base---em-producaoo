<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <?php include('../../include/includeBase.php'); ?>
  <script src="../../js/funcoes.js"></script>
  <script src="../../js/login.js"></script>
  <title>Tela de atualização de senha</title>
</head>

<body>
  <div class="container mt-5">
    <div class="row align-items-center justify-content-center">
      
      <div class="col-md-4 text-center mb-4 mb-md-0">
        <img src="../../img/icone/icone.png" alt="Ícone" class="img-fluid" style="max-width: 300px;">
      </div>

      <div class="col-md-6 ml-4">
        <h3 class="mb-4 fst-italic text-center text-md-start">
          Atualização de senha
        </h3>

        <div class="mb-3">
          <label for="email" class="form-label">E-mail de usuário</label>
          <input type="email" class="form-control" id="email" name="email" >
        </div>

        <div class="mb-3">
          <label for="senha" class="form-label">Senha</label>
          <input type="password" class="form-control" id="senha" name="senha" >
        </div>

        <button onclick="fazerLogin()" class="btn btn-primary">Entrar</button>
        <a href="esqueciSenha.php" class="btn btn-primary text-white text-decoration-none">
          Esqueci senha
        </a>


      </div>
    </div>
  </div>
</body>

</html>