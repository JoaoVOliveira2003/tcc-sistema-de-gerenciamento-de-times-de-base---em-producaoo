<?php
include('../../include/includeBase.php');

$nome = 'João';
$tipoRole = 'Gestor';

$corpo = '
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <div class="container mt-5">
        <div class="card shadow-lg border-0">
            <div class="card-body text-center">
                <h2 class="mb-4">Olá, <b>' . $nome . '</b>!</h2>
                <p class="lead">Você foi cadastrado como <b>' . $tipoRole . '</b> no <strong>Sistema Gerenciador de Bases</strong>.</p>
                <p class="mt-3">Para ativar sua conta, clique no botão abaixo:</p>
                <a href="link_para_ativacao" class="btn btn-primary btn-lg mt-3">Confirmar Conta</a>
            </div>
        </div>
    </div>
</body>
</html>';

echo $corpo;
?>
