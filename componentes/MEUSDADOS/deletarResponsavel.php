<?php
require('../../include/conecta.php');

$retorno = '';

$cod = getPost('cod'); 

$bd = conecta();

$query = "SELECT cod_jogador FROM jogador_contatoResponsavel WHERE cod_contatoResponsavel = $cod";

if ($bd->SqlExecuteQuery($query)) {
    $cod_jogador = $bd->SqlQueryShow('cod_jogador');
}

$query = "SELECT COUNT(*) as total FROM jogador_contatoResponsavel WHERE cod_jogador = $cod_jogador";

if ($bd->SqlExecuteQuery($query)) {
    $count = $bd->SqlQueryShow('total');

    if ($count == 0 || $count == 1) {
        exit('nok1'); 
    }

    $delete1 = "DELETE FROM jogador_contatoResponsavel WHERE cod_contatoResponsavel = $cod";
    $delete2 = "DELETE FROM contato_responsavel WHERE cod_contatoResponsavel = $cod";

    if ($bd->SqlExecuteQuery($delete2)) {
        if ($bd->SqlExecuteQuery($delete1)) {
            $retorno = 'ok';
        } else {
            $retorno = 'erro-ao-deletar1';
        }
    } else {
        $retorno = 'erro-ao-deletar2';
    }

} else {
    $retorno = 'erro-na-contagem';
}

// Finaliza a conexão com o banco e retorna resultado
$bd->SqlDisconnect();
exit($retorno);
