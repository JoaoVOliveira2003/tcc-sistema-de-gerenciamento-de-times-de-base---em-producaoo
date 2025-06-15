<?php
require('../../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod_jogador = getPost('cod_jogador');
$idModal = getPost('idModal');
$cod_role = getPost('cod_role');

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
// $desc_lesao = $bd->SqlQueryShow('desc_lesao');
// $data_lesao = $bd->SqlQueryShow('data_lesao');
// $tempoFora_lesao = $bd->SqlQueryShow('tempoFora_lesao');
// $nota_ativa = $bd->SqlQueryShow('nota_ativa');
// $data_atualizacao = $bd->SqlQueryShow('data_atualizacao');
// $nota_jogador = $bd->SqlQueryShow('nota_jogador');

// Exemplo de uso no modal:
$retorno = '
<div class="modal fade" id="' . $idModal . '" tabindex="-1" aria-labelledby="modalLabel-' . $idModal . '" aria-hidden="true">
  <div class="modal-dialog modal-xl">  <!-- modal-xl para largura extra -->
    <div class="modal-content shadow-sm border-0">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="modalLabel-' . $idModal . '">' . $nome . '</h5>
      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar" onclick="fecharModalCorretamente()"></button>
      </div>

      <div class="modal-body p-4">
        <ul class="nav nav-tabs" id="myTab-' . $idModal . '" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="dados-pessoais-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-pessoais-' . $idModal . '" type="button" role="tab" aria-controls="dados-pessoais-' . $idModal . '" aria-selected="true">Dados pessoais</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="ficha-medica-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#ficha-medica-' . $idModal . '" type="button" role="tab" aria-controls="ficha-medica-' . $idModal . '" aria-selected="false">Ficha médica</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="dados-responsaveis-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-responsaveis-' . $idModal . '" type="button" role="tab" aria-controls="dados-responsaveis-' . $idModal . '" aria-selected="false">Dados dos responsáveis</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="nota-jogador-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#nota-jogador-' . $idModal . '" type="button" role="tab" aria-controls="nota-jogador-' . $idModal . '" aria-selected="false">Nota do jogador</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="notas-treino-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#notas-treino-' . $idModal . '" type="button" role="tab" aria-controls="notas-treino-' . $idModal . '" aria-selected="false">Notas de treino</button>
          </li>
        </ul>

      
      <div class="tab-content mt-3" id="myTabContent-' . $idModal . '">
        <div class="tab-pane fade show active" id="dados-pessoais-' . $idModal . '" role="tabpanel" aria-labelledby="dados-pessoais-tab-' . $idModal . '">
          <div class="text-center mb-4">
            <img src="../../img/jogador/' . $local_midia . '" alt="Imagem do Usuário" class="img-fluid rounded" style="max-width: 150px;">
          </div>
          <div class="row mb-1">
            <div class="col-md-8">
              <label class="form-label">Nome:</label>
              <input disabled type="text" class="form-control" value="' . $nome . '">
            </div>
            <div class="col-md-2">
              <label class="form-label">Data de Nascimento:</label>
              <input disabled type="text" class="form-control" value="' . formatarData($data_nascimento) . '">
            </div>
            <div class="col-md-2">
              <label class="form-label">CPF:</label>
              <input disabled type="text" class="form-control" value="' . formatarCPF($cpf) . '">
            </div>
          </div>
          <div class="row mb-1">
            <div class="col-md-4">
              <label class="form-label">Instituição:</label>
              <input disabled type="text" class="form-control" value="' . $desc_instituicao . '">
            </div>
            <div class="col-md-4">
              <label class="form-label">Subinstituição:</label>
              <input disabled type="text" class="form-control" value="' . $desc_subInstituicao . '">
            </div>
            <div class="col-md-4">
              <label class="form-label">Turma:</label>
              <input disabled type="text" class="form-control" value="' . $desc_turma . '">
            </div>
          </div>
          <div class="row mb-1">
            <div class="col-md-4">
              <label class="form-label">Nação:</label>
              <input disabled type="text" class="form-control" value="' . $desc_nacao . '">
            </div>
            <div class="col-md-4">
              <label class="form-label">Estado:</label>
              <input disabled type="text" class="form-control" value="' . $desc_estado . '">
            </div>
            <div class="col-md-4">
              <label class="form-label">Município:</label>
              <input disabled type="text" class="form-control" value="' . $desc_municipio . '">
            </div>
          </div>

          <div class="row mb-1">
            <div class="col-md-6">
              <label class="form-label">Esporte:</label>
              <input disabled type="text" class="form-control" value="' . $desc_esporte . '">
            </div>
            <div class="col-md-6">
              <label class="form-label">Posição:</label>
              <input disabled type="text" class="form-control" value="' . $desc_posicao . '">
            </div>
          </div>

        </div>
  


      <div class="tab-pane fade" id="ficha-medica-' . $idModal . '" role="tabpanel" aria-labelledby="ficha-medica-tab-' . $idModal . '">

      <div class="row mb-1">
      <div class="col-md-4">
        <label class="form-label">Altura:</label>
        <input disabled type="text" class="form-control" value="' . $altura . '">
      </div>
      <div class="col-md-4">
        <label class="form-label">Peso:</label>
        <input disabled type="text" class="form-control" value="' . $peso . '">
      </div>
          <div class="col-md-4">
        <label class="form-label">alergias:</label>
        <input disabled type="text" class="form-control" value="' . $alergias . '">
      </div>
      </div>

      <div class="row mb-1">
      <div class="col-md-6">
        <label class="form-label">tipoSanguineo:</label>
        <input disabled type="text" class="form-control" value="' . $tipoSanguineo . '">
      </div>
      <div class="col-md-6">
        <label class="form-label">restricoes_medicas:</label>
        <input disabled type="text" class="form-control" value="' . $restricoes_medicas . '">
      </div>
    </div>
 ';



$query = "SELECT  
ti.desc_tipoLesao,
hi.desc_lesao,
hi.data_lesao,
hi.tempoFora_lesao
FROM fichaMedica_historicoLesoes fihi 
INNER JOIN historicoLesoes hi ON fihi.cod_historicoLesoes = hi.cod_historicoLesoes
inner join tipo_lesao ti on ti.cod_tipoLesao = hi.cod_tipoLesao
where fihi.cod_jogador = $cod_jogador
;";

if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
  return;
}

