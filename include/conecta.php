<?php
require('Database.php');
require('funcoes.php');

function conecta() {
    $host = 'localhost';
    $usuario = 'root';
    $banco = 'tcc';
    $pass = '';

    return new Database($host, $banco, $usuario, $pass);
}

