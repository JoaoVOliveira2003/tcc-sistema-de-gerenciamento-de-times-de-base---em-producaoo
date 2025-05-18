<?php
require('../../../include/conecta.php');

$retorno = '';
$cod = getPost('cod');
$bd = conecta();


error_log(">>> INÍCIO DO TESTE DE QUERIES <<<");
error_log("COD recebido: $cod");

// Query 6 - turma_jogador
$query6 = "DELETE FROM turma_jogador WHERE cod_jogador = $cod";
error_log("Query 6: $query6");
$bd->SqlExecuteQuery($query6);

// Query 5 - midia_jogador
// Antes, buscar local_midia
$query4 = "SELECT local_midia FROM midia_jogador WHERE cod_jogador = $cod";
error_log("Query 4 (select local_midia): $query4");

if ($bd->SqlExecuteQuery($query4)) {
    do {
        $local_midia = $bd->SqlQueryShow('local_midia');
        $arquivo = "../../../img/jogador/$local_midia";
        error_log("Arquivo que seria apagado: $arquivo");
        // Aqui você pode usar unlink($arquivo) se quiser excluir o arquivo
    } while ($bd->SqlFetchNext());
} else {
    error_log("Nenhuma mídia encontrada.");
}

$query5 = "DELETE FROM midia_jogador WHERE cod_jogador = $cod";
error_log("Query 5: $query5");
$bd->SqlExecuteQuery($query5);

// Buscar os IDs dos contatos responsáveis
$idsDosResponsaveis = [];
$query7 = "SELECT cod_contatoResponsavel FROM jogador_contatoResponsavel WHERE cod_jogador = $cod";
error_log("Query 7 (buscar responsáveis): $query7");

if ($bd->SqlExecuteQuery($query7)) {
    do {
        $valor = $bd->SqlQueryShow('cod_contatoResponsavel');
        $idsDosResponsaveis[] = $valor;
    } while ($bd->SqlFetchNext());
}

// Query 9 - contato_responsavel
$query9 = "DELETE FROM contato_responsavel WHERE cod_contatoResponsavel = $cod";
error_log("Query 9: $query9");
$bd->SqlExecuteQuery($query9);

// Query 10 - jogador_contatoResponsavel
$query10 = "DELETE FROM jogador_contatoResponsavel WHERE cod_jogador = $cod";
error_log("Query 10: $query10");
$bd->SqlExecuteQuery($query10);

// Buscar os IDs dos históricos de lesões
$idsDasLesoes = [];
$query8 = "SELECT Cod_HistoricoLesoes FROM fichaMedica_historicoLesoes WHERE cod_jogador = $cod";
error_log("Query 8 (buscar lesões): $query8");

if ($bd->SqlExecuteQuery($query8)) {
    do {
        $valor = $bd->SqlQueryShow('Cod_HistoricoLesoes');

        $queryDel = "DELETE FROM historicoLesoes WHERE Cod_HistoricoLesoes = $valor";
        error_log("Query 8.1: $queryDel");
        $bd->SqlExecuteQuery($queryDel);
    } while ($bd->SqlFetchNext());
}

// Query 11 - fichaMedica_historicoLesoes
$query11 = "DELETE FROM fichaMedica_historicoLesoes WHERE cod_jogador = $cod";
error_log("Query 11: $query11");
$bd->SqlExecuteQuery($query11);

// Query 12 - fichaMedica
$query12 = "DELETE FROM fichaMedica WHERE cod_jogador = $cod";
error_log("Query 12: $query12");
$bd->SqlExecuteQuery($query12);

// Query 3 - jogador
$query3 = "DELETE FROM jogador WHERE cod_jogador = $cod";
error_log("Query 3: $query3");
$bd->SqlExecuteQuery($query3);

// Query 1 - cadastro_identificacao
$query1 = "DELETE FROM cadastro_identificacao WHERE cod_usuario = $cod";
error_log("Query 1: $query1");
$bd->SqlExecuteQuery($query1);

// Query 2 - role_cadastro
$query2 = "DELETE FROM role_cadastro WHERE cod_usuario = $cod";
error_log("Query 2: $query2");
$bd->SqlExecuteQuery($query2);

$bd->SqlDisconnect();
error_log(">>> FIM DO TESTE DE QUERIES <<<");

exit("ok");
