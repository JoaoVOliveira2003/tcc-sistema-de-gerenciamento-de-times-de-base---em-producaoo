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
    <script src="../../js/jogador.js"></script>
    <script>
        $(document).ready(function () {
        const usuario = <?php echo json_encode(value: $usuario); ?>;
        listaTodosJogadores(usuario.cod_tipoRole,usuario.cod_usuario);
        });
    </script>
</head>
<?php include('../../componentes/header.php'); ?>

<body>
    <div class="container">

        <div class="mt-1">
            <h2 class="mb-3">Relatorios de jogador por Instituição</h2>
            <h5 class="mb-4">
                Colocar um texto bom aqui posterioremente </h5>
            <hr>



            <div id="todosJogadores"></div>


            <hr>
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