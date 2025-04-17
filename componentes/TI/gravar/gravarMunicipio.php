<?php
require('../../../include/conecta.php');

$retorno = '';

$estado        = getPost('estado');
$desc_municipio   = getPost('desc_municipio');
$sigla_municipio = getPost('sigla_municipio');

$bd = conecta();

$query = "INSERT INTO municipio (cod_estado,desc_municipio, sigla_municipio) VALUES (" . $estado . ", '" . $desc_municipio . "', '" . $sigla_municipio . "')";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}

$bd->SqlDisconnect();
exit($retorno);