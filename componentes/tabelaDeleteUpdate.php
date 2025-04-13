<?php
require('../include/conecta.php');
$bd = conecta();
$retorno = '';

$query = '
    SELECT 
        est.cod_estado,
        nac.desc_nacao,
        est.desc_estado,
        est.sigla_estado
    FROM estado est
    INNER JOIN nacao nac ON est.cod_nacao = nac.cod_nacao
    ORDER BY est.cod_nacao
';

if (empty($query)) {
    return false;
}

if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

$retorno .= '<table class="table table-hover table-bordered">
    <thead class="table-light">
<tr>
    <th scope="col" style="width: 10%;">Código Estado</th>
    <th scope="col" style="width: 30%;">Nação</th>
    <th scope="col" style="width: 30%;">Estado</th>
    <th scope="col" style="width: 10%;">Sigla</th>
    <th scope="col" style="width: 20%;">Ações</th>
</tr>

    </thead>
    <tbody>
';

do {
    $cod_estado = $bd->SqlQueryShow('cod_estado');
    $desc_nacao = $bd->SqlQueryShow('desc_nacao');
    $desc_estado = $bd->SqlQueryShow('desc_estado');
    $sigla_estado = $bd->SqlQueryShow('sigla_estado');

    $retorno .= '
        <tr>
            <td>' . htmlspecialchars($cod_estado) . '</td>
            <td>' . htmlspecialchars($desc_nacao) . '</td>
            <td>' . htmlspecialchars($desc_estado) . '</td>
            <td>' . htmlspecialchars($sigla_estado) . '</td>
            <td>
                <button type="button" class="btn btn-secondary btn-sm" onclick="teste()">Atualizar</button>
            </td>

                        
        </tr>
    ';
} while ($bd->SqlFetchNext());

// tem que fazer umas variaveis de quais botoes vão, só o atualizar ou atualizar ou deletar

$retorno .= '
    </tbody>
</table>';

echo $retorno;
?>