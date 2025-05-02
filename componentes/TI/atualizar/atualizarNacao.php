<?php
require('../../../include/conecta.php');

$retorno = '';

$cod_nacao    = getPost('cod_nacao');
$nacao        = getPost('nacao');
$desc_nacao   = getPost('desc_nacao');
$sigla_nacao  = getPost('sigla_nacao');

$bd = conecta();

$query = "UPDATE nacao 
          SET desc_nacao = '$desc_nacao', 
              sigla_nacao = '$sigla_nacao' 
          WHERE cod_nacao = '$cod_nacao';"; 

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
