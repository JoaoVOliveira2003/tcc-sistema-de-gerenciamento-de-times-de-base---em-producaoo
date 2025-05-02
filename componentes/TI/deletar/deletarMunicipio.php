<?php
require('../../../include/conecta.php');

$retorno = '';

$cod= getPost('cod');

$bd = conecta();

$query = "delete from municipio where  cod_municipio= " . $cod . "";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}
else{
    $retorno='nok';
}

$bd->SqlDisconnect();
exit($retorno);