<?php
require('../../include/conecta.php');

$retorno = '';

$cod_staff       = getPost('cod_staff');
$cod_treino      = getPost('cod_treino');
$relogio         = getPost('relogio');
$cod_jogador     = getPost('cod_jogador');
$grauPrivacidade = getPost('grauPrivacidade');
$descNotaTreino  = getPost('descNotaTreino');

$bd = conecta();


$query = "
INSERT INTO notatreino_jogador (
  cod_grau_privacidade,
  cod_treino,
  cod_jogador,
  minuto_nota,
  desc_notaTreino
)VALUES(
$grauPrivacidade,
$cod_treino,
$cod_jogador,
'$relogio',
'$descNotaTreino'
);
";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}
else {
    $retorno = 'nok1';
}

$bd->SqlDisconnect();
exit($retorno);