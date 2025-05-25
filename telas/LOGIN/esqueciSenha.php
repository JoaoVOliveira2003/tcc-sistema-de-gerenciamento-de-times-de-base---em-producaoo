<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <?php include('../../include/includeBase.php'); ?>
  <script src="../../js/funcoes.js"></script>
  <script src="../../js/login.js"></script>

  <title>Redefinir Senha</title>
</head>

<body>
  <div class="container mt-5">
    <div class="row align-items-center justify-content-center">
      <div class="col-md-4 text-center mb-4 mb-md-0">
        <img src="../../img/icone/icone.png" alt="Ícone" class="img-fluid" style="max-width: 300px;">
      </div>

      <div class="col-md-6">
        <h3 class="mb-4 fst-italic text-center text-md-start">
          Esqueceu sua senha?
        </h3>
        <h5 class="mb-3">Por favor, informe o e-mail associado à sua conta para redefinir sua senha.</h5>
        
        <div class="mb-3">
          <label for="email" class="form-label">E-mail do usuário</label>
          <input type="email" class="form-control" id="email" name="email" value="ojoao953@gmail.com" autocomplete="email">
        </div>

        <button onclick="atualizarSenha()" class="btn btn-primary">Atualizar senha.</button>

                    <div class="modal fade" id="modalCarregando" tabindex="-1" aria-labelledby="modalCarregandoLabel"
                aria-hidden="true">
                <div class="modal-dialog d-flex justify-content-center align-items-center">
                    <div class="modal-content">
                        <div class="modal-body text-center">
                            <h5>Carregando...</h5>
                            <div id="carregandoText">*..</div>
                        </div>
                    </div>
                </div>
            </div>
      </div>
    </div>
  </div>
</body>

</html>
