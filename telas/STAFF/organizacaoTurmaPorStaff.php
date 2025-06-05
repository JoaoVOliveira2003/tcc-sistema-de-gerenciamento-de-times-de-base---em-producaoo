<?php
// include '../../include/verificaSessao.php';
// $usuario = verificarLogin();
?>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <?php include('../../include/includeBase.php'); ?>
    <script src="../../js/funcoes.js"></script>
    <script src="../../js/staff.js"></script>
    <script>    
        $(document).ready(function () {
            tabelaRelacaoStaffTurma();

        });
    </script>
</head>
<?php include('../../componentes/header.php'); ?>
<body>
    <div class="container">
        <div class="mt-1">
            <h2 class="mb-3"><b>Organização de turmas a staff</b></h2>
            <h5 class="mb-4">
                escrever texto posteriormente!
            </h5>


            <div id="tabelaRelacaoStaffTurma"></div>

            <div id="modalContainer"></div>

       
        </div>
    </div>
</body>

</html>