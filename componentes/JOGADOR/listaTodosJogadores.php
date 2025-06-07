<?php
require('../../include/conecta.php');
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
    inst.cod_instituicao,inst.desc_instituicao,
    si.cod_subInstituicao,si.desc_subInstituicao,
    t.cod_turma,t.desc_turma,
    ci.cod_usuario, ci.nome, ci.cpf, ci.ativo,
    mun.desc_municipio, est.desc_estado, nac.desc_nacao,
    j.data_nascimento,
    pos.desc_posicao, esp.desc_esporte,
    fm.altura, fm.peso, fm.tipoSanguineo, fm.restricoes_medicas, fm.alergias,
    mj.local_midia,
    hl.desc_lesao, hl.data_lesao, hl.tempoFora_lesao,
	nota.ativo, nota.data_atualizacao,nota.nota_jogador
FROM cadastro_identificacao ci
    INNER JOIN role_cadastro rc ON rc.cod_usuario = ci.cod_usuario
    INNER JOIN jogador j ON j.cod_jogador = rc.cod_usuario
    LEFT JOIN posicao pos ON pos.cod_posicao = j.posicao
    LEFT JOIN esporte esp ON esp.cod_esporte = j.esporte
    LEFT JOIN fichaMedica fm ON fm.cod_jogador = j.cod_jogador
    LEFT JOIN midia_jogador mj ON mj.cod_jogador = j.cod_jogador
    LEFT JOIN turma_jogador tj ON tj.cod_jogador = j.cod_jogador
    LEFT JOIN turma t ON t.cod_turma = tj.cod_turma
    LEFT JOIN subInstituicao si ON si.Cod_SubInstituicao = t.cod_subInstituicao
	left join instituicao inst ON si.cod_instituicao = inst.cod_instituicao 
	LEFT JOIN fichaMedica_historicoLesoes fmhl ON fmhl.cod_jogador = j.cod_jogador
    LEFT JOIN historicoLesoes hl ON hl.cod_historicoLesoes = fmhl.cod_historicoLesoes
    INNER JOIN municipio mun ON mun.cod_municipio = ci.cod_municipio
    INNER JOIN estado est ON mun.cod_estado = est.cod_estado
    INNER JOIN nacao nac ON nac.cod_nacao = est.cod_nacao
	left join nota_jogador nota on j.cod_jogador = nota.cod_jogador
	WHERE nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL
    order by inst.cod_instituicao, si.cod_subInstituicao,t.cod_turma,ci.nome
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

if (trim($query) !== '' && $bd->SqlExecuteQuery($query)) {

    
    $retorno .= $query;
    // $contador = 0;
    // do {
       
        
    // } while ($bd->SqlFetchNext());

    //$retorno .= "</div>";
} else {
    $retorno = "<p class='text-muted'>Nenhum evento encontrado.</p>";
}

echo $retorno;
?>
