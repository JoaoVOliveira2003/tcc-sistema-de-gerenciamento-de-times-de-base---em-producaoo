<?php
session_start();

function verificarLogin() {
    if (!isset($_SESSION['email_usuario']) || !isset($_SESSION['cod_usuario'])) {
        header("Location: http://localhost/tcc/telas/login/index.php");
        exit;
    }
    return [
        'nome' => $_SESSION['nome'],
        'email' => $_SESSION['email_usuario'],
        'cod_usuario' => $_SESSION['cod_usuario'],
        'cod_tipoRole' => $_SESSION['cod_tipoRole']
    ];
}
?>
