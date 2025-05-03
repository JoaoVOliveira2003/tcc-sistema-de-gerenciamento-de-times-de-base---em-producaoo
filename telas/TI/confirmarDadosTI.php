<!-- <?php
$cod_pessoa = isset($_GET['cod_pessoa']) ? $_GET['cod_pessoa'] : '';
?> -->
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
          const urlParams = new URLSearchParams(window.location.search);
          const codPessoa = urlParams.get('cod_pessoa');
          const emailDestino = urlParams.get('email');
  
          verificarCadastroTI(codPessoa, emailDestino);
        });
    </script>
</head>

<body>
    <div class="container">
        <div class="mt-5">
            <h2 class="mb-3">Confirmação de cadastro de <b>Administrador de Sistema (TI)</b></h2>
            <h5 class="mb-4">
                Olá! <br> voce foi cadastrado como administrador de sistema (TI) no sistema de gestão de bases,
                abaixo estão os seus dados cadastrados, para confirmar a sua inscrição preencha o campo senha e clique no botão confirmar,
                caso queira negar cadastro em recusar.
            </h5>

            <label class="form-label" for="nacao">Nacionalidade:</label>
<input type="text" class="form-control mb-2" id="nacao" value="">

<label class="form-label" for="estado">Natural de:</label>
<input type="text" class="form-control mb-2" id="estado" value="">

<label class="form-label" for="municipio">Município de nascimento:</label>
<input type="text" class="form-control mb-2" id="municipio" value="">



            <div class="row">
                <div class="col-md-6 mb-2">
                    <label for="nome" class="form-label">Nome do administrador:</label>
                    <input type="text" value=" " class="form-control" id="nome" placeholder="Digite o nome...">
                </div>
                <div class="col-md-6 mb-2">
    <label for="email_usuario" class="form-label">Email do administrador:</label>
    <input type="text" class="form-control" id="email_usuario" />
</div>
            </div>

            <div class="row">
                <div class="col-md-3 mb-4">
                    <label for="cpf" class="form-label">CPF:</label>
                    <input maxlength="14"  value="" type="text"
                        class="form-control" id="cpf" placeholder="Digite o CPF...">
                </div>
            </div>

            <button type="button" class="btn btn-primary mb-5" onclick="confirmarCadastroTI()">Confirmar</button>
            <button type="button" class="btn btn-danger mb-5" onclick="recusarCadastroTI()">Recusar</button>
        </div>
    </div>
</body>

</html>