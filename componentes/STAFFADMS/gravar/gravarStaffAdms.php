<?php
require('../../../include/conecta.php');
require('../../Email/EnviarGmail.php');

$retorno = '';

$subinstitucao = getPost('subinstitucao');
$municipio = getPost('municipio');
$nome = getPost('nome');
$email = getPost('email');
$cpf = getPost('cpf');
$cpf = preg_replace('/[^0-9]/', '', $cpf);
$cod_role = 4;

$bd = conecta();

$query = "INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
          VALUES ('$nome', '$cpf', '$municipio', 'n')";
error_log($query);

if ($bd->SqlExecuteQuery($query)) {
    $cod_pessoa = $bd->getLastInsertId();

    $query = "INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES ($cod_pessoa, $cod_role)";
    error_log($query);
    if ($bd->SqlExecuteQuery($query)) {

        $query = "INSERT INTO staff (cod_staff) VALUES ($cod_pessoa)";
        error_log($query);
        if ($bd->SqlExecuteQuery($query)) {

            $query = "INSERT INTO subInstituticao_staff (cod_staff, cod_SubInstituicao) VALUES ($cod_pessoa, $subinstitucao)";
            error_log($query);
            if ($bd->SqlExecuteQuery($query)) {

                $query = "INSERT INTO administrador (cod_administrador, tipo_role) VALUES ($cod_pessoa, $cod_role)";
                error_log($query);
                if ($bd->SqlExecuteQuery($query)) {

                    $query = "INSERT INTO administrador_subInstituicao (cod_administrador, cod_subInstituicao) VALUES ($cod_pessoa, $subinstitucao)";
                    error_log($query);
                    if ($bd->SqlExecuteQuery($query)) {

                        enviarGmail($email, $nome, $cod_role, $cod_pessoa);
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

    } else {
        $retorno = 'nok';
    }

} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
