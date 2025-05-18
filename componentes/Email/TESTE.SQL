SELECT 
    ci.cod_usuario,
    ci.nome,
    ci.cpf,
    ci.ativo,
                    mun.desc_municipio,
                    est.desc_estado,
                    nac.desc_nacao,

    j.data_nascimento,
    pos.desc_posicao,
    esp.desc_esporte,

    fm.altura,
    fm.peso,
    fm.tipoSanguineo,
    fm.restricoes_medicas,
    fm.alergias,

    mj.local_midia,

    t.cod_turma,
    t.desc_turma,

    si.desc_subInstituicao,

    cr.nomeResponsavel,
    cr.tipoFiliacao,
    cr.emailResponsavel,
    cr.telefoneResponsavel,

    hl.desc_lesao,
    hl.data_lesao,
    hl.tempoFora_lesao

FROM cadastro_identificacao ci

-- Papel e jogador
INNER JOIN role_cadastro rc ON rc.cod_usuario = ci.cod_usuario
INNER JOIN jogador j ON j.cod_jogador = rc.cod_usuario

-- Posição e esporte
LEFT JOIN posicao pos ON pos.cod_posicao = j.posicao
LEFT JOIN esporte esp ON esp.cod_esporte = j.esporte

-- Ficha médica e mídia
LEFT JOIN fichaMedica fm ON fm.cod_jogador = j.cod_jogador
LEFT JOIN midia_jogador mj ON mj.cod_jogador = j.cod_jogador

-- Turma e subinstituição
LEFT JOIN turma_jogador tj ON tj.cod_jogador = j.cod_jogador
LEFT JOIN turma t ON t.cod_turma = tj.cod_turma
LEFT JOIN subInstituicao si ON si.Cod_SubInstituicao = t.cod_subInstituicao

-- Contato responsável
LEFT JOIN jogador_contatoResponsavel jcr ON jcr.cod_jogador = j.cod_jogador
LEFT JOIN contato_responsavel cr ON cr.cod_contatoResponsavel = jcr.cod_contatoResponsavel

-- Histórico de lesões
LEFT JOIN fichaMedica_historicoLesoes fmhl ON fmhl.cod_jogador = j.cod_jogador
LEFT JOIN historicoLesoes hl ON hl.cod_historicoLesoes = fmhl.cod_historicoLesoes

                INNER JOIN municipio mun ON mun.cod_municipio = ci.cod_municipio
                INNER JOIN estado est ON mun.cod_estado = est.cod_estado
                INNER JOIN nacao nac ON nac.cod_nacao = est.cod_nacao


WHERE ci.cod_usuario = 13;
