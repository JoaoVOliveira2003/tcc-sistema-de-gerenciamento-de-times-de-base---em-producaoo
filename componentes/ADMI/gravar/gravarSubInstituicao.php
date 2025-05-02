<?php
require('../../../include/conecta.php');

$retorno = '';

$institucao        = getPost('institucao');
$desc_subInstituicao   = getPost('desc_subInstituicao');
$municipio = getPost('municipio');

$bd = conecta();

$query = "INSERT INTO subInstituicao(Cod_Instituicao, ativo, desc_subInstituicao, Cod_Municipio) VALUES (" . $institucao . ",'s','" . $desc_subInstituicao . "', '" . $municipio . "')";



if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}

$bd->SqlDisconnect();
exit($retorno);