<?php
require('../../../include/conecta.php');

$retorno = '';

$cod    = getPost('cod');
$instituicao         = getPost('instituicao');
$municipio   = getPost('municipio');
$ativo  = getPost('ativo');
$desc_subInstituicao = getPost('desc_subInstituicao');

$query = "UPDATE subinstituicao
          SET cod_instituicao = '$instituicao',
              cod_municipio = '$municipio',
              ativo = '$ativo',
              desc_subinstituicao = '$desc_subInstituicao'
          WHERE cod_subinstituicao = '$cod';";

$bd = conecta();

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
