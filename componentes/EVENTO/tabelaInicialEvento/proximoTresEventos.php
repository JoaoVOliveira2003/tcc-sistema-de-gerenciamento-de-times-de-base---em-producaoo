<?php
require('../../../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod_role = getPost('cod_role');
$cod_usuario = getPost('cod_usuario');

// $cod_role = 6; 
// $cod_usuario= 3;

$query = "";

if ($cod_role == 1) {
    // TI: eventos futuros
    $query = "
        SELECT 
          e.data, e.horario, e.local, e.titulo_evento, tur.desc_turma 
        FROM evento e
        INNER JOIN turma_evento turev ON turev.cod_evento = e.cod_evento 
        INNER JOIN turma tur ON tur.cod_turma = turev.cod_turma 
        INNER JOIN subinstituicao sub ON sub.cod_SubInstituicao = tur.cod_SubInstituicao
        WHERE e.ativo = 'S'
        ORDER BY e.data ASC, e.horario
        LIMIT 3;
    ";
} else if ($cod_role == 2) {
    // admi - cod 4
    $query = "SELECT GROUP_CONCAT(tur.cod_turma ORDER BY tur.cod_turma SEPARATOR ',') AS turmas FROM instituicao inst INNER JOIN administrador_instituicao admins ON admins.cod_instituicao = inst.cod_instituicao INNER JOIN subinstituicao sub ON inst.cod_instituicao = sub.cod_instituicao INNER JOIN turma tur ON tur.Cod_SubInstituicao = sub.Cod_SubInstituicao WHERE admins.cod_administrador = $cod_usuario ";

    if ($bd->SqlExecuteQuery($query)) {
        $cod_instituicao = $bd->SqlQueryShow('cod_instituicao');
    }

    $query = "
        SELECT 
          e.data, e.horario, e.local, e.titulo_evento, tur.desc_turma 
        FROM evento e
        INNER JOIN turma_evento turev ON turev.cod_evento = e.cod_evento 
        INNER JOIN turma tur ON tur.cod_turma = turev.cod_turma 
        INNER JOIN subinstituicao sub ON sub.cod_SubInstituicao = tur.cod_SubInstituicao
        WHERE turev.cod_turma IN ($turmas) AND e.ativo = 'S'
        ORDER BY e.data ASC, e.horario
        LIMIT 3;
    ";
} else if ($cod_role == 3 || $cod_role == 4) {
    // ADMS / STAFF|ADMS
    $query = "SELECT GROUP_CONCAT(tur.cod_turma ORDER BY tur.cod_turma SEPARATOR ',') AS turmas FROM administrador_subinstituicao admsub INNER JOIN subinstituicao sub ON admsub.cod_SubInstituicao = sub.cod_SubInstituicao INNER JOIN turma tur ON tur.cod_SubInstituicao = sub.cod_SubInstituicao WHERE admsub.cod_administrador = $cod_usuario;";

    if ($bd->SqlExecuteQuery($query)) {
        $turmas = $bd->SqlQueryShow('turmas');
    }

    $query = "
        SELECT 
          e.data, e.horario, e.local, e.titulo_evento, tur.desc_turma 
        FROM evento e
        INNER JOIN turma_evento turev ON turev.cod_evento = e.cod_evento 
        INNER JOIN turma tur ON tur.cod_turma = turev.cod_turma 
        INNER JOIN subinstituicao sub ON sub.cod_SubInstituicao = tur.cod_SubInstituicao
        WHERE turev.cod_turma IN ($turmas) AND e.ativo = 'S'
        ORDER BY e.data ASC, e.horario
        LIMIT 3;
    ";
} else if ($cod_role == 5) {
    // 5 Treinadores STAFF s
    $query = "SELECT GROUP_CONCAT(tur.cod_turma ORDER BY tur.cod_turma SEPARATOR ', ') AS turmas FROM staff staf INNER JOIN cadastro_identificacao cad ON staf.cod_staff = cad.cod_usuario LEFT JOIN staff_turma staftu ON staf.cod_staff = staftu.cod_staff LEFT JOIN turma tur ON staftu.cod_turma = tur.cod_turma WHERE cad.ativo = 's' AND cod_usuario = $cod_usuario GROUP BY cad.cod_usuario, cad.nome;";

    if ($bd->SqlExecuteQuery($query)) {
        $turmas = $bd->SqlQueryShow('turmas');
    }

    $query = "
        SELECT 
            e.data, 
            e.ativo, 
            e.local, 
            e.titulo_evento, 
            tur.desc_turma, 
            turev.cod_turma
        FROM evento e 
        LEFT JOIN turma_evento turev ON turev.cod_evento = e.cod_evento
        LEFT JOIN turma tur ON tur.cod_turma = turev.cod_turma 
        LEFT JOIN turma_jogador jogatur ON tur.cod_turma = jogatur.cod_turma 
        LEFT JOIN jogador joga ON jogatur.cod_jogador = joga.cod_jogador
        WHERE turev.cod_turma IN ($turmas) AND e.ativo = 'S'
        ORDER BY e.data, e.horario ASC
        LIMIT 3;
    ";
} else if ($cod_role == 6) {
    $query = "SELECT cod_turma FROM turma_jogador WHERE cod_jogador = $cod_usuario;";

    if ($bd->SqlExecuteQuery($query)) {
        $cod_turma = $bd->SqlQueryShow('cod_turma');
    }

    $query = "
        SELECT 
            e.data, 
            e.ativo, 
            e.local, 
            e.titulo_evento, 
            tur.desc_turma, 
            turev.cod_turma
        FROM evento e 
        LEFT JOIN turma_evento turev ON turev.cod_evento = e.cod_evento
        LEFT JOIN turma tur ON tur.cod_turma = turev.cod_turma 
        LEFT JOIN turma_jogador jogatur ON tur.cod_turma = jogatur.cod_turma 
        LEFT JOIN jogador joga ON jogatur.cod_jogador = joga.cod_jogador
        WHERE turev.cod_turma = $cod_turma AND e.ativo = 'S'
        ORDER BY e.data, e.horario ASC
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
    $retorno = "";
}

echo $retorno;
?>
