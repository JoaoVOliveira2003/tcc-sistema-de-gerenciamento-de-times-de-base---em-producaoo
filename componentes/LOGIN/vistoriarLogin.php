<?php
require('../../include/conecta.php');

$retorno = '';
$senhaBanco = '';
$email = getPost('email');
$senha = getPost('senha');

$bd = conecta();

$query = "
    SELECT ci.ativo, lu.senha
    FROM login_usuario lu
    JOIN cadastro_identificacao ci ON ci.cod_usuario = lu.cod_usuario
    WHERE lu.email_usuario = '$email'
";

if ($bd->SqlExecuteQuery($query)) {
    $ativo = $bd->SqlQueryShow("ativo");
    $senhaBanco = $bd->SqlQueryShow("senha");

    if ($ativo == 'n') {
        $retorno = 'nok3';
    } elseif ($senhaBanco == $senha) {
        $retorno = 'ok'; 
    } else {
        $retorno = 'nok2'; 
    }
} else {
    $retorno = 'nok1';
}

$bd->SqlDisconnect();
echo $retorno;
exit;
