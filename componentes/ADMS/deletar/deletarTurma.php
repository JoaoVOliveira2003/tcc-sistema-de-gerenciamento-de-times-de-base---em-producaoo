<?php
require('../../../include/conecta.php');

$retorno = '';

$cod= getPost('cod');

$bd = conecta();

$query = "delete from turma where Cod_turma = " . $cod . "";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}
else{
    $retorno='nok';
}

$bd->SqlDisconnect();
exit($retorno);