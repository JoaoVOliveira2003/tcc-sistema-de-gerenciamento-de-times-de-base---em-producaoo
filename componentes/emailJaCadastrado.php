<?php
require('../include/conecta.php');

$retorno = '';
$bd = conecta();
$email = getPost('email');

$query = "SELECT COUNT(*) FROM login_usuario WHERE email_usuario = 'ojoao953@gmail.com'";

if ($bd->SqlExecuteQuery($query)) {
    $retorno  = $bd->SqlQueryShow("COUNT(*)");
}
else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
exit($retorno);
