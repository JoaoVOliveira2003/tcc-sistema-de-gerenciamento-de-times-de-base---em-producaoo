<?php
require('../include/conecta.php');

$retorno = '';

$cod = getPost('cod');
$email = getPost('email');
$senha = getPost('senha');

$bd = conecta();

$query = "insert into login_usuario(cod_usuario,email_usuario,senha) values($cod,'$email','$senha')";

if ($bd->SqlExecuteQuery($query)) {

    $query = "UPDATE cadastro_identificacao SET ativo = 's' WHERE cod_usuario =" . $cod;
    if ($bd->SqlExecuteQuery($query)) {
        $retorno = 'ok';
    }
    else {
        $retorno = 'nok';
    }

} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);