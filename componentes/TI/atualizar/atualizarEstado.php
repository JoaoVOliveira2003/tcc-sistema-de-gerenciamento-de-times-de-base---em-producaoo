<?php
require('../../../include/conecta.php');

$retorno = '';

$cod_estado    = getPost('cod_estado');
$nacao         = getPost('nacao');
$desc_estado   = getPost('desc_estado');
$sigla_estado  = getPost('sigla_estado');

$bd = conecta();

$query = "UPDATE estado 
          SET cod_nacao = '$nacao', 
              desc_estado = '$desc_estado', 
              sigla_estado = '$sigla_estado' 
          WHERE cod_estado = '$cod_estado';"; 

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
