<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();
?>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <?php include('../../include/includeBase.php'); ?>
    <script src="../../js/funcoes.js"></script>
    <script src="../../js/meusDados.js"></script>
    <script>
        $(document).ready(function () {
            const usuario = <?php echo json_encode($usuario); ?>;
            meusDados(usuario.cod_usuario , usuario.cod_tipoRole);
            console.log(usuario);
        });
    </script>
</head>
<?php include('../../componentes/header.php'); ?>
<body>
    <div class="container">
        <div class="mt-1">
            <div id="meusDados" class="mb-2"></div>
        </div>
    </div>
</body>

</html>