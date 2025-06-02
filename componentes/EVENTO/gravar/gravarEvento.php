<?php
require('../../../include/conecta.php');

$retorno = '';

$turma = getPost('turma');
$sub_instituto   = getPost('sub_instituto');


$bd = conecta();

$query = "
INSERT INTO evento (cod_staff, titulo_evento, data, horario, local, desc_evento, ativo)
VALUES
(6, 'Aula de Balé', '2025-06-10', '15:30:00', 'Sala 1', 'Aula para iniciantes de balé', 'S')

";

if ($bd->SqlExecuteQuery($query)) {
    $retorno = 'ok';
}

$bd->SqlDisconnect();
exit($retorno);