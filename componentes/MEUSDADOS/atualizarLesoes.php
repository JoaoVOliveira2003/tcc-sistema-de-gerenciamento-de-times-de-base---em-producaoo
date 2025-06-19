<?php
require('../../include/conecta.php');

$retorno = '';

$cod_usuario = getPost('cod_usuario');

$altura = getPost('altura');
$alergias = getPost('alergias');
$peso = getPost('peso');
$restricoesMedicas = getPost('restricoesMedicas');


$query = "UPDATE fichaMedica
SET altura = '$altura',peso='$peso',alergias='$alergias',restricoes_medicas='$restricoesMedicas'
WHERE cod_jogador =  $cod_usuario;
";

$bd = conecta();

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
