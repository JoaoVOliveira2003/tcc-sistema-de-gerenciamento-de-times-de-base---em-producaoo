<?php
require('../../../include/conecta.php');

$retorno = '';

$cod    = getPost('cod');
$subIntituicao = getPost('subIntituicao');
$turma = getPost('turma');
$ativo = getPost('ativo');


$query = "UPDATE turma
          SET desc_turma = '$turma',
              ativo = '$ativo',
              cod_subInstituicao = '$subIntituicao'
          WHERE cod_turma = '$cod';";

$bd = conecta();

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
