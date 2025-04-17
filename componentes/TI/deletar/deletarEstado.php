<?php
require('../../../include/conecta.php');

$retorno = '';

$cod_estado= getPost('cod_estado');

$bd = conecta();

$query = "delete from estado where cod_estado= " . $cod_estado . "";
error_log($query);


if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}
else{
    $retorno='nok';
}

$bd->SqlDisconnect();
exit($retorno);