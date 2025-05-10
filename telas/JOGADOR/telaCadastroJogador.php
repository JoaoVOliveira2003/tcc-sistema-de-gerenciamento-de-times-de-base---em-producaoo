<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <?php include('../../include/includeBase.php'); ?>
    <script src="../../js/funcoes.js"></script>
    <script src="../../js/jogador.js"></script>

    <script>
        $(document).ready(function () {
            selectNacoes('s');
            selectSubInstituicoes();

            $('#adicionar-responsavel').on('click', function () {
                const container = $('#responsaveis-container');
                const novo = container.children('.responsavel').first().clone();
                novo.find('input').val('');
                novo.find('select').val('');
                container.append(novo);
            });

            $(document).on('click', '.btn-remover', function () {
                const total = $('.responsavel').length;
                if (total > 1) {
                    $(this).closest('.responsavel').remove();
                } else {
                    alert("Pelo menos um responsável deve ser mantido.");
                }
            });

            $(document).on('input', 'input[name="responsavel_telefone[]"]', function () {
                $(this).mask('(00) 00000-0000');
            });

            $('input[name="responsavel_telefone[]"]').mask('(00) 00000-0000');
        });
    </script>
</head>

<body>
    <div class="container">
        <div class="mt-5">
            <h2 class="mb-3">Cadastro de <b>JOGADOR</b></h2>
            <h5 class="mb-4">
                Olá! Lembre-se de que, para que o cadastro seja totalmente validado, a pessoa cadastrada receberá um
                e-mail de confirmação. Nesse e-mail, ela deverá aceitar ou recusar o cadastro, além de inserir a
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
                    <label for="nome" class="form-label">Nome do administrador:</label>
                    <input type="text" class="form-control" value="adms" id="nome" placeholder="Digite o nome...">
                </div>
                <div class="col-md-6 mb-2">
                    <label for="email_usuario" class="form-label">Email do administrador:</label>
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

            <hr class="my-2">

            <div id="responsaveis-container">
                <label class="form-label">Dados dos responsáveis:</label>
                <div class="responsavel card mb-3 shadow-sm border rounded p-3 bg-light">
                    <div class="mb-3 border-bottom pb-2">
                        <strong>Responsável</strong>
                    </div>
                    <div class="row g-2 mb-2">
                        <div class="col-md-6">
                            <input type="text" name="responsavel_nome[]" class="form-control"
                                placeholder="Nome do Responsável" required>
                        </div>
                        <div class="col-md-6">
                            <select name="responsavel_filiacao[]" class="form-select" required>
                                <option value="" disabled selected>Tipo de filiação</option>
                                <option value="Pai">Pai</option>
                                <option value="Mãe">Mãe</option>
                                <option value="Responsável legal">Responsável legal</option>
                                <option value="Outro">Outro</option>
                            </select>
                        </div>
                    </div>
                    <div class="row g-2">
                        <div class="col-md-6">
                            <input type="email" name="responsavel_email[]" class="form-control"
                                placeholder="Email do Responsável" required>
                        </div>
                        <div class="col-md-5">
                            <input type="text" name="responsavel_telefone[]" class="form-control"
                                placeholder="Telefone do Responsável" required>
                        </div>
                        <div class="col-md-1 d-grid">
                            <button type="button" class="btn btn-sm btn-danger btn-remover">Remover</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mb-2">
                <button type="button" class="btn btn-outline-primary" id="adicionar-responsavel">
                    Adicionar outro responsável
                </button>
            </div>

            <hr>

            <button type="button" class="btn btn-primary mb-5" onclick="gravarJogador()">Gravar</button>

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
