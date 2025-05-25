<?php
require('../../include/conecta.php');

$retorno = '';
$senha = getPost('senha');
$codPessoa = getPost('codPessoa');

$bd = conecta();

$query = "UPDATE login_usuario SET senha = '$senha'  WHERE cod_usuario=$codPessoa ";
if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
echo $retorno;
exit;
