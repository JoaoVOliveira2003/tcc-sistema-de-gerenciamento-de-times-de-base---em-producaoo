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
        const usuario = <?php echo json_encode(value: $usuario); ?>;
        todosEventos(usuario.cod_tipoRole,usuario.cod_usuario);
    });
    </script>
</head>

<?php include('../../componentes/header.php'); ?>

<body>
    <div class="container mt-4">
        <h2 class="mb-3">Lista dos próximos eventos</h2>

<!-- <div class="accordion" id="accordionExample">
    <div class="accordion-item mb-3 border border-secondary rounded">
        <h2 class="accordion-header" id="headingOne">
            <button class="accordion-button rounded-top" type="button" data-bs-toggle="collapse"
                data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                Evento #1
            </button>
        </h2>
        <div id="collapseOne" class="accordion-collapse collapse show rounded-bottom" aria-labelledby="headingOne"
            data-bs-parent="#accordionExample">
            <div class="accordion-body border-top">
                Conteúdo do Evento #1
            </div>
        </div>
    </div>

    <div class="accordion-item mb-3 border border-secondary rounded">
        <h2 class="accordion-header" id="headingTwo">
            <button class="accordion-button collapsed rounded-top" type="button" data-bs-toggle="collapse"
                data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                Evento #2
            </button>
        </h2>
        <div id="collapseTwo" class="accordion-collapse collapse rounded-bottom" aria-labelledby="headingTwo"
            data-bs-parent="#accordionExample">
            <div class="accordion-body border-top">
                Conteúdo do Evento #2
            </div>
        </div>
    </div>

    <div class="accordion-item mb-3 mt-3 border border-secondary rounded">
        <h2 class="accordion-header" id="headingThree">
            <button class="accordion-button collapsed rounded-top" type="button" data-bs-toggle="collapse"
                data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                Evento #3
            </button>
        </h2>
        <div id="collapseThree" class="accordion-collapse collapse rounded-bottom" aria-labelledby="headingThree"
            data-bs-parent="#accordionExample">
            <div class="accordion-body border-top">
                Conteúdo do Evento #3
            </div>
        </div>
    </div>
</div> -->
        <div id="todosEventos"></div>


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
</body>

</html>
