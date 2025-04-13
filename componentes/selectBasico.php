<?php
require('../include/conecta.php');
$bd = conecta();
$retorno = '';

$select          = getPost('select');
$query           = getPost('query');
$codSelect       = getPost('codSelect');
$descSelect      = getPost('descSelect');
$onclick         = getPost('onclick');
$onchange        = getPost('onchange');
$label           = getPost('label');
$classLabel      = getPost('classLabel');
$forLabel        = getPost('forLabel');
$classSelect     = getPost('classSelect');
$idSelect        = getPost('idSelect');
$name            = getPost('name');
$primeiroOption  = getPost('primeiroOption');

if (empty($query)) {
    return false;
}

if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

$retorno .= '<label class="' . $classLabel . '" for="' . $forLabel . '">' . $label . '</label>';
$retorno .= '<select class="' . $classSelect . '" id="' . $idSelect . '" name="' . $name . '" ' . $onclick . ' ' . $onchange . '>';
$retorno .= '<option value="">' . $primeiroOption . '</option>';

do {
    $valor  = $bd->SqlQueryShow($descSelect);
    $codigo = $bd->SqlQueryShow($codSelect);

    // Aqui comparamos o valor selecionado
    $selected = ($select !== '' && $select == $codigo) ? ' selected' : '';

    $retorno .= '<option value="' . $codigo . '"' . $selected . '>' . $valor . '</option>';
} while ($bd->SqlFetchNext());

$retorno .= '</select>';

$bd->SqlDisconnect();
echo $retorno;
?>
