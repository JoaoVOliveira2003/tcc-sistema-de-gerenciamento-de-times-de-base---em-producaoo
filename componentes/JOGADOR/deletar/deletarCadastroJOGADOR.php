<?php
require('../../../include/conecta.php');

$cod = getPost('cod');
$bd = conecta();
$retorno = 'ok';

$query = "delete from login_usuario where cod_usuario= " . $cod . "";
if (!$bd->SqlExecuteQuery($query)) {
    $retorno = 'nok';
    exit($retorno);
}

$query6 = "DELETE FROM turma_jogador WHERE cod_jogador = $cod";
if (!$bd->SqlExecuteQuery($query6)) {
    $retorno = 'nok';
}

$query4 = "SELECT local_midia FROM midia_jogador WHERE cod_jogador = $cod";
if ($bd->SqlExecuteQuery($query4)) {
    do {
        $local_midia = $bd->SqlQueryShow('local_midia');
        $arquivo = "../../../img/jogador/$local_midia";
    } while ($bd->SqlFetchNext());
} else {
    $retorno = 'nok';
}

$query5 = "DELETE FROM midia_jogador WHERE cod_jogador = $cod";
if (!$bd->SqlExecuteQuery($query5)) {
    $retorno = 'nok';
}

$idsDosResponsaveis = [];
$query7 = "SELECT cod_contatoResponsavel FROM jogador_contatoResponsavel WHERE cod_jogador = $cod";
if ($bd->SqlExecuteQuery($query7)) {
    do {
        $valor = $bd->SqlQueryShow('cod_contatoResponsavel');
        $idsDosResponsaveis[] = $valor;
    } while ($bd->SqlFetchNext());
} else {
    $retorno = 'nok';
}

$query9 = "DELETE FROM contato_responsavel WHERE cod_contatoResponsavel = $cod";
if (!$bd->SqlExecuteQuery($query9)) {
    $retorno = 'nok';
}

$query10 = "DELETE FROM jogador_contatoResponsavel WHERE cod_jogador = $cod";
if (!$bd->SqlExecuteQuery($query10)) {
    $retorno = 'nok';
}

$idsDasLesoes = [];
$query8 = "SELECT Cod_HistoricoLesoes FROM fichaMedica_historicoLesoes WHERE cod_jogador = $cod";
if ($bd->SqlExecuteQuery($query8)) {
    do {
        $valor = $bd->SqlQueryShow('Cod_HistoricoLesoes');
        $idsDasLesoes[] = $valor;

        $queryDel = "DELETE FROM historicoLesoes WHERE Cod_HistoricoLesoes = $valor";
        if (!$bd->SqlExecuteQuery($queryDel)) {
            $retorno = 'nok';
        }
    } while ($bd->SqlFetchNext());
} else {
    $retorno = 'nok';
}

$query11 = "DELETE FROM fichaMedica_historicoLesoes WHERE cod_jogador = $cod";
if (!$bd->SqlExecuteQuery($query11)) {
    $retorno = 'nok';
}

$query12 = "DELETE FROM fichaMedica WHERE cod_jogador = $cod";
if (!$bd->SqlExecuteQuery($query12)) {
    $retorno = 'nok';
}

$query3 = "DELETE FROM jogador WHERE cod_jogador = $cod";
if (!$bd->SqlExecuteQuery($query3)) {
    $retorno = 'nok';
}

$query1 = "DELETE FROM cadastro_identificacao WHERE cod_usuario = $cod";
if (!$bd->SqlExecuteQuery($query1)) {
    $retorno = 'nok';
}

$query2 = "DELETE FROM role_cadastro WHERE cod_usuario = $cod";
if (!$bd->SqlExecuteQuery($query2)) {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
