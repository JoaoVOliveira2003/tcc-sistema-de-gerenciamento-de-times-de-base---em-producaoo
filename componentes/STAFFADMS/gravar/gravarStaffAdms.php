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

$emailBase = 'ojoao953@gmail.com';
$query = "SELECT COUNT(*) FROM login_usuario WHERE email_usuario = '$email'";
if ($bd->SqlExecuteQuery($query)) {
    $count = $bd->SqlQueryShow("COUNT(*)");
    if ($count > 0 && $email != $emailBase) {
        $retorno = 'emailJaCadastrado';
        $bd->SqlDisconnect();
        exit($retorno);
    }
}


$query = "INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
          VALUES ('$nome', '$cpf', '$municipio', 'n')";


if ($bd->SqlExecuteQuery($query)) {
    $cod_pessoa = $bd->getLastInsertId();

    $query = "INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES ($cod_pessoa, $cod_role)";
    
    if ($bd->SqlExecuteQuery($query)) {

        $query = "INSERT INTO staff (cod_staff) VALUES ($cod_pessoa)";
        
        if ($bd->SqlExecuteQuery($query)) {

            $query = "INSERT INTO subInstituticao_staff (cod_staff, cod_SubInstituicao) VALUES ($cod_pessoa, $subinstitucao)";
            
            if ($bd->SqlExecuteQuery($query)) {

                $query = "INSERT INTO administrador (cod_administrador, tipo_role) VALUES ($cod_pessoa, $cod_role)";
                
                if ($bd->SqlExecuteQuery($query)) {

                    $query = "INSERT INTO administrador_subInstituicao (cod_administrador, cod_subInstituicao) VALUES ($cod_pessoa, $subinstitucao)";
                    
                    if ($bd->SqlExecuteQuery($query)) {

                $query = "INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('$email', $cod_pessoa)";
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

} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
