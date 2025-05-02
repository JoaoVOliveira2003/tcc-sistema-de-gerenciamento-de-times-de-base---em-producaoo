<?php
require('../../../include/conecta.php');

$retorno = '';

$turma = getPost('turma');
$sub_instituto   = getPost('sub_instituto');


$bd = conecta();

$query = "INSERT INTO turma (ativo,desc_turma,cod_subInstituicao) VALUES('s', '$turma',$sub_instituto);";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}

$bd->SqlDisconnect();
exit($retorno);