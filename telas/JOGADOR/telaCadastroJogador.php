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
            selectSubInstituicoesTurma();
            selectTipoLesao();
            selectEsporte();


            $('#adicionar-responsavel').on('click', function () {
                const container = $('#responsaveis-container');
                const novo = container.children('.responsavel').first().clone();
                novo.find('input, select').val('');
                container.append(novo);
            });

            // Remover responsável
            $(document).on('click', '.btn-remover-responsavel', function () {
                if ($('.responsavel').length > 1) {
                    $(this).closest('.responsavel').remove();
                } else {
                    alert("Pelo menos um responsável deve ser mantido.");
                }
            });

            // Máscara telefone
            $(document).on('input', 'input[name="responsavel_telefone[]"]', function () {
                $(this).mask('(00) 00000-0000');
            });
            $('input[name="responsavel_telefone[]"]').mask('(00) 00000-0000');

            // Apenas números
            document.getElementById('altura').addEventListener('input', function () {
                this.value = this.value.replace(/\D/g, '');
            });
            document.getElementById('peso').addEventListener('input', function () {
                this.value = this.value.replace(/\D/g, '');
            });

            // Adicionar lesão
            $('#adicionar-lesao').on('click', function () {
                const container = $('#lesoes-container');
                const novo = container.children('.lesao').first().clone();
                novo.find('input, select').val('');
                container.append(novo);
            });

            // Remover lesão
            $(document).on('click', '.btn-remover-lesao', function () {
                if ($('.lesao').length > 1) {
                    $(this).closest('.lesao').remove();
                } else {
                    alert("Pelo menos uma lesão deve ser mantida.");
                }
            });
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
            <hr>

            <!-- Seções Dinâmicas -->
            <div class="row">
                <div id="selectNacao"></div>
                <div id="selectEstado"></div>
                <div id="selectMunicipio"></div>
            </div>

            <div class="col-md-12 mb-3">
                <div id="selectSubInstituicoesTurma" class="mb-3"></div>
                <div id="selectTurma" class="mb-3"></div>
            </div>

            <!-- Dados do administrador -->
            <div class="row">
                <div class="col-md-6 mb-2">
                    <label for="nome" class="form-label">Nome do jogador:</label>
                    <input type="text" class="form-control" value="adms" id="nome" placeholder="Digite o nome...">
                </div>
                <div class="col-md-6 mb-2">
                    <label for="email_usuario" class="form-label">Email do jogador:</label>
                    <input type="email" class="form-control" id="email_usuario" value="ojoao953@gmail.com"
                        placeholder="Digite o email...">
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 mb-3">
                    <label for="data_nascimento" class="form-label">Data de Nascimento:</label>
                    <input type="date" class="form-control" id="data_nascimento" name="data_nascimento">
                </div>

                <div class="col-md-2 mb-3">
                    <label for="cpf" class="form-label">CPF:</label>
                    <input maxlength="14" oninput="aplicarMascaraCPF(this)" type="text" value="13432640900"
                        class="form-control" id="cpf" placeholder="Digite o CPF...">
                </div>

                <div class="col-md-6 mb-3">
                    <label for="imagemJogador" class="form-label">Foto do jogador:</label>
                    <input class="form-control" type="file" id="imagemJogador" accept="image/*">
                </div>
            </div>

            <!-- Seções adicionais -->
            <div class="row">
                <div id="selectEsporte"></div>
                <div id="selectPosicao"></div>
            </div>



            <!-- Responsáveis -->
            <button type="button" class="btn btn-primary mb-5" onclick="gravarJogador()">Gravar</button>

            <hr class="my-2">
            <label class="form-label">Dados dos responsáveis:</label>
            <div id="responsaveis-container">
                <div class="responsavel card mb-3 border rounded p-3 bg-light">
                    <div class="mb-3 pb-2"><strong>Responsável</strong></div>
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
                            <button type="button" class="btn btn-sm btn-danger btn-remover-responsavel">Remover</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mb-2">
                <button type="button" class="btn btn-outline-primary" id="adicionar-responsavel">
                    Adicionar outro responsável
                </button>
            </div>

            <!-- Ficha Médica -->
            <hr>
            <h5 class="mb-3">Ficha Médica</h5>
            <div class="row">
                <div class="col-md-4 mb-3">
                    <label for="altura" class="form-label">Altura (cm):</label>
                    <input type="text" maxlength="3" class="form-control" id="altura" placeholder="Ex: 170">
                </div>
                <div class="col-md-4 mb-3">
                    <label for="peso" class="form-label">Peso (kg):</label>
                    <input type="text" maxlength="3" class="form-control" id="peso" placeholder="Ex: 65">
                </div>
                <div class="col-md-4 mb-3">
                    <label for="tipo_sanguineo" class="form-label">Tipo Sanguíneo:</label>
                    <select id="tipo_sanguineo" class="form-select">
                        <option value="" selected disabled>Selecione</option>
                        <option value="A+">A+</option>
                        <option value="A-">A-</option>
                        <option value="B+">B+</option>
                        <option value="B-">B-</option>
                        <option value="AB+">AB+</option>
                        <option value="AB-">AB-</option>
                        <option value="O+">O+</option>
                        <option value="O-">O-</option>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="restricoes_medicas" class="form-label">Restrições Médicas:</label>
                    <input type="text" class="form-control" id="restricoes_medicas"
                        placeholder="Descreva as restrições, se houver">
                </div>
                <div class="col-md-6 mb-3">
                    <label for="alergias" class="form-label">Alergias:</label>
                    <input type="text" class="form-control" id="alergias" placeholder="Liste as alergias">
                </div>
            </div>

            <!-- Lesões -->
            <hr>
            <h5 class="mb-3">Dados de lesão</h5>

            <div id="lesoes-container">
                <div class="lesao card mb-3 border rounded p-3 bg-light">
                    <div class="row g-3 align-items-end">
                        <!-- Tipo de lesão -->
                        <div class="col-md-6">
                            <label class="form-label">Tipo de lesão</label>
                            <select name="cod_tipoLesao[]" class="form-select">
                                <option value="">Selecione...</option>
                                <option value="1">Lesões de Pele</option>
                                <option value="2">Lesões Musculares</option>
                                <option value="3">Lesões nas Articulações</option>
                                <option value="4">Lesões Neurológicas</option>
                                <option value="5">Lesões no Pé e Tornozelo</option>
                                <option value="6">Lesões no Pescoço ou Coluna</option>
                                <option value="7">Lesões no Quadril ou Lombar</option>
                                <option value="8">Lesões nos Ligamentos</option>
                                <option value="9">Lesões nos Meniscos</option>
                                <option value="10">Lesões nos Ossos</option>
                                <option value="11">Lesões nos Tendões</option>
                            </select>
                        </div>

                        <!-- Data da lesão -->
                        <div class="col-md-3">
                            <label class="form-label">Data da lesão</label>
                            <input type="date" name="data_lesao[]" class="form-control">
                        </div>

                        <!-- Tempo fora -->
                        <div class="col-md-3">
                            <label class="form-label">Tempo fora</label>
                            <input type="text" name="tempoFora_lesao[]" class="form-control"
                                placeholder="Ex: 2 semanas">
                        </div>

                        <!-- Descrição da lesão -->
                        <div class="col-md-12">
                            <label class="form-label">Descrição da lesão</label>
                            <textarea name="desc_lesao[]" class="form-control" rows="2"
                                placeholder="Descreva a lesão..."></textarea>
                        </div>

                        <!-- Botão Remover -->
                        <div class="col-md-2 mt-2">
                            <button type="button" class="btn btn-sm btn-danger btn-remover-lesao">Remover</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mb-2">
                <button type="button" class="btn btn-outline-primary" id="adicionar-lesao">
                    Adicionar lesão
                </button>
            </div>

            <!-- Botão Gravar -->
            <hr>
            <button type="button" class="btn btn-primary mb-5" onclick="gravarJogador()">Gravar</button>

            <!-- Modal Carregando -->
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