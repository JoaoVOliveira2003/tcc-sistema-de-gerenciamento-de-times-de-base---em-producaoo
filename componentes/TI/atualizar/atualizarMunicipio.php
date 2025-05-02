<?php
require('../../../include/conecta.php');

$retorno = '';

$cod    = getPost('cod');
$cod_estado    = getPost('cod_estado');
$desc_municipio   = getPost('desc_municipio');
$sigla_municipio  = getPost('sigla_municipio');

$bd = conecta();

$query = "UPDATE municipio 
          SET cod_estado = '$cod_estado', 
              desc_municipio  = '$desc_municipio', 
              sigla_municipio = '$sigla_municipio' 
          WHERE cod_municipio = '$cod';"; 

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