do {
  $desc_tipoLesao = $bd->SqlQueryShow('desc_tipoLesao');
  $desc_lesao = $bd->SqlQueryShow('desc_lesao');
  $data_lesao = $bd->SqlQueryShow('data_lesao');
  $tempoFora_lesao = $bd->SqlQueryShow('tempoFora_lesao');

  $retorno .= '
            <label class="form-label">Lesoes:</label>
            <div id="responsaveis-container">
                <div class="responsavel card border rounded p-3 bg-light">
                    <div class="row g-2 mb-2">
                        <div class="col-md-6">
        <label class="form-label">desc_tipoLesao:</label>
        <input disabled type="text" class="form-control" value="' . $desc_tipoLesao . '">
                        </div>
                        <div class="col-md-6">
        <label class="form-label">desc_lesao:</label>
        <input disabled type="text" class="form-control" value="' . $desc_lesao . '">
                        </div>
                    </div>
                    <div class="row g-2">
                        <div class="col-md-6">
        <label class="form-label">data_lesao:</label>
        <input disabled type="text" class="form-control" value="' . $data_lesao . '">
                        </div>
                        <div class="col-md-6">
        <label class="form-label">tempoFora_lesao:</label>
        <input disabled type="text" class="form-control" value="' . $tempoFora_lesao . '">
                        </div>

                    </div>
                </div>
            </div>
           </div>
         
            ';

} while ($bd->SqlFetchNext());
$query = "
SELECT contre.nomeResponsavel,contre.tipoFiliacao,contre.emailResponsavel,contre.telefoneResponsavel
FROM jogador_contatoResponsavel cont
inner join  contato_responsavel contre on cont.cod_contatoResponsavel = contre.cod_contatoResponsavel
where cont.cod_jogador = $cod_jogador
;";
if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
  return;
}
do {
  $nomeResponsavel = $bd->SqlQueryShow('nomeResponsavel');
  $tipoFiliacao = $bd->SqlQueryShow('tipoFiliacao');
  $emailResponsavel = $bd->SqlQueryShow('emailResponsavel');
  $telefoneResponsavel = $bd->SqlQueryShow('telefoneResponsavel');

  $retorno .= '
<div class="tab-pane fade" id="dados-responsaveis-' . $idModal . '" role="tabpanel" aria-labelledby="dados-responsaveis-tab-' . $idModal . '">
  <label class="form-label">Responsaveis:</label>
            <div id="responsaveis-container">
                <div class="responsavel card border rounded p-3 bg-light">
                    <div class="row g-2 mb-2">
                        <div class="col-md-6">
        <label class="form-label">Nome do responsavel:</label>
        <input disabled type="text" class="form-control" value="' . $nomeResponsavel . '">
                        </div>
                        <div class="col-md-6">
        <label class="form-label">Tipo de filiação:</label>
        <input disabled type="text" class="form-control" value="' . $tipoFiliacao . '">
                        </div>
                    </div>
                    <div class="row g-2">
                   <div class="col-md-6">
                          <label class="form-label">Email:</label>
                          <input disabled type="text" class="form-control" value="' . $emailResponsavel . '">
                        </div>

                      <div class="col-md-6 d-flex align-items-end">
                      <div style="width: 100%;">
                              <label class="form-label">Telefone:</label>
                              <input disabled type="text" class="form-control" value="' . $telefoneResponsavel . '">
                          </div>
                            <div class="ms-2 mb-1">
                              <a href="https://wa.me/55' . preg_replace('/\D/', '', $telefoneResponsavel) . '" target="_blank">
                                  <img src="../../img/icone/whatsapp.png" alt="WhatsApp" title="Enviar mensagem via WhatsApp">
                              </a>
                          </div>
                      </div>
                    </div>
                </div>
            </div>
           ';

} while ($bd->SqlFetchNext());



