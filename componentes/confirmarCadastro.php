<?php
require('../include/conecta.php');

$retorno = '';

$cod = getPost('cod');
$email = getPost('email');
$senha = getPost('senha');
$tipo_role = getPost('tipo_role');

$bd = conecta();

$query = "UPDATE login_usuario SET senha = '$senha' WHERE cod_usuario = $cod";

if ($bd->SqlExecuteQuery($query)) {

    $query = "UPDATE cadastro_identificacao SET ativo = 's' WHERE cod_usuario =" . $cod;
    if ($bd->SqlExecuteQuery($query)) {

        if ($tipo_role = 6) {
            $dataAtual = date('Y-m-d H:i:s');
            $query = "INSERT into nota_jogador(cod_jogador,cod_staff,nota_jogador,ativo, data_atualizacao) values ($cod,1,'6.0','s','$dataAtual')";

            if ($bd->SqlExecuteQuery($query)) {
                $retorno = 'ok';
            }
            else{
                $retorno = 'nok';
            }

        } else {
            $retorno = 'ok';
        }

    } else {
        $retorno = 'nok';
    }

} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);