<?php
require('../../include/conecta.php');
require('../../Email/EnviarGmail.php');

$retorno = '';
$email = getPost('email');

$bd = conecta();

$query = "select cod_usuario,COUNT(*) FROM login_usuario WHERE email_usuario = '$email'";

if ($bd->SqlExecuteQuery($query)) {
    $existe = $bd->SqlQueryShow("count(*)");
    if ($existe > 0) {

        $cod_usuario = $bd->SqlQueryShow("cod_usuario");
        
        if (enviarGmailEsqueciSenha($email, $cod_usuario)) {
            $retorno = 'ok';
        } else {
            $retorno = 'nok2';
        }
    } else {
        $retorno = 'nok3';
    }
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
echo $retorno;
exit;
