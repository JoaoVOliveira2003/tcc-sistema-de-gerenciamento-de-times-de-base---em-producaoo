<?php
require('../../../include/conecta.php');

$retorno = '';

$cod_nacao= getPost('cod');

$bd = conecta();

$query = "delete from nacao where cod_nacao= " . $cod_nacao . "";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}
else{
    $retorno='nok';
}

$bd->SqlDisconnect();
exit($retorno);