<?php
require('../../include/conecta.php');
$bd = conecta(); 
$cod_usuario  = 1;
$cod_tipoRole = 1;

//$cod_usuario  = getPost('cod_usuario');
// $cod_tipoRole = getPost('cod_tipoRole');

$idModal      = "modalDadosPessoa";
$retorno      = '';

// Funções de navegação
function navDadosLogin($idModal) {
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link  " id="dados-login-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-login-' . $idModal . '" type="button" role="tab" aria-controls="dados-login-' . $idModal . '" aria-selected="true">Dados de Login</button>
    </li>';
}

function navDadosPessoais($idModal) {
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="dados-pessoais-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-pessoais-' . $idModal . '" type="button" role="tab" aria-controls="dados-pessoais-' . $idModal . '" aria-selected="false">Dados Pessoais</button>
    </li>';
}

function navMinhasInstituicoes($idModal) {
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="minhas-instituicoes-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#minhas-instituicoes-' . $idModal . '" type="button" role="tab" aria-controls="minhas-instituicoes-' . $idModal . '" aria-selected="false">Minhas Instituições</button>
    </li>';
}

function navMinhasTurmas($idModal) {
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="minhas-turmas-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#minhas-turmas-' . $idModal . '" type="button" role="tab" aria-controls="minhas-turmas-' . $idModal . '" aria-selected="false">Minhas Turmas</button>
    </li>';
}

function navFichaMedica($idModal) {
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="ficha-medica-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#ficha-medica-' . $idModal . '" type="button" role="tab" aria-controls="ficha-medica-' . $idModal . '" aria-selected="false">Ficha Médica</button>
    </li>';
}

function navDadosResponsaveis($idModal) {
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="dados-responsaveis-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-responsaveis-' . $idModal . '" type="button" role="tab" aria-controls="dados-responsaveis-' . $idModal . '" aria-selected="false">Responsáveis</button>
    </li>';
}

function navMinhaNota($idModal) {
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="minha-nota-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#minha-nota-' . $idModal . '" type="button" role="tab" aria-controls="minha-nota-' . $idModal . '" aria-selected="false">Minha Nota</button>
    </li>';
}

function navNotasTreino($idModal) {
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="notas-treino-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#notas-treino-' . $idModal . '" type="button" role="tab" aria-controls="notas-treino-' . $idModal . '" aria-selected="false">Notas de Treino</button>
    </li>';
}

// Funções de conteúdo
function conteudoDadosLogin($idModal) {
    return '
    <div class="tab-pane fade show " id="dados-login-' . $idModal . '" role="tabpanel" aria-labelledby="dados-login-tab-' . $idModal . '">
        <p>Conteúdo da Aba de Login</p>
    </div>';
}

function conteudoDadosPessoais($idModal,$cod_tipoRole,$cod_usuario) {
if($cod_tipoRole == 1){
    $query = "SELECT nome,cpf FROM cadastro_identificacao where cod_usuario = $cod_usuario";


    $bd = conecta(); 
    if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
    }


    $nome = $bd->SqlQueryShow('nome');
    $cpf = $bd->SqlQueryShow('cpf');

    return '
    <div class="tab-pane fade show" id="dados-pessoais-' . $idModal . '" role="tabpanel" aria-labelledby="dados-pessoais-tab-' . $idModal . '">
    <div class="mb-3">
        <h5 class="mb-2">Dados Pessoais</h5>
        <div class="row g-3 align-items-center">
        <div class="col-md-8">
            <label for="nome-' . $idModal . '" class="form-label fw-semibold">Nome</label>
            <input type="text" id="nome-' . $idModal . '" class="form-control" value="' . htmlspecialchars($nome) . '" disabled>
        </div>
        <div class="col-md-4">
            <label for="cpf-' . $idModal . '" class="form-label fw-semibold">CPF</label>
            <input type="text" id="cpf-' . $idModal . '" class="form-control" value="' . formatarCPF($cpf) . '" disabled>
        </div>
        </div>
    </div>
    </div>';
}
else if($cod_tipoRole == 2){
}
else if($cod_tipoRole == 3){
}
else if($cod_tipoRole == 4){
}
else if($cod_tipoRole == 5){
}

