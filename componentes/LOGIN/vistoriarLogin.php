<?php
require('../../include/conecta.php');

session_start();

$retorno = '';
$senhaBanco = '';
$email = getPost('email');
$senha = getPost('senha');

$bd = conecta();

$query = "
    SELECT ci.ativo, lu.senha , lu.cod_usuario, ci.nome , rol.cod_tipoRole
    FROM login_usuario lu
    JOIN cadastro_identificacao ci ON ci.cod_usuario = lu.cod_usuario
    left join role_cadastro rol on ci.cod_usuario = rol.cod_usuario
    WHERE lu.email_usuario = '$email'
";


if ($bd->SqlExecuteQuery($query)) {
    $cod_tipoRole = $bd->SqlQueryShow("cod_tipoRole");
    $nome = $bd->SqlQueryShow("nome");
    $ativo = $bd->SqlQueryShow("ativo");
    $senhaBanco = $bd->SqlQueryShow("senha");
    $cod_usuario = $bd->SqlQueryShow("cod_usuario");

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

$_SESSION['nome'] = $nome;
$_SESSION['email_usuario'] = $email;
$_SESSION['cod_usuario'] = $cod_usuario;


$bd->SqlDisconnect();
echo $retorno;
exit;
