<?php
require('../../include/conecta.php');

$retorno = '';

$cod = getPost('cod');

$responsavel_nome = getPost('responsavel_nome');
$responsavel_filiacao = getPost('responsavel_filiacao');
$responsavel_email = getPost('responsavel_email');
$responsavel_telefone = getPost('responsavel_telefone');
$responsavel_telefone = preg_replace('/\D/', '', $responsavel_telefone);

$bd = conecta();

$query = "insert into contato_responsavel(nomeResponsavel,tipoFiliacao,emailResponsavel,telefoneResponsavel)
values  ('$responsavel_nome', '$responsavel_filiacao', '$responsavel_email', $responsavel_telefone)";

if ($bd->SqlExecuteQuery($query)) {
    $codContato = $bd->getLastInsertId();

    // Vincula a lesão ao jogador
    $query = "insert into jogador_contatoResponsavel(cod_contatoResponsavel,cod_jogador)
                          VALUES ($codContato,$cod)";
    
    $bd->SqlExecuteQuery($query);
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}
$bd->SqlDisconnect();
exit($retorno);
