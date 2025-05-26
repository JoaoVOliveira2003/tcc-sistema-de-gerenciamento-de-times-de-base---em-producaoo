<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <?php include('../../include/includeBase.php'); ?>
    <script src="../../js/funcoes.js"></script>
    <script src="../../js/staff.js"></script>
    <script>
        $(document).ready(function () {
            selectNacoes(cadastro = 's');
            selectSubInstituicoes();
        });
    </script>
</head>
<?php include('../../componentes/header.php'); ?>
<body>
    <div class="container">
        <div class="mt-1">
            <h2 class="mb-3">Cadastro de <b>STAFF</b></h2>
            <h5 class="mb-4">
                Olá! Lembre-se de que, para que o cadastro seja totalmente validado, a pessoa cadastrada receberá um
                e-mail de confirmação. <br> Nesse e-mail, ela deverá aceitar ou recusar o cadastro, além de inserir a
                senha que deseja. Por isso, certifique-se de que o endereço de e-mail informado está correto.
            </h5>

            <div id="selectNacao" class="mb-2"></div>
            <div id="selectEstado" class="mb-2"></div>
            <div id="selectMunicipio" class="mb-2"></div>

            <div class="col-md-12 mb-3">
                <div id="selectSubInstituicao" class="mb-3"></div>
            </div>


            <div class="row">
                <div class="col-md-6 mb-2">
                    <label for="nome" class="form-label">Nome do integrante da equipe:</label>
                    <input type="text" class="form-control" value="adms" id="nome" placeholder="Digite o nome...">
                </div>
                <div class="col-md-6 mb-2">
                    <label for="email_usuario" class="form-label">E-mail do supervisor:</label>
                    <input type="text" class="form-control" id="email_usuario" value="ojoao953@gmail.com"
                        placeholder="Digite o email...">
                </div>
            </div>

            <div class="row">
                <div class="col-md-3 mb-4">
                    <label for="cpf" class="form-label">CPF:</label>
                    <input maxlength="14" oninput="aplicarMascaraCPF(this)" type="text" value="13432640900"
                        class="form-control" id="cpf" placeholder="Digite o CPF...">
                </div>
            </div>

            <button type="button" class="btn btn-primary mb-5" onclick="gravarStaff()">Gravar</button>

            <!-- Modal de Carregamento -->
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
</body>

</html>