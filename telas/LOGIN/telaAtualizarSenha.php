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
    <script src="../../js/login.js"></script>
    <script>
        $(document).ready(function () {
            const urlParams = new URLSearchParams(window.location.search);
            const codPessoa = urlParams.get('cod_pessoa');
            const emailDestino = urlParams.get('email');

            $('#btnRecusar').attr('data-cod', codPessoa);
            $('#btnConfirmar').attr('data-cod', codPessoa);
        });
    </script>
</head>

<body>
    <div class="container">
        <div class="mt-2">
            <h2 class="mb-3">Atualização de dados</b></h2>

            <div class="row">
                <div class="col-md-6 mb-2">
                    <label for="nome" class="form-label">Nome do administrador:</label>
                    <input type="text" class="form-control" id="nome" placeholder="Digite o nome..." value="">
                </div>

                <div class="col-md-6 mb-4">
                    <label for="cpf" class="form-label">CPF:</label>
                    <input type="text" maxlength="14" class="form-control" id="cpf" placeholder="Digite o CPF..." value="">
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-2">
                    <label for="email_usuario" class="form-label">Email do administrador:</label>
                    <input type="text" class="form-control" id="email_usuario" value="">
                </div>
                <div class="col-md-6 mb-2">
                    <label for="senha_usuario" class="form-label">Senha do administrador:</label>
                    <input type="text" class="form-control" id="senha_usuario" value="">
                </div>
            </div>

            <button type="button" class="btn btn-primary mt-1" id="btnConfirmar" onclick="confirmarCadastro(this.getAttribute('data-cod'))">Confirmar</button>

            <div id="modalContainer"></div>
        </div>
    </div>
</body>

</html>
