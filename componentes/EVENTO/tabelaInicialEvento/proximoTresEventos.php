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
   //admi   
    $query = "
    SELECT e.data, e.local, e.titulo_evento,tur.desc_turma
    FROM evento e
    left JOIN turma_evento turev ON turev.cod_evento = e.cod_evento
    left JOIN turma tur ON tur.cod_turma = turev.cod_turma
    left JOIN subinstituicao sub ON sub.cod_SubInstituicao = tur.cod_SubInstituicao
    left JOIN instituicao inst ON inst.cod_Instituicao = sub.cod_Instituicao
    where inst.cod_instituicao = 3
    AND CONCAT(e.data, ' ', e.horario) >= NOW()
    ORDER BY e.data ASC, e.horario ASC
    LIMIT 3;
    ";
} else if ($cod_role == 3 || $cod_role == 4) {
    // ADMS / STAFF|ADMS
    $query = "
    SELECT e.data, e.local, e.titulo_evento,tur.desc_turma
    FROM evento e
    left JOIN turma_evento turev ON turev.cod_evento = e.cod_evento
    left JOIN turma tur ON tur.cod_turma = turev.cod_turma
    left JOIN subinstituicao sub ON sub.cod_SubInstituicao = tur.cod_SubInstituicao
    where sub.cod_subinstituicao = 3
    AND CONCAT(e.data, ' ', e.horario) >= NOW()
    ORDER BY e.data ASC, e.horario ASC
    LIMIT 3";
} else if ($cod_role == 5) {
    //staff 
    $query = "
    SELECT e.data, e.local, e.titulo_evento,tur.desc_turma
    FROM evento e
    left JOIN turma_evento turev ON turev.cod_evento = e.cod_evento
    left JOIN turma tur ON tur.cod_turma = turev.cod_turma
    left JOIN staff_turma sttaftur ON tur.cod_turma = sttaftur.cod_turma
    where sttaftur.cod_staff=9
    AND CONCAT(e.data, ' ', e.horario) >= NOW()
    ORDER BY e.data ASC, e.horario ASC
    LIMIT 3;
    ";

} else if ($cod_role == 6) {
    // JOGADOR
    $query = "
    SELECT e.data, e.local, e.titulo_evento,tur.desc_turma
    FROM evento e
    left JOIN turma_evento turev ON turev.cod_evento = e.cod_evento
    left JOIN turma tur ON tur.cod_turma = turev.cod_turma
    left JOIN turma_jogador jogatur ON tur.cod_turma = jogatur.cod_turma
    left JOIN jogador joga ON jogatur.cod_jogador = joga.cod_jogador
    where joga.cod_jogador=2
    AND CONCAT(e.data, ' ', e.horario) >= NOW()
    ORDER BY e.data ASC, e.horario ASC
    LIMIT 3;
    ";
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
