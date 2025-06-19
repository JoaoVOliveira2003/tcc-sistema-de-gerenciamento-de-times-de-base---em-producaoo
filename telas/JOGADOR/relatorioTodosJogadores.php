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
            const usuario = <?php echo json_encode($usuario); ?>;
            listaTodosJogadores(usuario.cod_tipoRole, usuario.cod_usuario);
            document.getElementById("usuarioCodStaff").value = usuario.cod_usuario;
            document.getElementById("cod_role").value = usuario.cod_tipoRole;
        });
    </script>
</head>

<?php include('../../componentes/header.php'); ?>
<input type="hidden" id="usuarioCodStaff">
<input type="hidden" id="cod_role">

<body>
    <div class="container">
        <div class="mt-1">
            <h2 class="mb-3">Relatórios de Jogador por Instituição</h2>
            <h5 class="mb-4">Colocar um texto bom aqui posteriormente</h5>
            <hr>
            <div id="todosJogadores"></div>
            <hr>
            <div id="modalContainer"></div>

        </div>
    </div>
</body>

</html>
