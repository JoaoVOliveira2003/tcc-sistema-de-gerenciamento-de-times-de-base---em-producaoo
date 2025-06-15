<?php
require('../../include/conecta.php');
$bd = conecta();

$cod_usuario  = getPost('cod_usuario');
$cod_tipoRole = getPost('cod_tipoRole');
$idModal      = "modalDadosPessoa";
$retorno      = '';

// Funções de navegação
function navDadosLogin($idModal) {
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="dados-login-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-login-' . $idModal . '" type="button" role="tab" aria-controls="dados-login-' . $idModal . '" aria-selected="true">Dados de Login</button>
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
    <div class="tab-pane fade show active" id="dados-login-' . $idModal . '" role="tabpanel" aria-labelledby="dados-login-tab-' . $idModal . '">
        <p>Conteúdo da Aba de Login</p>
    </div>';
}

function conteudoDadosPessoais($idModal) {
    return '
    <div class="tab-pane fade" id="dados-pessoais-' . $idModal . '" role="tabpanel" aria-labelledby="dados-pessoais-tab-' . $idModal . '">
        <p>Conteúdo da Aba de Dados Pessoais</p>
    </div>';
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

if ($cod_tipoRole == 1) { // TI
    $retorno .= navDadosLogin($idModal);

} elseif ($cod_tipoRole == 2) { // ADMI
    $retorno .= navDadosLogin($idModal);
    $retorno .= navDadosPessoais($idModal);
    $retorno .= navMinhasInstituicoes($idModal);

} elseif ($cod_tipoRole == 3) { // ADMS
    $retorno .= navDadosLogin($idModal);
    $retorno .= navDadosPessoais($idModal);
    $retorno .= navMinhasInstituicoes($idModal);

} elseif ($cod_tipoRole == 4 || $cod_tipoRole == 5) { // ADMS | STAFF ou STAFF
    $retorno .= navDadosLogin($idModal);
    $retorno .= navDadosPessoais($idModal);
    $retorno .= navMinhasInstituicoes($idModal);
    $retorno .= navMinhasTurmas($idModal);

} elseif ($cod_tipoRole == 6) { // Jogador
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
    $retorno .= conteudoDadosLogin($idModal);

} elseif ($cod_tipoRole == 2 || $cod_tipoRole == 3) {
    $retorno .= conteudoDadosLogin($idModal);
    $retorno .= conteudoDadosPessoais($idModal);
    $retorno .= conteudoMinhasInstituicoes($idModal);

} elseif ($cod_tipoRole == 4 || $cod_tipoRole == 5) {
    $retorno .= conteudoDadosLogin($idModal);
    $retorno .= conteudoDadosPessoais($idModal);
    $retorno .= conteudoMinhasInstituicoes($idModal);
    $retorno .= conteudoMinhasTurmas($idModal);

} elseif ($cod_tipoRole == 6) {
    $retorno .= conteudoDadosPessoais($idModal);
    $retorno .= conteudoFichaMedica($idModal);
    $retorno .= conteudoDadosResponsaveis($idModal);
    $retorno .= conteudoMinhaNota($idModal);
    $retorno .= conteudoNotasTreino($idModal);
}

$retorno .= '</div>';

$bd->SqlDisconnect();
exit($retorno);
