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

if (!$bd->SqlExecuteQuery($query)) {
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

if ($bd->SqlNumRows() > 0) {
    do {
        $retorno .= '<tr>';

        foreach ($variavelTd as $key => $campo) {
            $partes = explode(' ', $campo);
            $valor = '';

            foreach ($partes as $parte) {
                $val = $bd->SqlQueryShow($parte);

                // Converte 's' para 'Sim' e 'n' para 'Não'
                if ($val === 's') {
                    $val = 'Sim';
                } elseif ($val === 'n') {
                    $val = 'Não';
                }

                $valor .= htmlspecialchars($val) . ' ';
            }

            $retorno .= '<td>' . trim($valor) . '</td>';
        }

        $acoes = '';
        foreach ($botoesTd as $botao) {
            $botaoReal = $botao;

            preg_match_all('/\$(\w+)/', $botao, $variaveis);
            foreach ($variaveis[1] as $var) {
                $valorVar = $bd->SqlQueryShow($var);

                // Aplica a mesma conversão aqui, caso os botões usem esse valor
                if ($valorVar === 's' || $valorVar === 'S') {
                    $valorVar = 'Sim';
                } elseif ($valorVar === 'n' || $valorVar === 'N') {
                    $valorVar = 'Não';
                }

                $botaoReal = str_replace('$' . $var, htmlspecialchars($valorVar ?? ''), $botaoReal);
            }

            $acoes .= $botaoReal . ' ';
        }

        $retorno .= '<td>' . $acoes . '</td>';

        $retorno .= '</tr>';
    } while ($bd->SqlFetchNext());
}


else {
    // Linha informando que não há dados
    $colspan = count($titulosTh) + 1; // +1 para a coluna de ações
    $retorno .= '<tr><td colspan="' . $colspan . '" class="text-center">Nenhum registro encontrado.</td></tr>';
}

$retorno .= '</tbody></table>';

echo $retorno;
?>
