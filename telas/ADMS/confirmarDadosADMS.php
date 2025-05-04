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
    <script src="../../js/admi.js"></script>
    <script>
        $(document).ready(function () {
            const urlParams = new URLSearchParams(window.location.search);
            const codPessoa = urlParams.get('cod_pessoa');
            const emailDestino = urlParams.get('email');

            verificarCadastroADMI(codPessoa, emailDestino);

            $('#btnRecusar').attr('data-cod', codPessoa);
            $('#btnConfirmar').attr('data-cod', codPessoa);
        });
    </script>
</head>

<body>
    <div class="container">
        <div class="mt-2">
            <h2 class="mb-3">Confirmação de cadastro de <b>Administrador de Sistema (ADMS)</b></h2>
            <h5 class="mb-2">
                Olá! <br> Você foi cadastrado como administrador de sistema (ADMS) no sistema de gestão de bases.
                Abaixo estão os seus dados cadastrados. Para confirmar a sua inscrição, preencha o campo senha e clique
                no botão "Confirmar".<br>
                Caso queira negar o cadastro, clique em "Recusar".
            </h5>

            <label class="form-label" for="nacao">Nacionalidade:</label>
            <input type="text" class="form-control mb-2" id="nacao" value="">

            <label class="form-label" for="estado">Natural de:</label>
            <input type="text" class="form-control mb-2" id="estado" value="">

            <label class="form-label" for="municipio">Município de nascimento:</label>
            <input type="text" class="form-control mb-2" id="municipio" value="">

            <label class="form-label" for="instituicao">Pertence instituição:</label>
            <input type="text" class="form-control mb-2" id="instituicao" value="">

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

            <button type="button" class="btn btn-primary mt-1" id="btnConfirmar" onclick="confirmarCadastroADMI(this.getAttribute('data-cod'))">Confirmar</button>
            <button type="button" class="btn btn-danger mt-1"  id="btnRecusar"   onclick="recusarCadastroADMI(this.getAttribute('data-cod'))">Recusar</button>

            <div id="modalContainer"></div>
        </div>
    </div>
</body>

</html>
