<?php
$cod_pessoa = isset($_GET['cod_pessoa']) ? $_GET['cod_pessoa'] : '';
?> 
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

            document.getElementById('email_usuario').value = emailDestino;
            document.getElementById('codPessoa').value = codPessoa;


        });
    </script>
</head>

<body>
<input type="hidden" id="codPessoa">

    <div class="container" style="margin-top: 10vh;">
        <div class="mt-2">
            <h2 class="mb-3">Atualização de senha - Sistema Gerenciador de Base de Times Esportivos</b></h2>

                <div class="row">
                <div class="col-md-6 mb-2">
                    <label for="email_usuario" class="form-label">Email cadastrado:</label>
                    <input type="text" class="form-control" id="email_usuario" disabled>
                </div>
                <div class="col-md-6 mb-2">
                    <label for="senha_usuario" class="form-label">Nova senha:</label>
                    <input type="text" class="form-control" id="senha_usuario" value="">
                </div>
            </div>

            <button type="button" class="btn btn-primary mt-1" id="btnConfirmar" onclick="mudarSenha(this.getAttribute('data-cod'))">Confirmar</button>

            <div id="modalContainer"></div>
        </div>
    </div>
</body>

</html>
