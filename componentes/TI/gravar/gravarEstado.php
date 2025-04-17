<?php
require('../../../include/conecta.php');

$retorno = '';

$nacao        = getPost('nacao');
$desc_estado   = getPost('desc_estado');
$sigla_estado = getPost('sigla_estado');

$bd = conecta();

$query = "INSERT INTO estado (cod_nacao,desc_estado, sigla_estado) VALUES (" . $nacao . ", '" . $desc_estado . "', '" . $sigla_estado . "')";


if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}

$bd->SqlDisconnect();
exit($retorno);