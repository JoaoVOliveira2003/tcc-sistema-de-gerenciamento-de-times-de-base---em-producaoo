<?php
require('../../../include/conecta.php');

$retorno = '';

$titulo_evento  = getPost('titulo_evento');

$cod_staff      = getPost('cod_staff');
// $cod_staff = 6;

$turma          = getPost('turma');
$local          = getPost('local');
$data_evento    = getPost('data_evento');     
$horario_evento = getPost('horario_evento'); 
$desc_evento    = getPost('desc_evento');

$data_evento_formatada    = DateTime::createFromFormat('d/m/Y', $data_evento)->format('Y-m-d');
$horario_evento_formatado = DateTime::createFromFormat('H:i', $horario_evento)->format('H:i:s');

$bd = conecta();

$query = "INSERT INTO evento (cod_staff, titulo_evento, data, horario, local, desc_evento, ativo) VALUES
         ($cod_staff, '$titulo_evento', '$data_evento_formatada', '$horario_evento_formatado', '$local', '$desc_evento', 'S')";

if ($bd->SqlExecuteQuery($query)) {
    $cod_evento = $bd->getLastInsertId();

    $query = "INSERT INTO turma_evento (cod_evento, cod_turma) VALUES ($cod_evento, $turma)";

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