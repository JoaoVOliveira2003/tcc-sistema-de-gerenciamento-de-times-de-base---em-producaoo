<?php
require('../../include/conecta.php');

$retorno = '';

$cod = getPost('cod'); // cod_pessoa (jogador)

$cod_tipoLesao = getPost('cod_tipoLesao');
$tempo_fora = getPost('tempo_fora');
$data_lesao = getPost('data_lesao');
$desc_lesao = getPost('desc_lesao');

$bd = conecta(); 

$queryLesao = "INSERT INTO historicoLesoes (cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
               VALUES ($cod_tipoLesao, '$desc_lesao', '$data_lesao', '$tempo_fora')";

if ($bd->SqlExecuteQuery($queryLesao)) {
    $cod_lesao = $bd->getLastInsertId();

    // Vincula a lesão ao jogador
    $queryVinculoLesao = "INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) 
                          VALUES ($cod, $cod_lesao)";
    
    $bd->SqlExecuteQuery($queryVinculoLesao);
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
