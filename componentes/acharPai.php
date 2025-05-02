<?php
//OLÁ
require('../include/conecta.php');
$bd = conecta();
$retorno = '';

$query = getPost('query');
$valorProcurado = getPost('valorProcurado');


if (empty($query)) {
    return false;
}

if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

$valorProcurado = $bd->SqlQueryShow($valorProcurado);


echo $valorProcurado;
?>
