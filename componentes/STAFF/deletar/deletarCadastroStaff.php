<?php
require('../../../include/conecta.php');

$retorno = '';
$cod = getPost('cod');
$bd = conecta();

$query = "delete from login_usuario where cod_usuario= " . $cod . "";
if (!$bd->SqlExecuteQuery($query)) {
    $retorno = 'nok';
    exit($retorno);
}

// Primeiro apaga da tabela mais dependente
$query = "DELETE FROM subInstituticao_staff WHERE cod_staff = $cod";

if ($bd->SqlExecuteQuery($query)) {
    $query = "DELETE FROM staff WHERE cod_staff = $cod";

    if ($bd->SqlExecuteQuery($query)) {
        $query = "DELETE FROM role_cadastro WHERE cod_usuario = $cod";

        if ($bd->SqlExecuteQuery($query)) {
            $query = "DELETE FROM cadastro_identificacao WHERE cod_usuario = $cod";

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
