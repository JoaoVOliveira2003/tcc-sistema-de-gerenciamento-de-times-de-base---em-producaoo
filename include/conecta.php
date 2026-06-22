<?php

require('Database.php');
require('funcoes.php');

function conecta() {
    $host = getenv('DB_HOST') ?: 'localhost';
    $usuario = getenv('DB_USER') ?: 'root';
    $banco = getenv('DB_NAME') ?: 'tcc';
    $pass = getenv('DB_PASS') ?: '';

    return new Database($host, $banco, $usuario, $pass);
}