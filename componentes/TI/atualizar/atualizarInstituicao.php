<?php
require('../../../include/conecta.php');

$retorno = '';

$cod    = getPost('cod');
$desc_instituicao    = getPost('desc_instituicao');
$ativo = getPost('atualizacaoAtivo_instituicao');
$cod_tipo_instituicao = getPost('atualizacaoTipoInstituicao');


$bd = conecta();

$query = "UPDATE instituicao set
          desc_instituicao = '$desc_instituicao',
          ativo='$ativo',
          cod_tipo_instituicao=$cod_tipo_instituicao
          where cod_instituicao = $cod;
          ";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
