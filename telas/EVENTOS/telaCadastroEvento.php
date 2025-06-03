<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();
?>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <?php include('../../include/includeBase.php'); ?>
   
    <script src="../../js/funcoes.js"></script>
    <script src="../../js/evento.js"></script>
    
    <script>
    $(document).ready(function () {
        selectTurma(1);

        const usuario = <?php echo json_encode($usuario); ?>;
        // console.log(usuario);

        console.log(usuario);

        $('#cod_staff').val(usuario.cod_usuario);

        $('#data_evento').mask('00/00/0000');
        $('#horario_evento').mask('00:00');

        // Não precisa usar addEventListener com jQuery, pode usar:
        $('#data_evento').on('change', function () {
            let valor = $(this).val();
            console.log('Data no formato brasileiro: ' + valor);
        });

        $('#horario_evento').on('change', function () {
            let valor = $(this).val();
            console.log('Horário: ' + valor);
        });
    });
    </script>
</head>

<?php include('../../componentes/header.php'); ?>

<body>
    <div class="container">
        <div class="mt-1">
            <h2 class="mb-3">Cadastro de <b>Evento</b></h2>

            <!-- Campos ocultos -->
            <input type="hidden" id="cod_staff" name="cod_staff" />

            <!-- Título e Local -->
            <div class="row">
                <div class="col-md-6 mb-2">
                    <label for="titulo" class="form-label">Título do evento:</label>
                    <input value="titulo" type="text" class="form-control" name="titulo" id="titulo" placeholder="Digite o título...">
                </div>
                <div class="col-md-6 mb-2">
                    <label for="local" class="form-label">Local do evento:</label>
                    <input value="MarianaCross" type="text" class="form-control" name="local" id="local" placeholder="Local do evento...">
                </div>
            </div>

            <!-- Data e Horário com máscara -->
            <div class="row">
                <div class="col-md-6 mb-1">
                    <label for="data_evento" class="form-label">Data do evento:</label>
                    <input type="text" value="02/05/2003" class="form-control" id="data_evento" name="data_evento" placeholder="dd/mm/aaaa">
                </div>
                <div class="col-md-6 mb-1">
                    <label for="horario_evento" class="form-label">Horário do evento :</label>
                    <input type="text" value="02:01" class="form-control" id="horario_evento" name="horario_evento" placeholder="HH:mm">
                </div>
            </div>


             <!-- Descrição do evento -->
            <div class="mb-1">
                <label for="desc_evento" class="form-label">Descrição do evento:</label>
                <textarea class="form-control" id="desc_evento" name="desc_evento" rows="3" placeholder="Descreva o evento...">descrição desci4</textarea>
            </div>




            <!-- Turma -->
            <div id="selectTurma"></div>

            <!-- Botão -->
            <button type="button" class="btn btn-primary mb-5" onclick="gravarEvento()">Gravar</button>

            <!-- Modal de Carregamento -->
            <div class="modal fade" id="modalCarregando" tabindex="-1" aria-labelledby="modalCarregandoLabel" aria-hidden="true">
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
