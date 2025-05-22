<?php
require('../../../include/conecta.php');

$retorno = '';
$email = getPost('email');
$senha = getPost('senha');
$bd = conecta();

$query = "SELECT senha from login_usuario where email_usuario = $email";

if ($bd->SqlExecuteQuery($query)) {
    $senhaBanco  = $bd->SqlQueryShow("senha");

    if($senhaBanco == $senha) {
        $retorno = 'ok';
    }
    else {
        $retorno = 'nok2';
    }
} else {
    $retorno = 'nok1';
}

$bd->SqlDisconnect();
exit($retorno);
