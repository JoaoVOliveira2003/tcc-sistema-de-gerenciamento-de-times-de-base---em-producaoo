<?php
require('../../../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod_role = 1; // Substituir por getPost('cod_role') futuramente

$query = '';

if ($cod_role == 1) {
    // TI: eventos futuros
    $query = "
        SELECT data, local, titulo_evento
        FROM evento
        WHERE CONCAT(data, ' ', horario) >= NOW()
        ORDER BY data ASC, horario ASC
        LIMIT 3
    ";
} else if ($cod_role == 2) {
    // ADMI = eventos da instituição
    $query = "-- futura query";
} else if ($cod_role == 3 || $cod_role == 4) {
    // ADMS / STAFF|ADMS
    $query = "-- futura query";
} else if ($cod_role == 5) {
    // STAFF
    $query = "-- futura query";
} else if ($cod_role == 6) {
    // JOGADOR
    $query = "-- futura query";
}

// Executa a query se estiver válida
if (trim($query) !== '' && $bd->SqlExecuteQuery($query)) {
    $retorno .= "
    <table class='table table-bordered'>
        <caption style='caption-side: top; text-align: left; font-weight: bold; font-size: 1.2em;'>PRÓXIMOS TRÊS EVENTOS</caption>
        <thead class='thead-light'>
            <tr>
                <th>Data</th>
                <th>Local</th>
                <th>Título</th>
            </tr>
        </thead>
        <tbody>
    ";

    do {
        $data = $bd->SqlQueryShow('data'); 
        $data = date('d/m/Y', strtotime($data));
        $local = $bd->SqlQueryShow('local'); 
        $titulo = $bd->SqlQueryShow('titulo_evento');       

        $retorno .= "
            <tr>
                <td>$data</td>
                <td>$local</td>
                <td>$titulo</td>
            </tr>
        ";
        } while ($bd->SqlFetchNext());


    $retorno .= "
            <tr>
                <td colspan='3'>
                    <div style='margin-left: 64%;'>
                        <button class='btn btn-sm btn-secondary'>Ver eventos por completo</button>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
    ";
} else {
    $retorno = "<div class='alert alert-warning'>Nenhum evento encontrado.</div>";
}

echo $retorno;
?>