else if ($cod_tipoRole == 6){

$query = "
SELECT 
    inst.cod_instituicao, inst.desc_instituicao,
    si.cod_subInstituicao, si.desc_subInstituicao,
    t.cod_turma, t.desc_turma,
    ci.cod_usuario, ci.nome, ci.cpf, ci.ativo,
    mun.desc_municipio, est.desc_estado, nac.desc_nacao,
    j.data_nascimento,
    pos.desc_posicao, esp.desc_esporte,
    fm.altura, fm.peso, fm.tipoSanguineo,
    fm.restricoes_medicas, fm.alergias,
    mj.local_midia,
    hl.desc_lesao, hl.data_lesao, hl.tempoFora_lesao,
    nota.ativo AS nota_ativa, nota.data_atualizacao, nota.nota_jogador

FROM cadastro_identificacao ci
INNER JOIN role_cadastro rc ON rc.cod_usuario = ci.cod_usuario
INNER JOIN jogador j ON j.cod_jogador = rc.cod_usuario
LEFT JOIN posicao pos ON pos.cod_posicao = j.posicao
LEFT JOIN esporte esp ON esp.cod_esporte = j.esporte
LEFT JOIN fichaMedica fm ON fm.cod_jogador = j.cod_jogador
LEFT JOIN midia_jogador mj ON mj.cod_jogador = j.cod_jogador
LEFT JOIN turma_jogador tj ON tj.cod_jogador = j.cod_jogador
LEFT JOIN turma t ON t.cod_turma = tj.cod_turma
LEFT JOIN subInstituicao si ON si.cod_subInstituicao = t.cod_subInstituicao
LEFT JOIN instituicao inst ON inst.cod_instituicao = si.cod_instituicao
LEFT JOIN fichaMedica_historicoLesoes fmhl ON fmhl.cod_jogador = j.cod_jogador
LEFT JOIN historicoLesoes hl ON hl.cod_historicoLesoes = fmhl.cod_historicoLesoes
INNER JOIN municipio mun ON mun.cod_municipio = ci.cod_municipio
INNER JOIN estado est ON est.cod_estado = mun.cod_estado
INNER JOIN nacao nac ON nac.cod_nacao = est.cod_nacao
LEFT JOIN nota_jogador nota ON nota.cod_jogador = j.cod_jogador

WHERE 
    (nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL)
    AND ci.cod_usuario = $cod_usuario

ORDER BY 
    inst.cod_instituicao, si.cod_subInstituicao, t.cod_turma, ci.nome
";


    $bd = conecta(); 
    if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
    }


    $desc_instituicao = $bd->SqlQueryShow('desc_instituicao');
    $desc_subInstituicao = $bd->SqlQueryShow('desc_subInstituicao');
    $desc_turma = $bd->SqlQueryShow('desc_turma');
    $cod_usuario = $bd->SqlQueryShow('cod_usuario');
    $nome = $bd->SqlQueryShow('nome');
    $cpf = $bd->SqlQueryShow('cpf');
    $desc_municipio = $bd->SqlQueryShow('desc_municipio');
    $desc_estado = $bd->SqlQueryShow('desc_estado');
    $desc_nacao = $bd->SqlQueryShow('desc_nacao');
    $data_nascimento = $bd->SqlQueryShow('data_nascimento');
    $desc_posicao = $bd->SqlQueryShow('desc_posicao');
    $desc_esporte = $bd->SqlQueryShow('desc_esporte');
    $local_midia = $bd->SqlQueryShow('local_midia');


    return '
    <div class="tab-pane fade show " id="dados-pessoais-' . $idModal . '" role="tabpanel" aria-labelledby="dados-pessoais-tab-' . $idModal . '">
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
    </div>';   
    }
}

function conteudoMinhasInstituicoes($idModal) {
    return '
    <div class="tab-pane fade" id="minhas-instituicoes-' . $idModal . '" role="tabpanel" aria-labelledby="minhas-instituicoes-tab-' . $idModal . '">
        <p>Conteúdo da Aba Minhas Instituições</p>
    </div>';
}

function conteudoMinhasTurmas($idModal) {
    return '
    <div class="tab-pane fade" id="minhas-turmas-' . $idModal . '" role="tabpanel" aria-labelledby="minhas-turmas-tab-' . $idModal . '">
        <p>Conteúdo da Aba Minhas Turmas</p>
    </div>';
}

function conteudoFichaMedica($idModal) {
    return '
    <div class="tab-pane fade" id="ficha-medica-' . $idModal . '" role="tabpanel" aria-labelledby="ficha-medica-tab-' . $idModal . '">
        <p>Conteúdo da Aba Ficha Médica</p>
    </div>';
}

function conteudoDadosResponsaveis($idModal) {
    return '
    <div class="tab-pane fade" id="dados-responsaveis-' . $idModal . '" role="tabpanel" aria-labelledby="dados-responsaveis-tab-' . $idModal . '">
        <p>Conteúdo da Aba Responsáveis</p>
    </div>';
}

