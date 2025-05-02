<?php
require('../../../include/conecta.php');
require('../../Email/EnviarGmail.php');


$retorno = '';

$municipio = getPost('municipio');
$nome   = getPost('nome');
$email = getPost('email');
$cpf = getPost('cpf');
$cpf = preg_replace('/[^0-9]/', '', $cpf); 
$cod_role=1;


$bd = conecta();

$query = "INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) 
          VALUES ('$nome', '$cpf', '$municipio', 'n')";


if ($bd->SqlExecuteQuery($query)) {
    $cod_pessoa = $bd->getLastInsertId();

    enviarGmail($email,$nome,1,$cod_pessoa);  
    $retorno = 'ok';
}


$bd->SqlDisconnect();
exit($retorno);