$retorno .= '  
  </div>
  <div class="tab-pane fade" id="nota-jogador-' . $idModal . '" role="tabpanel" aria-labelledby="nota-jogador-tab-' . $idModal . '">

    <label class="form-label">Nota atual:</label>
    <div id="nota-atual-container">';

$query = "
select jo.cod_jogador, noj.nota_jogador, noj.data_atualizacao, noj.ativo, cad.nome
from jogador jo
inner join nota_jogador noj on noj.cod_jogador = jo.cod_jogador
inner join staff st on st.cod_staff = noj.cod_staff
inner join cadastro_identificacao cad on cad.cod_usuario = st.cod_staff
where noj.cod_jogador=$cod_jogador
order by ativo desc
";

$bd->SqlExecuteQuery($query);

$temNotaAtual = false;
$retornoNotasAnteriores = ''; // armazena notas anteriores separadas

do {
  $nota_jogador = $bd->SqlQueryShow('nota_jogador');
  $data_atualizacao = $bd->SqlQueryShow('data_atualizacao');
  $nome = $bd->SqlQueryShow('nome');
  $ativo = $bd->SqlQueryShow('ativo');

if ($ativo == 's') {
    $temNotaAtual = true;
    $retorno .= '
      <div class="responsavel card border rounded p-3 bg-light mb-3">
        <div class="row g-2 mb-2">
          <div class="col-md-12">Nota atual:
            <input disabled type="text" class="form-control" value="' . $nota_jogador . '">
          </div>
        </div>
        <div class="row g-2">
          <div class="col-md-6">Inserido por :
            <input disabled type="text" class="form-control" value="' . $nome . '">
          </div>
          <div class="col-md-6">Data de atualização: 
            <input disabled type="text" class="form-control" value="' . formatarDataHora($data_atualizacao) . '">
          </div>
        </div>';
        
    if ($cod_role == 4 || $cod_role == 5) {
        $retorno .= '<button type="button" class="btn mt-3 btn-sm btn-success col-1" onclick="abrirModalAtualizarNota()">Nova nota</button>';
    }

    $retorno .= '
      </div>
    ';
}

  
  else {
    // Acumula as notas anteriores numa string, para mostrar depois
    $retornoNotasAnteriores .= '
      <div class="responsavel card border rounded p-2 bg-light mb-3">
        <div class="row g-2 mb-2">
          <div class="col-md-12">Notas anteriores
            <input disabled type="text" class="form-control" value="' . $nota_jogador . '">
          </div>
        </div>
        <div class="row g-2">
          <div class="col-md-6">Inserido por
            <input disabled type="text" class="form-control" value="' . $nome . '">
          </div>
          <div class="col-md-6">Data de atualização:
            <input disabled type="text" class="form-control" value="' . formatarDataHora($data_atualizacao) . '">
          </div>
        </div>
      </div>
    ';
  }
} while ($bd->SqlFetchNext());

$retorno .= '</div>'; // fecha nota-atual-container

if ($retornoNotasAnteriores !== '') {
  $retorno .= '
    <hr>
    <label class="form-label">Notas anteriores:</label>
    <div id="notas-anteriores-container">
      ' . $retornoNotasAnteriores . '
    </div>
  ';
}

$retorno .= '
  <!-- conteúdo nota do jogador -->
    </div>
          <div class="tab-pane fade" id="notas-treino-' . $idModal . '" role="tabpanel" aria-labelledby="notas-treino-tab-' . $idModal . '">
            <!-- conteúdo notas de treino -->
          </div>


        </div>

        <div class="modal-footer">
  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
</div>
      </div>
    </div>
  </div>
</div>';


$retorno .= '
  <style>
    /* Corrigir sobreposição do segundo modal e backdrop */
    .modal-backdrop.show:nth-of-type(2) {
      z-index: 1055;
    }

    #modal2 {
      z-index: 1060;
    }
  </style>

  <div class="modal fade" id="modal2" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">

      <div class="modal-header">
          <h5 class="modal-title">Atualização de nota</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
        </div>

        <div class="modal-body">
          <p>Este é o local para atualizar a tela para os jogadores. <br>
          As notas são de 0 até 100. Quando um usuário é cadastrado, ele tem sua nota padrão de 60.</p>

          <div class="row">
          <div class="mb-3 col-12">
            <label class="form-label">Nova nota:</label>
            <input type="text" max id="novaNota" onkeypress="return somenteNumeros(event)" maxlength="3" class="form-control">
          </div>

          </div>
          <button type="button" class="btn btn-sm btn-success mt-3" onclick="adicionarNota(' . $cod_jogador . ')">
            Atualizar nota
          </button>
        </div>
      </div>
    </div>
  </div>
';



echo $retorno;
?>