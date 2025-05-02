<?php
// Verifica se o parâmetro cod_pessoa existe na URL
$cod_pessoa = isset($_GET['cod_pessoa']) ? $_GET['cod_pessoa'] : '';

// Exibe o valor de cod_pessoa
echo $cod_pessoa;
?>
