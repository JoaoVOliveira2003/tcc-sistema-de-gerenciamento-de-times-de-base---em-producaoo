<?php
require('../include/conecta.php');
$bd = conecta();
$retorno = '';

$query = getPost('query');
$titulosTh = json_decode($_POST['titulosTh'], true);
$styleTh = json_decode($_POST['styleTh'], true);
$variavelTd = json_decode($_POST['variavelTd'], true);
$botoesTd = json_decode($_POST['botoesTd'], true);

if (empty($query)) {
    return false;
}

if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

$retorno .= '<table class="table table-hover table-bordered">
    <thead class="table-light">
    <tr>';

foreach ($titulosTh as $key => $titulo) {
    $style = isset($styleTh[$key]) ? $styleTh[$key] : '';
    $retorno .= '<th scope="col" style="' . htmlspecialchars($style) . '">' . htmlspecialchars($titulo) . '</th>';
}

$retorno .= '</tr>
    </thead>
    <tbody>
';


do {
    $retorno .= '<tr>';

    foreach ($variavelTd as $key => $campo) {
        $partes = explode(' ', $campo);
        $valor = '';

        foreach ($partes as $parte) {
            $valor .= htmlspecialchars($bd->SqlQueryShow($parte)) . ' ';
        }

        $retorno .= '<td>' . trim($valor) . '</td>';
    }

    $acoes = '';
    foreach ($botoesTd as $botao) {
        $botaoReal = $botao;

        preg_match_all('/\$(\w+)/', $botao, $variaveis);
        foreach ($variaveis[1] as $var) {
            $valorVar = $bd->SqlQueryShow($var);
            $botaoReal = str_replace('$' . $var, htmlspecialchars($valorVar ?? ''), $botaoReal);
        }

        $acoes .= $botaoReal . ' ';
    }

    $retorno .= '<td>' . $acoes . '</td>';

    $retorno .= '</tr>';
} while ($bd->SqlFetchNext());

$retorno .= '</tbody></table>';

echo $retorno;
?>