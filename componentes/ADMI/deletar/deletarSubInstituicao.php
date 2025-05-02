<?php
require('../../../include/conecta.php');

$retorno = '';

$cod= getPost('cod');

$bd = conecta();

$query = "delete from subinstituicao where Cod_SubInstituicao= " . $cod . "";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}
else{
    $retorno='nok';
}

$bd->SqlDisconnect();
exit($retorno);