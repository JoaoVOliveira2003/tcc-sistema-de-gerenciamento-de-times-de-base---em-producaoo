<?php
require('../../../include/conecta.php');

$retorno = '';

$cod= getPost('cod');

$bd = conecta();

$queryCount = "SELECT COUNT(*) FROM turma_jogador WHERE Cod_turma = " . $cod;

if ($bd->SqlExecuteQuery($queryCount)) {

    $count = $bd->SqlQueryShow("COUNT(*)");

    if ($count > 0){
        $retorno = 'nok';
        $bd->SqlDisconnect();
        exit($retorno);
    }
}
else{
    $retorno='nok';
}

$query = "DELETE FROM turma WHERE Cod_turma = " . $cod;

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}
else{
    $retorno='nok';
}

$bd->SqlDisconnect();
exit($retorno);