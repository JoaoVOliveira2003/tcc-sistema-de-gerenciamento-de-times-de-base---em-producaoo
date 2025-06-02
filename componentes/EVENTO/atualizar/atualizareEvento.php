<?php
require('../../../include/conecta.php');

$retorno = '';

$cod    = getPost('cod');

$bd = conecta();

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
