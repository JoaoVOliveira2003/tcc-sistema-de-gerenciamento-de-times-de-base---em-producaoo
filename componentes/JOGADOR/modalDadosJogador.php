<?php
require('../../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod_jogador = getPost('cod_jogador');
$idModal = getPost('idModal');

// Sua query
$query = "
SELECT 
    inst.cod_instituicao,
    inst.desc_instituicao,
    si.cod_subInstituicao,
    si.desc_subInstituicao,
    t.cod_turma,
    t.desc_turma,
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
    hl.desc_lesao,
    hl.data_lesao,
    hl.tempoFora_lesao,
    nota.ativo as nota_ativa,
    nota.data_atualizacao,
    nota.nota_jogador
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
LEFT JOIN instituicao inst ON si.cod_instituicao = inst.cod_instituicao
LEFT JOIN fichaMedica_historicoLesoes fmhl ON fmhl.cod_jogador = j.cod_jogador
LEFT JOIN historicoLesoes hl ON hl.cod_historicoLesoes = fmhl.cod_historicoLesoes
INNER JOIN municipio mun ON mun.cod_municipio = ci.cod_municipio
INNER JOIN estado est ON mun.cod_estado = est.cod_estado
INNER JOIN nacao nac ON nac.cod_nacao = est.cod_nacao
LEFT JOIN nota_jogador nota ON j.cod_jogador = nota.cod_jogador
WHERE 
    (nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL)
    AND ci.cod_usuario = $cod_jogador
ORDER BY 
    inst.cod_instituicao, 
    si.cod_subInstituicao, 
    t.cod_turma, 
    ci.nome;
";

if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

// Cada campo separado em variáveis individuais
$cod_instituicao = $bd->SqlQueryShow('cod_instituicao');
$desc_instituicao = $bd->SqlQueryShow('desc_instituicao');
$cod_subInstituicao = $bd->SqlQueryShow('cod_subInstituicao');
$desc_subInstituicao = $bd->SqlQueryShow('desc_subInstituicao');
$cod_turma = $bd->SqlQueryShow('cod_turma');
$desc_turma = $bd->SqlQueryShow('desc_turma');
$cod_usuario = $bd->SqlQueryShow('cod_usuario');
$nome = $bd->SqlQueryShow('nome');
$cpf = $bd->SqlQueryShow('cpf');
$ativo = $bd->SqlQueryShow('ativo');
$desc_municipio = $bd->SqlQueryShow('desc_municipio');
$desc_estado = $bd->SqlQueryShow('desc_estado');
$desc_nacao = $bd->SqlQueryShow('desc_nacao');
$data_nascimento = $bd->SqlQueryShow('data_nascimento');
$desc_posicao = $bd->SqlQueryShow('desc_posicao');
$desc_esporte = $bd->SqlQueryShow('desc_esporte');
$altura = $bd->SqlQueryShow('altura');
$peso = $bd->SqlQueryShow('peso');
$tipoSanguineo = $bd->SqlQueryShow('tipoSanguineo');
$restricoes_medicas = $bd->SqlQueryShow('restricoes_medicas');
$alergias = $bd->SqlQueryShow('alergias');
$local_midia = $bd->SqlQueryShow('local_midia');
$desc_lesao = $bd->SqlQueryShow('desc_lesao');
$data_lesao = $bd->SqlQueryShow('data_lesao');
$tempoFora_lesao = $bd->SqlQueryShow('tempoFora_lesao');
$nota_ativa = $bd->SqlQueryShow('nota_ativa');
$data_atualizacao = $bd->SqlQueryShow('data_atualizacao');
$nota_jogador = $bd->SqlQueryShow('nota_jogador');

// Exemplo de uso no modal:
$retorno = '
<div class="modal fade" id="'.$idModal.'" tabindex="-1" aria-labelledby="modalLabel-'.$idModal.'" aria-hidden="true">
  <div class="modal-dialog modal-xl">  <!-- modal-xl para largura extra -->
    <div class="modal-content shadow-sm border-0">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="modalLabel-'.$idModal.'">'.$nome.'</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
      </div>
      <div class="modal-body p-4">

        <style>
          /* Força barra de abas scroll horizontal se for muito larga */
            #myTab-<?php echo $idModal; ?> {
            overflow-x: auto;   /* scroll horizontal se necessário */
            overflow-y: hidden; /* sem scroll vertical */
            white-space: nowrap;
            }

          #myTab-'.$idModal.' .nav-item {
            display: inline-block;  /* mantém as abas numa linha */
          }
          /* Opcional: diminui um pouco o padding das abas para caber melhor */
          #myTab-'.$idModal.' .nav-link {
            padding: 0.5rem 1rem;
            white-space: nowrap;
          }
        </style>

        <ul class="nav nav-tabs" id="myTab-'.$idModal.'" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="dados-pessoais-tab-'.$idModal.'" data-bs-toggle="tab" data-bs-target="#dados-pessoais-'.$idModal.'" type="button" role="tab" aria-controls="dados-pessoais-'.$idModal.'" aria-selected="true">Dados pessoais</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="ficha-medica-tab-'.$idModal.'" data-bs-toggle="tab" data-bs-target="#ficha-medica-'.$idModal.'" type="button" role="tab" aria-controls="ficha-medica-'.$idModal.'" aria-selected="false">Ficha médica</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="dados-responsaveis-tab-'.$idModal.'" data-bs-toggle="tab" data-bs-target="#dados-responsaveis-'.$idModal.'" type="button" role="tab" aria-controls="dados-responsaveis-'.$idModal.'" aria-selected="false">Dados dos responsáveis</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="nota-jogador-tab-'.$idModal.'" data-bs-toggle="tab" data-bs-target="#nota-jogador-'.$idModal.'" type="button" role="tab" aria-controls="nota-jogador-'.$idModal.'" aria-selected="false">Nota do jogador</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="notas-treino-tab-'.$idModal.'" data-bs-toggle="tab" data-bs-target="#notas-treino-'.$idModal.'" type="button" role="tab" aria-controls="notas-treino-'.$idModal.'" aria-selected="false">Notas de treino</button>
          </li>
        </ul>

        <div class="tab-content mt-3" id="myTabContent-'.$idModal.'">
          <div class="tab-pane fade show active" id="dados-pessoais-'.$idModal.'" role="tabpanel" aria-labelledby="dados-pessoais-tab-'.$idModal.'">
            <!-- conteúdo dados pessoais -->
            <p><strong>CPF:</strong> '.$cpf.'</p>
            <p><strong>Instituição:</strong> '.$desc_instituicao.'</p>
            <!-- ... resto do conteúdo ... -->
          </div>

          <div class="tab-pane fade" id="ficha-medica-'.$idModal.'" role="tabpanel" aria-labelledby="ficha-medica-tab-'.$idModal.'">
            <!-- conteúdo ficha médica -->
          </div>

          <div class="tab-pane fade" id="dados-responsaveis-'.$idModal.'" role="tabpanel" aria-labelledby="dados-responsaveis-tab-'.$idModal.'">
            <!-- conteúdo dados responsáveis -->
          </div>

          <div class="tab-pane fade" id="nota-jogador-'.$idModal.'" role="tabpanel" aria-labelledby="nota-jogador-tab-'.$idModal.'">
            <!-- conteúdo nota do jogador -->
          </div>

          <div class="tab-pane fade" id="notas-treino-'.$idModal.'" role="tabpanel" aria-labelledby="notas-treino-tab-'.$idModal.'">
            <!-- conteúdo notas de treino -->
          </div>


        </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="cancelarModal" data-bs-dismiss="modal">Fechar</button>
      </div>
    </div>
  </div>
</div>';



echo $retorno;
?>
