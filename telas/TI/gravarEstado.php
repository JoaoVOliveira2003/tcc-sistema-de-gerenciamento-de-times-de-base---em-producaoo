<?php
require('../../include/conecta.php');

$retorno = '';

$nacao        = getPost('nacao');
$desc_nacao   = getPost('desc_nacao');
$sigla_estado = getPost('sigla_estado');

$bd = conecta();

$query = "INSERT INTO estado (cod_nacao, sigla_estado, desc_estado) VALUES (" . $nacao . ", '" . $desc_nacao . "', '" . $sigla_estado . "')";
error_log($query); // log para debug

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}

$bd->SqlDisconnect();
exit($retorno);