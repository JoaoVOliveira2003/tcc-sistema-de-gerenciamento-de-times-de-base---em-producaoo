<?php
require('../../include/conecta.php');

$retorno = '';

$senha       = getPost('senha');
$cod_usuario = getPost('cod_usuario');


$query = "UPDATE login_usuario
          SET senha = '$senha'
          WHERE cod_usuario = $cod_usuario";

$bd = conecta();

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
