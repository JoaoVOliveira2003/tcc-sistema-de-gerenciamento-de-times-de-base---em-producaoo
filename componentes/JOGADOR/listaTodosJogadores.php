<?php
require('../../include/conecta.php');
$bd = conecta();

$cod_role = getPost('cod_role');
$cod_usuario = getPost('cod_usuario');

$cod_role = 1;
$cod_usuario = 4;
$retorno = "";

if ($cod_role == 1) {
    $query = "
        SELECT 
            inst.cod_instituicao, inst.desc_instituicao, 
            si.cod_subInstituicao, si.desc_subInstituicao, 
            t.cod_turma, t.desc_turma, 
            ci.cod_usuario, ci.nome, ci.cpf
        FROM turma t
        LEFT JOIN subInstituicao si ON si.cod_subInstituicao = t.cod_subInstituicao
        LEFT JOIN instituicao inst ON si.cod_instituicao = inst.cod_instituicao
        LEFT JOIN turma_jogador tj ON tj.cod_turma = t.cod_turma
        LEFT JOIN jogador j ON tj.cod_jogador = j.cod_jogador
        LEFT JOIN role_cadastro rc ON rc.cod_usuario = j.cod_jogador
        LEFT JOIN cadastro_identificacao ci ON ci.cod_usuario = rc.cod_usuario
        LEFT JOIN nota_jogador nota ON nota.cod_jogador = j.cod_jogador 
            AND (nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL)
        ORDER BY inst.cod_instituicao, si.cod_subInstituicao, t.cod_turma, ci.nome
    ";
} elseif ($cod_role == 2) {
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
            inst.cod_instituicao, inst.desc_instituicao, 
            si.cod_subInstituicao, si.desc_subInstituicao, 
            t.cod_turma, t.desc_turma, 
            ci.cod_usuario, ci.nome, ci.cpf
        FROM turma t
        LEFT JOIN subInstituicao si ON si.cod_subInstituicao = t.cod_subInstituicao
        LEFT JOIN instituicao inst ON si.cod_instituicao = inst.cod_instituicao
        LEFT JOIN turma_jogador tj ON tj.cod_turma = t.cod_turma
        LEFT JOIN jogador j ON tj.cod_jogador = j.cod_jogador
        LEFT JOIN role_cadastro rc ON rc.cod_usuario = j.cod_jogador
        LEFT JOIN cadastro_identificacao ci ON ci.cod_usuario = rc.cod_usuario
        LEFT JOIN nota_jogador nota ON nota.cod_jogador = j.cod_jogador 
            AND (nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL)
        WHERE t.cod_turma IN ($turmas)
        ORDER BY inst.cod_instituicao, si.cod_subInstituicao, t.cod_turma, ci.nome;
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
            inst.cod_instituicao, inst.desc_instituicao, 
            si.cod_subInstituicao, si.desc_subInstituicao, 
            t.cod_turma, t.desc_turma, 
            ci.cod_usuario, ci.nome, ci.cpf
        FROM turma t
        LEFT JOIN subInstituicao si ON si.cod_subInstituicao = t.cod_subInstituicao
        LEFT JOIN instituicao inst ON si.cod_instituicao = inst.cod_instituicao
        LEFT JOIN turma_jogador tj ON tj.cod_turma = t.cod_turma
        LEFT JOIN jogador j ON tj.cod_jogador = j.cod_jogador
        LEFT JOIN role_cadastro rc ON rc.cod_usuario = j.cod_jogador
        LEFT JOIN cadastro_identificacao ci ON ci.cod_usuario = rc.cod_usuario
        LEFT JOIN nota_jogador nota ON nota.cod_jogador = j.cod_jogador 
            AND (nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL)
        WHERE t.cod_turma IN ($turmas)
        ORDER BY inst.cod_instituicao, si.cod_subInstituicao, t.cod_turma, ci.nome;
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
            inst.cod_instituicao, inst.desc_instituicao, 
            si.cod_subInstituicao, si.desc_subInstituicao, 
            t.cod_turma, t.desc_turma, 
            ci.cod_usuario, ci.nome, ci.cpf
        FROM turma t
        LEFT JOIN subInstituicao si ON si.cod_subInstituicao = t.cod_subInstituicao
        LEFT JOIN instituicao inst ON si.cod_instituicao = inst.cod_instituicao
        LEFT JOIN turma_jogador tj ON tj.cod_turma = t.cod_turma
        LEFT JOIN jogador j ON tj.cod_jogador = j.cod_jogador
        LEFT JOIN role_cadastro rc ON rc.cod_usuario = j.cod_jogador
        LEFT JOIN cadastro_identificacao ci ON ci.cod_usuario = rc.cod_usuario
        LEFT JOIN nota_jogador nota ON nota.cod_jogador = j.cod_jogador 
            AND (nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL)
        WHERE t.cod_turma IN ($turmas)
        ORDER BY inst.cod_instituicao, si.cod_subInstituicao, t.cod_turma, ci.nome;
    ";
}

