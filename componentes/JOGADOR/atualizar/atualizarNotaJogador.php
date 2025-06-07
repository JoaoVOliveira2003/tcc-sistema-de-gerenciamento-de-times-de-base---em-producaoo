<?php
require('../../../include/conecta.php');
$retorno = '';
$dataAtual = date('Y-m-d H:i:s');

$cod_jogador = getPost('cod_jogador');
$cod_staff = getPost('cod_staff');
$novaNota = getPost('novaNota');

// $cod_jogador = 28;
// $cod_staff = 1;
// $novaNota = '7.2';

$bd = conecta();

$query = "UPDATE nota_jogador SET ativo = 'n' WHERE cod_jogador = $cod_jogador";

if ($bd->SqlExecuteQuery($query)) {
    $query = "INSERT into nota_jogador(cod_jogador,cod_staff,nota_jogador,ativo, data_atualizacao) values ($cod_jogador,$cod_staff,'$novaNota','s','$dataAtual')";
  
    if ($bd->SqlExecuteQuery($query)) {
        $retorno = 'ok';

    } else {
        $retorno = 'nok1';
    }

} else {
    $retorno = 'nok2';
}

$bd->SqlDisconnect();
exit($retorno);