<?php
session_start();

function verificarLogin() {
    if (!isset($_SESSION['email_usuario']) || !isset($_SESSION['cod_usuario'])) {
        header("Location: index.php");
        exit;
    }
    return [
        'nome' => $_SESSION['nome'],
        'email' => $_SESSION['email_usuario'],
        'cod' => $_SESSION['cod_usuario']
    ];
}
?>
