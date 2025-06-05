<?php
require('../../../include/conecta.php');
require('../../Email/EnviarGmail.php');

$retorno = '';
$turmasSelecionadas = getPost('turmasSelecionadas');
$cod_usuario = getPost('cod_usuario');

$bd = conecta();

$query = 'DELETE FROM staff_turma WHERE cod_staff=' . $cod_usuario;

if ($bd->SqlExecuteQuery($query)) {
    if (is_array($turmasSelecionadas) && count($turmasSelecionadas) > 0) {
        foreach ($turmasSelecionadas as $turma) {
            $query = 'INSERT INTO staff_turma(cod_staff, cod_turma) VALUES (' . $cod_usuario . ', ' . $turma . ');';
            $bd->SqlExecuteQuery($query);
        }
        $retorno = 'ok';
    } else {
        $retorno = 'ok';
    }
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
