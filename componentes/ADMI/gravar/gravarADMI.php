<?php
require('../../../include/conecta.php');
require('../../Email/EnviarGmail.php');

$retorno = '';

$institucao = getPost('institucao');
$municipio = getPost('municipio');
$nome = getPost('nome');
$email = getPost('email');
$cpf = getPost('cpf');
$cpf = preg_replace('/[^0-9]/', '', $cpf); 
$cod_role = 2; 

$bd = conecta();

$query = "INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
          VALUES ('$nome', '$cpf', '$municipio', 'n')";

if ($bd->SqlExecuteQuery($query)) {
    $cod_pessoa = $bd->getLastInsertId();

    $query = "INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES ($cod_pessoa, $cod_role)";

    if ($bd->SqlExecuteQuery($query)) {

        $query = "INSERT INTO administrador (cod_administrador,tipo_role) VALUES ($cod_pessoa, $cod_role)";

        if ($bd->SqlExecuteQuery($query)) {

            $query = "INSERT INTO administrador_instituicao (cod_administrador,cod_instituicao) VALUES ($cod_pessoa, $institucao)";
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
}

$bd->SqlDisconnect();
exit($retorno);
