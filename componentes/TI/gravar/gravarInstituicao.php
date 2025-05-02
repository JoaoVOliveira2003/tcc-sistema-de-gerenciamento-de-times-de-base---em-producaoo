<?php
require('../../../include/conecta.php');

$retorno = '';


$desc_instituicao   = getPost('desc_instituicao');
$cod_tipo_instituicao = getPost('tipoInstituicao');

$bd = conecta();

$query = "INSERT INTO instituicao(desc_instituicao, cod_tipo_instituicao,ativo) VALUES ('" . $desc_instituicao . "', '" . $cod_tipo_instituicao . "','s')";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}

$bd->SqlDisconnect();
exit($retorno);