function conteudoMinhaNota($idModal) {
    return '
    <div class="tab-pane fade" id="minha-nota-' . $idModal . '" role="tabpanel" aria-labelledby="minha-nota-tab-' . $idModal . '">
        <p>Conteúdo da Aba Minha Nota</p>
    </div>';
}

function conteudoNotasTreino($idModal) {
    return '
    <div class="tab-pane fade" id="notas-treino-' . $idModal . '" role="tabpanel" aria-labelledby="notas-treino-tab-' . $idModal . '">
        <p>Conteúdo da Aba Notas de Treino</p>
    </div>';
}

// Montagem HTML conforme role
$retorno .= '<ul class="nav nav-tabs" id="abas" role="tablist">';
//aqui
if ($cod_tipoRole == 1) { // TI
    $retorno .= navDadosPessoais($idModal);    
    $retorno .= navDadosLogin($idModal);

} elseif ($cod_tipoRole == 2) { // ADMI
    $retorno .= navDadosPessoais($idModal);

    $retorno .= navDadosLogin($idModal);
    $retorno .= navMinhasInstituicoes($idModal);

} elseif ($cod_tipoRole == 3) { // ADMS
    $retorno .= navDadosPessoais($idModal);

    $retorno .= navDadosLogin($idModal);
    $retorno .= navMinhasInstituicoes($idModal);

}
elseif ($cod_tipoRole == 4) { // ADMS e STAFF 
    $retorno .= navDadosPessoais($idModal);

    $retorno .= navDadosLogin($idModal);
    $retorno .= navMinhasInstituicoes($idModal);
    $retorno .= navMinhasTurmas($idModal);

}
elseif ($cod_tipoRole == 5) { // STAFF
    $retorno .= navDadosPessoais($idModal);
    $retorno .= navDadosLogin($idModal);
    $retorno .= navMinhasInstituicoes($idModal);
    $retorno .= navMinhasTurmas($idModal);

}
elseif ($cod_tipoRole == 6) { // Jogador
    $retorno .= navDadosPessoais($idModal);
    $retorno .= navFichaMedica($idModal);
    $retorno .= navDadosResponsaveis($idModal);
    $retorno .= navMinhaNota($idModal);
    $retorno .= navNotasTreino($idModal);

} else {
    $retorno .= '<li class="nav-item"><span class="text-danger">Tipo de usuário inválido</span></li>';
}




$retorno .= '</ul><div class="tab-content mt-3" id="conteudoDasAbas">';

if ($cod_tipoRole == 1) {
    $retorno .= conteudoDadosPessoais($idModal,$cod_tipoRole,$cod_usuario) ;
    $retorno .= conteudoDadosLogin($idModal);
}
elseif ($cod_tipoRole == 2 ) {    $retorno .= conteudoDadosPessoais($idModal,$cod_tipoRole,$cod_usuario) ;
    $retorno .= conteudoDadosLogin($idModal);
    $retorno .= conteudoMinhasInstituicoes($idModal);
} 
 elseif ($cod_tipoRole == 3) {
    $retorno .= conteudoDadosPessoais($idModal,$cod_tipoRole,$cod_usuario) ;
    $retorno .= conteudoDadosLogin($idModal);
    $retorno .= conteudoMinhasInstituicoes($idModal);
} 
elseif ($cod_tipoRole == 4) {
    $retorno .= conteudoDadosPessoais($idModal,$cod_tipoRole,$cod_usuario) ;
    $retorno .= conteudoDadosLogin($idModal);
    $retorno .= conteudoMinhasInstituicoes($idModal);
    $retorno .= conteudoMinhasTurmas($idModal);
}
elseif ($cod_tipoRole == 5) {
    $retorno .= conteudoDadosPessoais($idModal,$cod_tipoRole,$cod_usuario) ;
    $retorno .= conteudoDadosLogin($idModal);
    $retorno .= conteudoMinhasInstituicoes($idModal);
    $retorno .= conteudoMinhasTurmas($idModal);

} elseif ($cod_tipoRole == 6) {
    $retorno .= conteudoDadosPessoais($idModal,$cod_tipoRole,$cod_usuario) ;
    $retorno .= conteudoFichaMedica($idModal);
    $retorno .= conteudoDadosResponsaveis($idModal);
    $retorno .= conteudoMinhaNota($idModal);
    $retorno .= conteudoNotasTreino($idModal);
}


$retorno .= '</div>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var btn = document.getElementById("dados-pessoais-tab-modalDadosPessoa");
    if (btn) {
        btn.click(); // Emula o clique
    }
});
</script>
';

$bd->SqlDisconnect();
exit($retorno);
