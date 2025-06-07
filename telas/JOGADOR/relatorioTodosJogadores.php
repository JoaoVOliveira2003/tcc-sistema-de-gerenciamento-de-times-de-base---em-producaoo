<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();
?>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <?php include('../../include/includeBase.php'); ?>
    <script src="../../js/funcoes.js"></script>
    <script src="../../js/jogador.js"></script>
    <script>
        $(document).ready(function () {
        const usuario = <?php echo json_encode(value: $usuario); ?>;
        listaTodosJogadores(usuario.cod_tipoRole,usuario.cod_usuario);
        });
    </script>
</head>
<?php include('../../componentes/header.php'); ?>

<body>
    <div class="container">

        <div class="mt-1">
            <h2 class="mb-3">Relatorios de jogador por Instituição</h2>
            <h5 class="mb-4">
                Colocar um texto bom aqui posterioremente </h5>
            <hr>

        SELECT 
    ci.cod_usuario, ci.nome, ci.cpf, ci.ativo,
    mun.desc_municipio, est.desc_estado, nac.desc_nacao,
    j.data_nascimento,
    pos.desc_posicao, esp.desc_esporte,
    fm.altura, fm.peso, fm.tipoSanguineo, fm.restricoes_medicas, fm.alergias,
    mj.local_midia,
    t.desc_turma,
    si.desc_subInstituicao,
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
    LEFT JOIN fichaMedica_historicoLesoes fmhl ON fmhl.cod_jogador = j.cod_jogador
    LEFT JOIN historicoLesoes hl ON hl.cod_historicoLesoes = fmhl.cod_historicoLesoes
    INNER JOIN municipio mun ON mun.cod_municipio = ci.cod_municipio
    INNER JOIN estado est ON mun.cod_estado = est.cod_estado
    INNER JOIN nacao nac ON nac.cod_nacao = est.cod_nacao
	left join nota_jogador nota on j.cod_jogador = nota.cod_jogador

	WHERE nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL
    
    ;



            <div id="todosJogadores"></div>


            <hr>
            <!-- Modal Carregando -->
            <div class="modal fade" id="modalCarregando" tabindex="-1" aria-labelledby="modalCarregandoLabel"
                aria-hidden="true">
                <div class="modal-dialog d-flex justify-content-center align-items-center">
                    <div class="modal-content">
                        <div class="modal-body text-center">
                            <h5>Carregando...</h5>
                            <div id="carregandoText">*..</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</body>

</html>