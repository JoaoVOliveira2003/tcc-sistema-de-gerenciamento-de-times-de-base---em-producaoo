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
        $(document).ready(function() {
            function selectTurmaEvento() {

            var cod_usuario = <?php echo json_encode($usuario['cod_usuario']); ?>;

            var pagina = "/tcc/componentes/selectBasico.php";
            var query  = "SELECT DISTINCT c.cod_turma, c.desc_turma FROM staff_turma a INNER JOIN staff_turma b ON a.cod_staff = b.cod_staff INNER JOIN turma c ON c.cod_turma = b.cod_turma WHERE b.cod_staff = " + cod_usuario;

            var codSelect = "cod_turma";
            var descSelect = "desc_turma";
            var onclick = "";

            var label = "Pertence a turma:"; 

            var classLabel = "mt-1 form-label";
            var classSelect = "form-control mb-2";
            var forLabel = "turma";
            var idSelect = "turma";
            var name = "turma";
            var primeiroOption = "Qual turma ?";

            $.ajax({
                type: "POST",
                url: pagina,
                data: {
                query: query,
                codSelect: codSelect,
                descSelect: descSelect,
                onclick: onclick,
                label: label,
                classLabel: classLabel,
                forLabel: forLabel,
                classSelect: classSelect,
                idSelect: idSelect,
                name: name,
                primeiroOption: primeiroOption,
                },
                success: function (data) {
                $("#selectTurma").html(data);
                },
            });
            }
            selectTurmaEvento();

            const usuario = <?php echo json_encode($usuario); ?>;

            $('#cod_staff').val(usuario.cod_usuario);

            $('#data_evento').mask('00/00/0000');
            $('#horario_evento').mask('00:00');

            $('#data_evento').on('change', function() {
                let valor = $(this).val();
            });

            $('#horario_evento').on('change', function() {
                let valor = $(this).val();
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
                    <input type="text" class="form-control" name="titulo" id="titulo" placeholder="Digite o título...">
                </div>
                <div class="col-md-6 mb-2">
                    <label for="local" class="form-label">Local do evento:</label>
                    <input type="text" class="form-control" name="local" id="local" placeholder="Local do evento...">
                </div>
            </div>

            <!-- Data e Horário com máscara -->
            <div class="row">
                <div class="col-md-6 mb-1">
                    <label for="data_evento" class="form-label">Data do evento:</label>
                    <input type="text" class="form-control" id="data_evento" name="data_evento" placeholder="dd/mm/aaaa">
                </div>
                <div class="col-md-6 mb-1">
                    <label for="horario_evento" class="form-label">Horário do evento :</label>
                    <input type="text" class="form-control" id="horario_evento" name="horario_evento" placeholder="HH:mm">
                </div>
            </div>


            <!-- Descrição do evento -->
            <div class="mb-1">
                <label for="desc_evento" class="form-label">Descrição do evento:</label>
                <textarea class="form-control" id="desc_evento" name="desc_evento" rows="3" placeholder="Descreva o evento..."></textarea>
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