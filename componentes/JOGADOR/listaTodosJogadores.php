<?php
require('../../include/conecta.php');
$bd = conecta();
$retorno = '';

// $cod_role = getPost('cod_role');
// $cod_usuario = getPost('cod_usuario');
$cod_role = 1;
$cod_usuario = 4;

if ($cod_role == 1) {
    $query = "
SELECT 
    inst.cod_instituicao, inst.desc_instituicao, 
    si.cod_subInstituicao, si.desc_subInstituicao, 
    t.cod_turma, t.desc_turma, 
    ci.cod_usuario, ci.nome, ci.cpf
FROM cadastro_identificacao ci 
INNER JOIN role_cadastro rc ON rc.cod_usuario = ci.cod_usuario 
INNER JOIN jogador j ON j.cod_jogador = rc.cod_usuario 
LEFT JOIN turma_jogador tj ON tj.cod_jogador = j.cod_jogador 
LEFT JOIN turma t ON t.cod_turma = tj.cod_turma 
LEFT JOIN subInstituicao si ON si.Cod_SubInstituicao = t.cod_subInstituicao 
LEFT JOIN instituicao inst ON si.cod_instituicao = inst.cod_instituicao 
LEFT JOIN nota_jogador nota ON j.cod_jogador = nota.cod_jogador 
WHERE nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL 
ORDER BY inst.cod_instituicao, si.cod_subInstituicao, t.cod_turma, ci.nome
";
}

/*
SELECT inst.cod_instituicao, inst.desc_instituicao, si.cod_subInstituicao, si.desc_subInstituicao, t.cod_turma, t.desc_turma, ci.cod_usuario, ci.nome, ci.cpf, ci.ativo, mun.desc_municipio, est.desc_estado, nac.desc_nacao, j.data_nascimento, pos.desc_posicao, esp.desc_esporte, fm.altura, fm.peso, fm.tipoSanguineo, fm.restricoes_medicas, fm.alergias, mj.local_midia, hl.desc_lesao, hl.data_lesao, hl.tempoFora_lesao, nota.ativo, nota.data_atualizacao, nota.nota_jogador FROM cadastro_identificacao ci INNER JOIN role_cadastro rc ON rc.cod_usuario = ci.cod_usuario INNER JOIN jogador j ON j.cod_jogador = rc.cod_usuario LEFT JOIN posicao pos ON pos.cod_posicao = j.posicao LEFT JOIN esporte esp ON esp.cod_esporte = j.esporte LEFT JOIN fichaMedica fm ON fm.cod_jogador = j.cod_jogador LEFT JOIN midia_jogador mj ON mj.cod_jogador = j.cod_jogador LEFT JOIN turma_jogador tj ON tj.cod_jogador = j.cod_jogador LEFT JOIN turma t ON t.cod_turma = tj.cod_turma LEFT JOIN subInstituicao si ON si.Cod_SubInstituicao = t.cod_subInstituicao LEFT JOIN instituicao inst ON si.cod_instituicao = inst.cod_instituicao LEFT JOIN fichaMedica_historicoLesoes fmhl ON fmhl.cod_jogador = j.cod_jogador LEFT JOIN historicoLesoes hl ON hl.cod_historicoLesoes = fmhl.cod_historicoLesoes INNER JOIN municipio mun ON mun.cod_municipio = ci.cod_municipio INNER JOIN estado est ON mun.cod_estado = est.cod_estado INNER JOIN nacao nac ON nac.cod_nacao = est.cod_nacao LEFT JOIN nota_jogador nota ON j.cod_jogador = nota.cod_jogador WHERE nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL ORDER BY inst.cod_instituicao, si.cod_subInstituicao, t.cod_turma, ci.nome
*/

$retorno = "";

if ($bd->SqlExecuteQuery($query)) {

    $current_instituicao = null;
    $current_subinstituicao = null;
    $current_turma = null;

    while ($bd->SqlFetchNext()) {
        $instituicao = $bd->SqlQueryShow('desc_instituicao');
        $subinstituicao = $bd->SqlQueryShow('desc_subInstituicao');
        $turma = $bd->SqlQueryShow('desc_turma');
        $nome = $bd->SqlQueryShow('nome');
        $cpf = $bd->SqlQueryShow('cpf');
        $cod_usuario = $bd->SqlQueryShow('cod_usuario');

        if ($instituicao !== $current_instituicao) {
            if ($current_turma !== null) {
                $retorno .= "</tbody></table>";
                $current_turma = null;
            }
            if ($current_subinstituicao !== null) {
                $retorno .= "<hr>";
                $current_subinstituicao = null;
            }
            if ($current_instituicao !== null) {
                $retorno .= "<hr>";
            }
            $retorno .= "<h3>$instituicao</h3>";
            $current_instituicao = $instituicao;
        }

        if ($subinstituicao !== $current_subinstituicao) {
            if ($current_turma !== null) {
                $retorno .= "</tbody></table>";
                $current_turma = null;
            }
            $retorno .= "<h5>$subinstituicao</h5>";
            $current_subinstituicao = $subinstituicao;
        }

        if ($turma !== $current_turma) {
            if ($current_turma !== null) {
                $retorno .= "</tbody></table>";
            }
            $retorno .= "<h6>$turma</h6>";
            $retorno .= "<table class='table table-hover table-bordered'>";
            $retorno .= "<thead class='table-light'>
                            <tr>
                                <th>Nome</th>
                                <th>CPF</th>
                                <th>Ações</th>
                            </tr>
                        </thead><tbody>";
            $current_turma = $turma;
        }

        $retorno .= "<tr>";
        $retorno .= "<td>$nome</td>";
        $retorno .= "<td>$cpf</td>";
        $retorno .= "<td><button type='button' class='btn btn-secondary btn-sm' onclick='vizualizarDadosJogador($cod_usuario)'>Dados completo.</button></td>";
        $retorno .= "</tr>";
    }

    if ($current_turma !== null) {
        $retorno .= "</tbody></table>";
    }

} else {
    $retorno .= "<p>Nenhum registro encontrado.</p>";
}

echo $retorno;
?>
