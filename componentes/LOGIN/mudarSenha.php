<?php
require('../../include/conecta.php');
require('../Email/EnviarGmail.php');

$retorno = '';
$email = getPost('email');

$bd = conecta();

$query = " ";
if ($bd->SqlExecuteQuery($query)) {

} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();
echo $retorno;
exit;