if ($bd->SqlExecuteQuery($query)) {
    $instituicaoAtual = null;
    $subinstituicaoAtual = null;
    $turmaAtual = null;
    $tem_jogador_na_turma = false;

    while ($bd->SqlFetchNext()) {
        $instituicao = $bd->SqlQueryShow('desc_instituicao') ?? 'Instituição não informada';
        $subinstituicao = $bd->SqlQueryShow('desc_subInstituicao') ?? 'Subinstituição não informada';
        $turma = $bd->SqlQueryShow('desc_turma') ?? 'Turma não informada';
        $nome = $bd->SqlQueryShow('nome') ?? 'Sem nome';
        $cpf = $bd->SqlQueryShow('cpf') ?? '';
        $cod_usuario = $bd->SqlQueryShow('cod_usuario');

        // Nova Instituição
        if ($instituicao !== $instituicaoAtual) {
            if ($turmaAtual !== null) {
                if (!$tem_jogador_na_turma) {
                    $retorno .= "<tr><td colspan='4' class='text-center'>Nenhum jogador cadastrado</td></tr>";
                }
                $retorno .= "</tbody></table>";
            }
            $retorno .= ($instituicaoAtual !== null ? "<hr>" : "");
            $retorno .= "<h3>$instituicao</h3>";
            $instituicaoAtual = $instituicao;
            $subinstituicaoAtual = null;
            $turmaAtual = null;
        }

        // Nova Subinstituição
        if ($subinstituicao !== $subinstituicaoAtual) {
            if ($turmaAtual !== null) {
                if (!$tem_jogador_na_turma) {
                    $retorno .= "<tr><td colspan='4' class='text-center'>Nenhum jogador cadastrado</td></tr>";
                }
                $retorno .= "</tbody></table>";
            }
            $retorno .= "<h5>$subinstituicao</h5>";
            $subinstituicaoAtual = $subinstituicao;
            $turmaAtual = null;
        }

        // Nova Turma
        if ($turma !== $turmaAtual) {
            if ($turmaAtual !== null && !$tem_jogador_na_turma) {
                $retorno .= "<tr><td colspan='4' class='text-center'>Nenhum jogador cadastrado</td></tr>";
                $retorno .= "</tbody></table>";
            }

            $retorno .= "<h6>$turma</h6>";
            $retorno .= "<table class='table table-hover table-bordered'>";
            $retorno .= "<thead class='table-light'>
                            <tr>
                                <th>Cod. Jogador</th>
                                <th>Nome</th>
                                <th>CPF</th>
                                <th>Ação</th>
                            </tr>
                        </thead><tbody>";

            $tem_jogador_na_turma = false;
            $turmaAtual = $turma;
        }

        // Se houver jogador, adiciona linha
        if (!empty($cod_usuario)) {
            $tem_jogador_na_turma = true;
            $cpf_formatado = preg_replace('/(\d{3})(\d{3})(\d{3})(\d{2})/', '$1.$2.$3-$4', $cpf);

            $retorno .= "<tr>";
            $retorno .= "<td>$cod_usuario</td>";
            $retorno .= "<td>$nome</td>";
            $retorno .= "<td>$cpf_formatado</td>";
            $retorno .= "<td><button type='button' class='btn btn-secondary btn-sm' onclick='vizualizarDadosJogador($cod_usuario)'>Dados completo.</button></td>";
            $retorno .= "</tr>";
        }
    }

    // Fecha a última tabela, se aberta
    if ($turmaAtual !== null) {
        if (!$tem_jogador_na_turma) {
            $retorno .= "<tr><td colspan='4' class='text-center'>Nenhum jogador na turma</td></tr>";
        }
        $retorno .= "</tbody></table>";
    }
} else {
    $retorno .= "<p>Erro ao executar a consulta.</p>";
}

echo $retorno;
?>
