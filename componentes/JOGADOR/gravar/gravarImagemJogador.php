<?php
require('../../../include/conecta.php');

$pasta = '../../../img/jogador/';
$cod = 2;

$bd = conecta();

$retorno = '';


$tmp = $_FILES['imagemJogador']['tmp_name'];

$nomeOriginal = pathinfo($_FILES['imagemJogador']['name'], PATHINFO_FILENAME);
$extensao = pathinfo($_FILES['imagemJogador']['name'], PATHINFO_EXTENSION);
$nome = uniqid() . '_' . $nomeOriginal . '.' . $extensao;

$destino = $pasta . $nome;

if (!is_dir($pasta)) {
    mkdir($pasta, 0777, true);
}

if (move_uploaded_file($tmp, $destino)) {
    $query = "SELECT count(*) FROM midia_jogador WHERE cod_jogador = $cod";
    if ($bd->SqlExecuteQuery($query)) {
        $valorProcurado = $bd->SqlQueryShow('count(*)');

        if ($valorProcurado > 0) {
            $query = "UPDATE midia_jogador SET local_midia = '$nome' WHERE cod_jogador = $cod";
            if ($bd->SqlExecuteQuery($query)) {
                $retorno = 'ok';
            } else {
                $retorno = 'nok';
            }
        } else {
            $query = "INSERT INTO midia_jogador(cod_jogador, local_midia) VALUES ($cod, '$nome')";
            if ($bd->SqlExecuteQuery($query)) {
                $retorno = 'ok';
            } else {
                $retorno = 'nok';
            }
        }
    }
} else {
    $retorno = 'nok';
}

echo $retorno;
