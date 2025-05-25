<?php
require('../../include/conecta.php');
require('../Email/EnviarGmail.php');

$retorno = '';
$email = getPost('email');

$bd = conecta();

$query = "select cod_usuario,COUNT(*) as existe FROM login_usuario WHERE email_usuario = '$email'";
if ($bd->SqlExecuteQuery($query)) {

    $existe = $bd->SqlQueryShow("existe");

    if ($existe > 0) {
        $cod_usuario = $bd->SqlQueryShow("cod_usuario"); 

    $funcionou = enviarGmailEsqueciSenha($email, $cod_usuario);

    if($funcionou) {
        $retorno = 'ok';
    } else {
        $retorno = 'nok2';
    }
    
    } elseif ($existe == 0) {
        $retorno = 'nok1';

    } else {
        $retorno = 'nok3';
    }
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
echo $retorno;
exit;
