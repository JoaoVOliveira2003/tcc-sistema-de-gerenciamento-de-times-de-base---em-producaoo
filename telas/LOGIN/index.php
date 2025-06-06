<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <?php include('../../include/includeBase.php'); ?>
  <script src="../../js/funcoes.js"></script>
  <script src="../../js/login.js"></script>
  <title>Tela de Login</title>
</head>

<body>
  <div class="container mt-5">
    <div class="row align-items-center justify-content-center">

      <div class="col-md-4 text-center mb-4 mb-md-0">
        <img src="../../img/icone/icone.png" alt="Ícone" class="img-fluid" style="max-width: 300px;">
      </div>

      <div class="col-md-6 ml-4">
        <h3 class="mb-4 fst-italic text-center text-md-start">
          Login<br> Sistema Gerenciador de times de base esportiva
        </h3>

        <!-- FORMULÁRIO -->
        <form id="formLogin" onsubmit="fazerLogin(); return false;">
          <div class="mb-3">
            <label for="email" class="form-label">E-mail de usuário</label>
            <input type="email" value="staff10@gmail.com" class="form-control" id="email" name="email" >
          </div>

          <div class="mb-3">
            <label for="senha" class="form-label">Senha</label>
            <div class="input-group">
              <input type="password" class="form-control" value="staff10" id="senha" name="senha" >
              <button class="btn btn-outline-secondary" type="button" onclick="toggleSenha()">
                <img src="../../img\icone\olho.png" width="15" height="15" alt="">
              </button>
            </div>
          </div>

          <div class="d-grid gap-2 d-md-block">
            <button type="submit" class="btn btn-primary">Entrar</button>
            <a href="esqueciSenha.php" class="btn btn-primary text-white text-decoration-none">Esqueci senha</a>
          </div>
        </form>

      </div>
    </div>
  </div>

  <script>
    function toggleSenha() {
      const campoSenha = document.getElementById("senha");
      campoSenha.type = campoSenha.type === "password" ? "text" : "password";
    }

  </script>
</body>

</html>
