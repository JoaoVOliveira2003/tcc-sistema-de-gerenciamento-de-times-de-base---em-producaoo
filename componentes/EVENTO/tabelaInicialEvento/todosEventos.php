<?php
require('../../../include/conecta.php');
$bd = conecta();
$retorno = '';

// $cod_role = getPost('cod_role');
// $cod_usuario = getPost('cod_usuario');
$cod_role = 1;
$cod_usuario = 4;

$query = '';

if ($cod_role == 1) {
    $query = "
        SELECT 
            e.cod_evento,
            e.titulo_evento,
            e.data,
            e.horario,
            e.local,
            e.desc_evento,
            tur.desc_turma 
        FROM evento e
        INNER JOIN turma_evento turev ON turev.cod_evento = e.cod_evento 
        INNER JOIN turma tur ON tur.cod_turma = turev.cod_turma 
        INNER JOIN subinstituicao sub ON sub.cod_SubInstituicao = tur.cod_SubInstituicao
        WHERE e.ativo = 'S'
        ORDER BY e.data ASC, e.horario
    ";
} elseif ($cod_role == 2) {
    // Administrador Instituição
    $query = "
        SELECT GROUP_CONCAT(tur.cod_turma ORDER BY tur.cod_turma SEPARATOR ',') AS turmas 
        FROM instituicao inst
        INNER JOIN administrador_instituicao admins ON admins.cod_instituicao = inst.cod_instituicao 
        INNER JOIN subinstituicao sub ON inst.cod_instituicao = sub.cod_instituicao 
        INNER JOIN turma tur ON tur.Cod_SubInstituicao = sub.Cod_SubInstituicao 
        WHERE admins.cod_administrador = $cod_usuario
    ";

    if ($bd->SqlExecuteQuery($query)) {
        $turmas = $bd->SqlQueryShow('turmas');
    }

    $query = "
        SELECT 
            e.cod_evento,
            e.titulo_evento,
            e.data,
            e.horario,
            e.local,
            e.desc_evento,
            tur.desc_turma 
        FROM evento e
        INNER JOIN turma_evento turev ON turev.cod_evento = e.cod_evento 
        INNER JOIN turma tur ON tur.cod_turma = turev.cod_turma 
        INNER JOIN subinstituicao sub ON sub.cod_SubInstituicao = tur.cod_SubInstituicao
        WHERE turev.cod_turma IN ($turmas) AND e.ativo = 'S'
        ORDER BY e.data ASC, e.horario
    ";
} elseif ($cod_role == 3 || $cod_role == 4) {
    // Administradores Subinstituição ou Staff/ADM
    $query = "
        SELECT GROUP_CONCAT(tur.cod_turma ORDER BY tur.cod_turma SEPARATOR ',') AS turmas 
        FROM administrador_subinstituicao admsub
        INNER JOIN subinstituicao sub ON admsub.cod_SubInstituicao = sub.cod_SubInstituicao 
        INNER JOIN turma tur ON tur.cod_SubInstituicao = sub.cod_SubInstituicao 
        WHERE admsub.cod_administrador = $cod_usuario
    ";

    if ($bd->SqlExecuteQuery($query)) {
        $turmas = $bd->SqlQueryShow('turmas');
    }

    $query = "
        SELECT 
            e.cod_evento,
            e.titulo_evento,
            e.data,
            e.horario,
            e.local,
            e.desc_evento,
            tur.desc_turma 
        FROM evento e
        INNER JOIN turma_evento turev ON turev.cod_evento = e.cod_evento 
        INNER JOIN turma tur ON tur.cod_turma = turev.cod_turma 
        INNER JOIN subinstituicao sub ON sub.cod_SubInstituicao = tur.cod_SubInstituicao
        WHERE turev.cod_turma IN ($turmas) AND e.ativo = 'S'
        ORDER BY e.data ASC, e.horario
    ";
} elseif ($cod_role == 5) {
    // Treinadores Staff
    $query = "
        SELECT GROUP_CONCAT(tur.cod_turma ORDER BY tur.cod_turma SEPARATOR ', ') AS turmas 
        FROM staff staf
        INNER JOIN cadastro_identificacao cad ON staf.cod_staff = cad.cod_usuario 
        LEFT JOIN staff_turma staftu ON staf.cod_staff = staftu.cod_staff 
        LEFT JOIN turma tur ON staftu.cod_turma = tur.cod_turma 
        WHERE cad.ativo = 's' AND cod_usuario = $cod_usuario 
        GROUP BY cad.cod_usuario, cad.nome
    ";

    if ($bd->SqlExecuteQuery($query)) {
        $turmas = $bd->SqlQueryShow('turmas');
    }

    $query = "
        SELECT 
            e.cod_evento,
            e.titulo_evento,
            e.data,
            e.horario,
            e.local,
            e.desc_evento,
            tur.desc_turma 
        FROM evento e 
        LEFT JOIN turma_evento turev ON turev.cod_evento = e.cod_evento
        LEFT JOIN turma tur ON tur.cod_turma = turev.cod_turma 
        LEFT JOIN turma_jogador jogatur ON tur.cod_turma = jogatur.cod_turma 
        LEFT JOIN jogador joga ON jogatur.cod_jogador = joga.cod_jogador
        WHERE turev.cod_turma IN ($turmas) AND e.ativo = 'S'
        ORDER BY e.data ASC, e.horario
    ";
} elseif ($cod_role == 6) {
    // Jogador
    $query = "
        SELECT cod_turma 
        FROM turma_jogador 
        WHERE cod_jogador = $cod_usuario
    ";

    if ($bd->SqlExecuteQuery($query)) {
        $cod_turma = $bd->SqlQueryShow('cod_turma');
    }

    $query = "
        SELECT 
            e.cod_evento,
            e.titulo_evento,
            e.data,
            e.horario,
            e.local,
            e.desc_evento,
            tur.desc_turma 
        FROM evento e 
        LEFT JOIN turma_evento turev ON turev.cod_evento = e.cod_evento
        LEFT JOIN turma tur ON tur.cod_turma = turev.cod_turma 
        LEFT JOIN turma_jogador jogatur ON tur.cod_turma = jogatur.cod_turma 
        LEFT JOIN jogador joga ON jogatur.cod_jogador = joga.cod_jogador
        WHERE turev.cod_turma = $cod_turma AND e.ativo = 'S'
        ORDER BY e.data ASC, e.horario
    ";
}

