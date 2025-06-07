<?php
require('../../../include/conecta.php');

$retorno = '';

$cod_evento = getPost('cod_evento');

$query = "UPDATE evento SET ativo = 'n' WHERE cod_evento = $cod_evento";


$bd = conecta();

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
