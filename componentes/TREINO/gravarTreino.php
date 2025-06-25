<?php
require('../../include/conecta.php');

$retorno = '';

$cod_esporte    = getPost('cod_esporte');
$cod_staff      = getPost('cod_staff');
$tempo_treino   = getPost('tempo_treino');
$cod_jogadores  = getPost('cod_jogadores');

$bd = conecta();

if (!is_array($cod_jogadores)) {
    $cod_jogadores = explode(',', $cod_jogadores);
}

$query = "INSERT INTO treino (cod_esporte, cod_staff, tempo_treino) 
          VALUES ($cod_esporte, $cod_staff, '$tempo_treino')";

if ($bd->SqlExecuteQuery($query)) {
    $cod_treino = $bd->getLastInsertId();
    $todas_insercoes_ok = true;

    foreach ($cod_jogadores as $cod_jogador) {
        $query2 = "INSERT INTO treino_jogador (cod_jogador, cod_treino) 
                        VALUES ($cod_jogador, $cod_treino)";
        if (!$bd->SqlExecuteQuery($query2)) {
            $todas_insercoes_ok = false;
            break;
        }
    }

    $retorno = $todas_insercoes_ok ? $cod_treino : 'nok1';
} else {
    $retorno = 'nok2';
}

// Fecha conexão e retorna resultado
$bd->SqlDisconnect();
exit($retorno);