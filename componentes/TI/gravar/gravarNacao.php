<?php
require('../../../include/conecta.php');

$retorno = '';

$desc_nacao   = getPost('desc_nacao');
$sigla_nacao = getPost('sigla_nacao');

$bd = conecta();

$query = "INSERT INTO nacao (sigla_nacao, desc_nacao) VALUES ('" . $sigla_nacao . "', '" . $desc_nacao . "')";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}

$bd->SqlDisconnect();
exit($retorno);