// Geração do HTML
if (trim($query) !== '' && $bd->SqlExecuteQuery($query)) {
    $retorno .= "<div class='accordion' id='eventosAccordion'>";

    $contador = 0;
    do {
        $contador++;
        $data = $bd->SqlQueryShow('data');
        $cod_evento = $bd->SqlQueryShow('cod_evento');
        $horario = $bd->SqlQueryShow('horario');
        $dataFormatada = date('d/m/Y', strtotime($data));
        $horarioFormatado = date('H:i', strtotime($horario));
        $desc_turma = $bd->SqlQueryShow('desc_turma');
        $local = $bd->SqlQueryShow('local');
        $titulo = $bd->SqlQueryShow('titulo_evento');
        $desc_evento = $bd->SqlQueryShow('desc_evento');

        $botao = ($cod_role != 6) 
            ? "<button type='button' class='btn mt-2 btn-sm btn-primary' onclick ='cancelarEvento($cod_evento)'>Cancelar</button>" 
            : "";

        $retorno .= "
            <div class='accordion-item border shadow-sm mb-3 rounded'>
                <h2 class='accordion-header' id='heading$contador'>
                    <button class='accordion-button ".($contador == 1 ? "" : "collapsed")." fw-semibold text-primary' type='button' data-bs-toggle='collapse' data-bs-target='#collapse$contador' aria-expanded='".($contador == 1 ? "true" : "false")."' aria-controls='collapse$contador'>
                        <i class='bi bi-calendar-event me-2'></i> $desc_turma | $titulo
                    </button>
                </h2>
                
                <div id='collapse$contador' class='accordion-collapse collapse ".($contador == 1 ? "show" : "")."' aria-labelledby='heading$contador' data-bs-parent='#eventosAccordion'>
                    <div class='accordion-body bg-light rounded-bottom'>
                        <div class='row mb-2'>
                            <div class='col-md-6'>
                                <strong>Data:</strong> $dataFormatada | $horarioFormatado
                            </div>
                            <div class='col-md-6'>
                                <strong>Local:</strong> $local
                            </div>
                        </div>
                        <div class='row'>
                            <div class='col-md-12'>
                                <strong>Descrição:</strong><br>$desc_evento
                            </div>
                        </div>
                        $botao
                    </div>
                </div>
            </div>
        ";
    } while ($bd->SqlFetchNext());

    $retorno .= "</div>";
} else {
    $retorno = "<p class='text-muted'>Nenhum evento encontrado.</p>";
}

echo $retorno;
?>
