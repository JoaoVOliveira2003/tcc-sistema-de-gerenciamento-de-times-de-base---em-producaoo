<?php
require('../../../include/conecta.php');

$retorno = '';
$cod = getPost('cod');
$bd = conecta();


$query = "DELETE FROM cadastro_identificacao WHERE cod_usuario = $cod";

if ($bd->SqlExecuteQuery($query)) {
    $query = "DELETE FROM role_cadastro WHERE cod_usuario = $cod";

    if ($bd->SqlExecuteQuery($query)) {
        $query = "DELETE FROM administrador WHERE cod_administrador = $cod";

        if ($bd->SqlExecuteQuery($query)) {
            $query = "DELETE FROM administrador_subInstituicao WHERE cod_administrador = $cod";

            if ($bd->SqlExecuteQuery($query)) {
                $retorno = 'ok';
            } else {
                $retorno = 'nok';
            }
        } else {
            $retorno = 'nok';
        }
    } else {
        $retorno = 'nok';
    }
} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
