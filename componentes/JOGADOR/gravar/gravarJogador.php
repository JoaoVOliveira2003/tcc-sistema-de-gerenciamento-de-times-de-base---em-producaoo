<?php
require('../../../include/conecta.php');
$retorno = '';

$municipio = getPost('municipio');
$nome = getPost('nome');
$email = getPost('email');
$cpf = getPost('cpf');
$posicao = getPost('posicao');
$data_nascimento = getPost('data_nascimento');
$imagemJogador = getPost('imagemJogador');
$selectEsporte = getPost('selectEsporte');
$selectPosicao = getPost('selectPosicao');
$altura = getPost('altura');
$peso = getPost('peso');
$tipo_sanguineo = getPost('tipo_sanguineo');
$restricoes_medicas = getPost('restricoes_medicas');
$alergias = getPost('alergias');

return $alergias;

?>