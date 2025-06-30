<?php
require('../../include/conecta.php');
$bd = conecta();
$cod_usuario =  20;
$cod_tipoRole = 6;

//$cod_usuario  = getPost('cod_usuario');
//$cod_tipoRole = getPost('cod_tipoRole');

$idModal = "modalDadosPessoa";
$retorno = '';

// Funções de navegação
// ---------------------
function navADMS($idModal)
{
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="dados-adms-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-adms-' . $idModal . '" type="button" role="tab" aria-controls="dados-adms-' . $idModal . '" aria-selected="true">Dados ADMS</button>
    </li>';
}

function conteudoADMS($idModal, $cod_usuario): string
{
    $query = "
    SELECT a.nome, a.cpf, b.email_usuario, b.senha,e.desc_instituicao,d.desc_subInstituicao
    FROM cadastro_identificacao a
    INNER JOIN login_usuario b ON a.cod_usuario = b.cod_usuario 
    INNER JOIN administrador_subinstituicao c ON a.cod_usuario = c.cod_administrador
    inner join subinstituicao d on d.cod_subInstituicao = c.cod_subInstituicao
    inner join instituicao e on e.cod_instituicao = d.cod_instituicao
    WHERE a.cod_usuario = $cod_usuario
    ";

    $bd = conecta();
    if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
        return '';
    }

    $desc_subInstituicao = $bd->SqlQueryShow('desc_subInstituicao');
    $desc_instituicao = $bd->SqlQueryShow('desc_instituicao');
    $nome = $bd->SqlQueryShow('nome');
    $cpf = $bd->SqlQueryShow('cpf');
    $email_usuario = $bd->SqlQueryShow('email_usuario');
    $senha = $bd->SqlQueryShow('senha');

    return '
    <div class="tab-pane fade show active" id="dados-adms-' . $idModal . '" role="tabpanel" aria-labelledby="dados-adms-tab-' . $idModal . '">
        <div class="mb-">
            <div class="row g-3 align-items-center">
                <div class="col-md-8">
                    <label for="nome-' . $idModal . '" class="form-label fw-semibold">Nome</label>
                    <input type="text" id="nome-' . $idModal . '" class="form-control" value="' . htmlspecialchars($nome) . '" disabled>
                </div>
                <div class="col-md-4">
                    <label for="cpf-' . $idModal . '" class="form-label fw-semibold">CPF</label>
                    <input type="text" id="cpf-' . $idModal . '" class="form-control" value="' . formatarCPF($cpf) . '" disabled>
                </div>
                <div class="col-md-6">
                    <label for="nome-' . $idModal . '" class="form-label fw-semibold">Pertence a instituição:</label>
                    <input type="text" id="nome-' . $idModal . '" class="form-control" value="' . htmlspecialchars($desc_instituicao) . '" disabled>
                </div>
                <div class="col-md-6">
                    <label for="nome-' . $idModal . '" class="form-label fw-semibold">Sub-Instituição:</label>
                    <input type="text" id="nome-' . $idModal . '" class="form-control" value="' . htmlspecialchars($desc_subInstituicao) . '" disabled>
                </div>
            </div>
        </div>
        <hr>
<h5>Dados de Login </h5>  
<p>Para atualizar a senha do seu login, digite a nova senha no campo da senha atual, clique no botão para prosseguir e confirme a alteração.</p>
<div class="mb-3">
    <div class="row g-3 align-items-center">
        <div class="col-md-6">
            <label  class="form-label fw-semibold">Email Cadastrado</label>
            <input type="text"  class="form-control" value="' . $email_usuario . '" disabled>
        </div>

        <div class="col-md-6">
            <label for="senha" class="form-label fw-semibold">Senha</label>
            <div class="input-group">
                <input type="password" class="form-control" value="' . $senha . '" id="senha" name="senha">
                <button class="btn btn-outline-secondary" type="button" onclick="toggleSenha()">
                    <img src="../../img/icone/olho.png" width="15" height="15" alt="Mostrar senha">
                </button>
            </div>
        </div>
    </div>
</div>
                <div class="col-md-2">
                <button type="button" onclick="modalMudarSenha(' . $cod_usuario . ')" class="btn btn-primary btn-sm">Modificar senha</button>
                </div>
         </div>
        </div> 
    </div>';
}

function navMinhaNota($idModal)
{
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="minha-nota-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#minha-nota-' . $idModal . '" type="button" role="tab" aria-controls="minha-nota-' . $idModal . '" aria-selected="false">Minha Nota</button>
    </li>';
}

function navNotasTreino($idModal)
{
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="notas-treino-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#notas-treino-' . $idModal . '" type="button" role="tab" aria-controls="notas-treino-' . $idModal . '" aria-selected="false">Notas de Treino</button>
    </li>';
}


function navTI($idModal)
{
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="dados-ti-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-ti-' . $idModal . '" type="button" role="tab" aria-controls="dados-ti-' . $idModal . '" aria-selected="true">Dados TI</button>
    </li>';
}

function conteudoTI($idModal, $cod_usuario): string
{
   
   $query = "SELECT a.nome,a.cpf,b.email_usuario,b.senha FROM cadastro_identificacao a 
inner join login_usuario b on a.cod_usuario = b.cod_usuario
where a.cod_usuario =  $cod_usuario";


    $bd = conecta();
    if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
        return '';
    }


    $nome = $bd->SqlQueryShow('nome');
    $cpf = $bd->SqlQueryShow('cpf');

    $email_usuario = $bd->SqlQueryShow('email_usuario');
    $senha = $bd->SqlQueryShow('senha');

    return '
    <div class="tab-pane fade show active" id="dados-ti-' . $idModal . '" role="tabpanel" aria-labelledby="dados-ti-tab-' . $idModal . '">
        <div class="mb-">
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
        <hr>
<h5>Dados de Login </h5>  
<p>Para atualizar a senha do seu login, digite a nova senha no campo da senha atual, clique no botão para prosseguir e confirme a alteração.</p>
<div class="mb-3">
    <div class="row g-3 align-items-center">
        <div class="col-md-6">
            <label for="nome-<?php echo $idModal; ?>" class="form-label fw-semibold">Email Cadastrado</label>
            <input type="text"  class="form-control" value="' . $email_usuario . '" disabled>
        </div>

        <div class="col-md-6">
            <label for="senha" class="form-label fw-semibold">Senha</label>
            <div class="input-group">
                <input type="password" class="form-control" value="' . $senha . '" id="senha" name="senha">
                <button class="btn btn-outline-secondary" type="button" onclick="toggleSenha()">
                    <img src="../../img/icone/olho.png" width="15" height="15" alt="Mostrar senha">
                </button>
            </div>
        </div>
    </div>
</div>

                <div class="col-md-2">
                <button type="button" onclick="modalMudarSenha(' . $cod_usuario . ')" class="btn btn-primary btn-sm">Modificar senha</button>
                </div>
         </div>
        </div> 
         </div>';
}

// ---------------------


function navDadosPessoais($idModal)
{
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="dados-pessoais-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-pessoais-' . $idModal . '" type="button" role="tab" aria-controls="dados-pessoais-' . $idModal . '" aria-selected="false">Dados Pessoais</button>
    </li>';
}


function navFichaMedica($idModal)
{
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="ficha-medica-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#ficha-medica-' . $idModal . '" type="button" role="tab" aria-controls="ficha-medica-' . $idModal . '" aria-selected="false">Ficha Médica</button>
    </li>';
}
function navDadosResponsaveis($idModal)
{
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="dados-responsaveis-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-responsaveis-' . $idModal . '" type="button" role="tab" aria-controls="dados-responsaveis-' . $idModal . '" aria-selected="false">Responsáveis</button>
    </li>';
}


function conteudoDadosPessoais($idModal, $cod_tipoRole, $cod_usuario)
{
    $bd = conecta();

    if ($cod_tipoRole == 1) {
        $query = "SELECT nome, cpf FROM cadastro_identificacao WHERE cod_usuario = $cod_usuario";

        if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
            return '';
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

    else if ($cod_tipoRole == 6) {
        $query = "
        SELECT inst.desc_instituicao, si.desc_subInstituicao, t.desc_turma,
               ci.cod_usuario, ci.nome, ci.cpf,
               mun.desc_municipio, est.desc_estado, nac.desc_nacao,
               j.data_nascimento, pos.desc_posicao, esp.desc_esporte,
               mj.local_midia, b.email_usuario, b.senha
        FROM cadastro_identificacao ci 
        LEFT JOIN login_usuario b ON b.cod_usuario = ci.cod_usuario 
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
        INNER JOIN municipio mun ON mun.cod_municipio = ci.cod_municipio 
        INNER JOIN estado est ON est.cod_estado = mun.cod_estado 
        INNER JOIN nacao nac ON nac.cod_nacao = est.cod_nacao 
        LEFT JOIN nota_jogador nota ON nota.cod_jogador = j.cod_jogador 
        WHERE (nota.ativo = 's' OR nota.ativo = '' OR nota.ativo IS NULL) 
          AND ci.cod_usuario = $cod_usuario
        ORDER BY inst.cod_instituicao, si.cod_subInstituicao, t.cod_turma, ci.nome
        ";

        if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
            return '';
        }

        $desc_instituicao    = $bd->SqlQueryShow('desc_instituicao');
        $desc_subInstituicao = $bd->SqlQueryShow('desc_subInstituicao');
        $desc_turma          = $bd->SqlQueryShow('desc_turma');
        $cod_usuario         = $bd->SqlQueryShow('cod_usuario');
        $nome                = $bd->SqlQueryShow('nome');
        $cpf                 = $bd->SqlQueryShow('cpf');
        $desc_municipio      = $bd->SqlQueryShow('desc_municipio');
        $desc_estado         = $bd->SqlQueryShow('desc_estado');
        $desc_nacao          = $bd->SqlQueryShow('desc_nacao');
        $data_nascimento     = $bd->SqlQueryShow('data_nascimento');
        $desc_posicao        = $bd->SqlQueryShow('desc_posicao');
        $desc_esporte        = $bd->SqlQueryShow('desc_esporte');
        $local_midia         = $bd->SqlQueryShow('local_midia');
        $email_usuario       = $bd->SqlQueryShow('email_usuario');
        $senha               = $bd->SqlQueryShow('senha');

        return '
        <div class="tab-pane fade show" id="dados-pessoais-' . $idModal . '" role="tabpanel" aria-labelledby="dados-pessoais-tab-' . $idModal . '">
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

            <hr>
            <h5>Dados de Login</h5>
            <p>Para atualizar a senha do seu login, digite a nova senha no campo da senha atual, clique no botão para prosseguir e confirme a alteração.</p>

            <div class="mb-3">
                <div class="row g-3 align-items-center">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Email Cadastrado</label>
                        <input type="text" class="form-control" value="' . $email_usuario . '" disabled>
                    </div>
                    <div class="col-md-6">
                        <label for="senha" class="form-label fw-semibold">Senha</label>
                        <div class="input-group">
                            <input type="password" class="form-control" value="' . $senha . '" id="senha" name="senha">
                            <button class="btn btn-outline-secondary" type="button" onclick="toggleSenha()">
                                <img src="../../img/icone/olho.png" width="15" height="15" alt="Mostrar senha">
                            </button>
                        </div>
                    </div>
                    <div class="col-md-2 mt-3">
                        <button type="button" onclick="modalMudarSenha(' . $cod_usuario . ')" class="btn btn-primary btn-sm">Modificar senha</button>
                    </div>
                </div>
            </div>
        </div>';
    }

    return ''; // segurança caso nenhum if seja executado
}


function conteudoFichaMedica($idModal, $cod_usuario, $ativa = false)
{
    $classeAtiva = $ativa ? 'show active' : '';

    $query = "
        SELECT 
            altura, peso, tipoSanguineo, alergias, 
            data_atualizacao, cod_jogador, restricoes_medicas
        FROM fichamedica 
        WHERE cod_jogador = $cod_usuario
    ";

    $bd = conecta();
    if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) return;

    // Valores da ficha médica
    $altura = $bd->SqlQueryShow('altura');
    $peso = $bd->SqlQueryShow('peso');
    $tipoSanguineo = $bd->SqlQueryShow('tipoSanguineo');
    $restricoes_medicas = $bd->SqlQueryShow('restricoes_medicas');
    $alergias = $bd->SqlQueryShow('alergias');

    // Início do HTML
    $retorno = '
    <div class="tab-pane fade ' . $classeAtiva . '" id="ficha-medica-' . $idModal . '" role="tabpanel" aria-labelledby="ficha-medica-tab-' . $idModal . '">
        <p class="mb-2">Para atualizar os dados da ficha médica, digite os novos dados e clique no botão para confirmar a alteração.</p>

        <div class="row mb-1">
            <div class="col-md-4">
                <label class="form-label">Altura:</label>
                <input type="text" id="altura" class="form-control" value="' . htmlspecialchars($altura) . '">
            </div>
            <div class="col-md-4">
                <label class="form-label">Peso:</label>
                <input type="text" id="peso" class="form-control" value="' . htmlspecialchars($peso) . '">
            </div>
            <div class="col-md-4">
                <label class="form-label">Alergias:</label>
                <input type="text" id="alergias" class="form-control" value="' . htmlspecialchars($alergias) . '">
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label">Tipo Sanguíneo:</label>
                <input disabled type="text" class="form-control" value="' . htmlspecialchars($tipoSanguineo) . '">
            </div>
            <div class="col-md-6">
                <label class="form-label">Restrições Médicas:</label>
                <input type="text" id="restricoesMedicas" class="form-control" value="' . htmlspecialchars($restricoes_medicas) . '">
            </div>
        </div>

        <div class="mb-3">
            <button type="button" onclick="modalMudarDadoFichaMedica(' . $cod_usuario . ')" class="btn btn-sm btn-success">Atualizar ficha</button>
        </div>
    ';

    // Histórico de Lesões
    $queryLesoes = "
        SELECT ti.desc_tipoLesao, hi.desc_lesao, hi.data_lesao, hi.tempoFora_lesao
        FROM fichaMedica_historicoLesoes fihi 
        INNER JOIN historicoLesoes hi ON fihi.cod_historicoLesoes = hi.cod_historicoLesoes
        INNER JOIN tipo_lesao ti ON ti.cod_tipoLesao = hi.cod_tipoLesao
        WHERE fihi.cod_jogador = $cod_usuario
    ";

    if ($bd->SqlExecuteQuery($queryLesoes) && $bd->SqlNumRows() > 0) {
        $retorno .= '<label class="form-label">Lesões:</label>';

        do {
            $desc_tipoLesao = $bd->SqlQueryShow('desc_tipoLesao');
            $desc_lesao = $bd->SqlQueryShow('desc_lesao');
            $data_lesao = $bd->SqlQueryShow('data_lesao');
            $tempoFora_lesao = $bd->SqlQueryShow('tempoFora_lesao');

            $retorno .= '
            <div class="card border rounded p-3 bg-light mb-2">
                <div class="row g-2 mb-2">
                    <div class="col-md-6">
                        <label class="form-label">Tipo de Lesão:</label>
                        <input disabled type="text" class="form-control" value="' . htmlspecialchars($desc_tipoLesao) . '">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Descrição da Lesão:</label>
                        <input disabled type="text" class="form-control" value="' . htmlspecialchars($desc_lesao) . '">
                    </div>
                </div>
                <div class="row g-2">
                    <div class="col-md-6">
                        <label class="form-label">Data da Lesão:</label>
                        <input disabled type="text" class="form-control" value="' . htmlspecialchars($data_lesao) . '">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tempo Fora:</label>
                        <input disabled type="text" class="form-control" value="' . htmlspecialchars($tempoFora_lesao) . '">
                    </div>
                </div>
            </div>';
        } while ($bd->SqlFetchNext());
    }

    $retorno .= '
        <div class="row mt-3">
            <div class="col-md-6">
                <button type="button" onclick="modalAtualizarLesoes(' . $cod_usuario . ')" class="btn btn-sm btn-success">Atualizar ficha</button>
            </div>
        </div>
    </div>'; 

    return $retorno;
}


function conteudoDadosResponsaveis($idModal, $cod_usuario)
{
    $bd = conecta();
    $retorno = '
    <div class="tab-pane fade" id="dados-responsaveis-' . $idModal . '" role="tabpanel" aria-labelledby="dados-responsaveis-tab-' . $idModal . '">';

    $query = "
SELECT b.cod_contatoResponsavel,b.nomeResponsavel,b.tipoFiliacao,b.emailResponsavel,b.telefoneResponsavel
FROM jogador_contatoResponsavel a
INNER JOIN contato_responsavel b ON b.cod_contatoResponsavel = a.cod_contatoResponsavel
WHERE a.cod_jogador =  $cod_usuario
    ";

    if ($bd->SqlExecuteQuery($query) && $bd->SqlNumRows() > 0) {
        $retorno .= '<label class="form-label mt-1">Responsavel:</label>';

        do {
            $cod_contatoResponsavel = $bd->SqlQueryShow('cod_contatoResponsavel');
            $nomeResponsavel = $bd->SqlQueryShow('nomeResponsavel');
            $tipoFiliacao = $bd->SqlQueryShow('tipoFiliacao');
            $emailResponsavel = $bd->SqlQueryShow('emailResponsavel');
            $telefoneResponsavel = $bd->SqlQueryShow('telefoneResponsavel');


            $retorno .= '
            <div class="card border rounded p-3 bg-light mb-2">
                <div class="row g-2 mb-2">
                    <div class="col-md-6">
                        <label class="form-label">Nome responsavel:</label>
                        <input disabled type="text" class="form-control" value="' . htmlspecialchars($nomeResponsavel) . '">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tipo de filiação:</label>
                        <input disabled type="text" class="form-control" value="' . htmlspecialchars($tipoFiliacao) . '">
                    </div>
                </div>
                <div class="row g-2">
                    <div class="col-md-6">
                        <label class="form-label">Email:</label>
                        <input disabled type="text" class="form-control" value="' . htmlspecialchars($emailResponsavel) . '">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Telefone:</label>
                        <input disabled type="text" class="form-control" value="' . htmlspecialchars($telefoneResponsavel) . '">
                    </div>
                </div>
           
                <div class="col-md-6 mt-3">
                <button type="button" onclick="modalRetirarResponsavel(' . $cod_contatoResponsavel . ')" class="btn btn-sm btn-danger">Retirar</button>

                </div>
            </div>';
        } while ($bd->SqlFetchNext());


        $retorno .= '
        <div class="row mt-3">
            <div class="col-md-6">
                <button type="button" onclick="modalAdicionarResponsavel(' . $cod_usuario . ')" class="btn btn-sm btn-success">Adicionar </button>
            </div>
        </div>';
    }

    // Fecha a tab-pane
    $retorno .= '</div>';

    return $retorno;
}


function conteudoMinhaNota($idModal, $cod_usuario)
{
    $bd = conecta();
    $retorno = '';

    $query = "
        SELECT jo.cod_jogador, noj.nota_jogador, noj.data_atualizacao, noj.ativo, cad.nome
        FROM jogador jo
        INNER JOIN nota_jogador noj ON noj.cod_jogador = jo.cod_jogador
        INNER JOIN staff st ON st.cod_staff = noj.cod_staff
        INNER JOIN cadastro_identificacao cad ON cad.cod_usuario = st.cod_staff
        WHERE noj.cod_jogador = $cod_usuario
        ORDER BY noj.ativo DESC, noj.data_atualizacao DESC
    ";

    $bd->SqlExecuteQuery($query);

    $retorno .= '
    <div class="tab-pane fade" id="minha-nota-' . $idModal . '" role="tabpanel" aria-labelledby="minha-nota-tab-' . $idModal . '">
      <label class="form-label">Nota atual:</label>
      <div id="nota-atual-container">
    ';

    $temNotaAtual = false;
    $retornoNotasAnteriores = '';

    do {
        $nota_jogador = $bd->SqlQueryShow('nota_jogador');
        $data_atualizacao = $bd->SqlQueryShow('data_atualizacao');
        $nome = $bd->SqlQueryShow('nome');
        $ativo = $bd->SqlQueryShow('ativo');

        if ($ativo === 's') {
            $temNotaAtual = true;
            $retorno .= '
            <div class="responsavel card border rounded p-3 bg-light mb-3">
              <div class="row g-2 mb-2">
                <div class="col-md-12">Nota atual:
                  <input disabled type="text" class="form-control" value="' . $nota_jogador . '">
                </div>
              </div>
              <div class="row g-2">
                <div class="col-md-6">Inserido por:
                  <input disabled type="text" class="form-control" value="' . $nome . '">
                </div>
                <div class="col-md-6">Data de atualização:
                  <input disabled type="text" class="form-control" value="' . formatarDataHora($data_atualizacao) . '">
                </div>
              </div>
            </div>';
        } else {
            // Acumula as notas anteriores
            $retornoNotasAnteriores .= '
            <div class="responsavel card border rounded p-2 bg-light mb-3">
              <div class="row g-2 mb-2">
                <div class="col-md-12">Nota anterior:
                  <input disabled type="text" class="form-control" value="' . $nota_jogador . '">
                </div>
              </div>
              <div class="row g-2">
                <div class="col-md-6">Inserido por:
                  <input disabled type="text" class="form-control" value="' . $nome . '">
                </div>
                <div class="col-md-6">Data de atualização:
                  <input disabled type="text" class="form-control" value="' . formatarDataHora($data_atualizacao) . '">
                </div>
              </div>
            </div>';
        }
    } while ($bd->SqlFetchNext());

    // Adiciona bloco de notas anteriores (se houver)
    if (!empty($retornoNotasAnteriores)) {
        $retorno .= '<hr><label class="form-label">Notas anteriores:</label>';
        $retorno .= $retornoNotasAnteriores;
    }

    $retorno .= '
      </div>
    </div>'; // Fecha a tab-pane

    return $retorno;
}



function conteudoNotasTreino($idModal, $cod_usuario,$cod_tipoRole)
{
    if($cod_tipoRole==6){

    $query='
    select * from treino_jogador a
    inner join treino b on b.cod_treino = a.cod_treino
    inner join  notatreino_jogador c on c.cod_treino = b.cod_treino
    where a.cod_jogador='.$cod_usuario.' and cod_grau_privacidade=3
    ';

    }
    else{
    return '
    <div class="tab-pane fade" id="notas-treino-' . $idModal . '" role="tabpanel" aria-labelledby="notas-treino-tab-' . $idModal . '">
        <p>Conteúdo da Aba Notas de Treino '.$cod_tipoRole.'</p>
    </div>';

    }
}


// ---------------------
function navADMI($idModal)
{
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="dados-ADMI-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-admi-' . $idModal . '" type="button" role="tab" aria-controls="dados-admi-' . $idModal . '" aria-selected="true">Dados admi</button>
    </li>';
}

function conteudoADMI($idModal, $cod_usuario): string
{
    $query = "
    SELECT a.nome, a.cpf, b.email_usuario, b.senha,d.desc_instituicao
    FROM cadastro_identificacao a
    INNER JOIN login_usuario b ON a.cod_usuario = b.cod_usuario 
    INNER JOIN administrador_instituicao c ON a.cod_usuario = c.cod_administrador
    inner join instituicao d on  d.cod_instituicao = c.cod_instituicao
    WHERE a.cod_usuario = $cod_usuario
    ";


    $bd = conecta();
    if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
        return '';
    }

    $desc_instituicao = $bd->SqlQueryShow('desc_instituicao');
    $nome = $bd->SqlQueryShow('nome');
    $cpf = $bd->SqlQueryShow('cpf');

    $email_usuario = $bd->SqlQueryShow('email_usuario');
    $senha = $bd->SqlQueryShow('senha');

    return '
    <div class="tab-pane fade show active" id="dados-admi-' . $idModal . '" role="tabpanel" aria-labelledby="dados-admi-tab-' . $idModal . '">
        <div class="mb-">
            <div class="row g-3 align-items-center">
                <div class="col-md-5">
                    <label for="nome-' . $idModal . '" class="form-label fw-semibold">Nome</label>
                    <input type="text" id="nome-' . $idModal . '" class="form-control" value="' . htmlspecialchars($nome) . '" disabled>
                </div>
                <div class="col-md-3">
                    <label for="cpf-' . $idModal . '" class="form-label fw-semibold">CPF</label>
                    <input type="text" id="cpf-' . $idModal . '" class="form-control" value="' . formatarCPF($cpf) . '" disabled>
                </div>
                <div class="col-md-4">
                    <label for="nome-' . $idModal . '" class="form-label fw-semibold">Pertence a instituição:</label>
                    <input type="text" id="nome-' . $idModal . '" class="form-control" value="' . htmlspecialchars($desc_instituicao) . '" disabled>
                </div>

            </div>
        </div>
        <hr>
<h5>Dados de Login </h5>  
<p>Para atualizar a senha do seu login, digite a nova senha no campo da senha atual, clique no botão para prosseguir e confirme a alteração.</p>
<div class="mb-3">
    <div class="row g-3 align-items-center">
        <div class="col-md-6">
            <label for="nome-<?php echo $idModal; ?>" class="form-label fw-semibold">Email Cadastrado</label>
            <input type="text"  class="form-control" value="' . $email_usuario . '" disabled>
        </div>

        <div class="col-md-6">
            <label for="senha" class="form-label fw-semibold">Senha</label>
            <div class="input-group">
                <input type="password" class="form-control" value="' . $senha . '" id="senha" name="senha">
                <button class="btn btn-outline-secondary" type="button" onclick="toggleSenha()">
                    <img src="../../img/icone/olho.png" width="15" height="15" alt="Mostrar senha">
                </button>
            </div>
        </div>
    </div>
</div>

                <div class="col-md-2">
                <button type="button" onclick="modalMudarSenha(' . $cod_usuario . ')" class="btn btn-primary btn-sm">Modificar senha</button>
                </div>
         </div>
        </div> 
        


    </div>';

}

function navAdmsStaff($idModal)
{
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="dados-dmsStaff-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-dmsStaff-' . $idModal . '" type="button" role="tab" aria-controls="dados-dmsStaff-' . $idModal . '" aria-selected="true">Dados Admistrador e staff</button>
    </li>';
}

function conteudoAdmsStaff($idModal, $cod_usuario): string
{
    $query = "
    SELECT 
    a.cod_usuario ,a.nome, a.cpf, b.email_usuario, b.senha,e.desc_instituicao,d.desc_subInstituicao
    FROM cadastro_identificacao a
	INNER JOIN login_usuario b ON a.cod_usuario = b.cod_usuario 
	INNER JOIN administrador_subinstituicao c ON a.cod_usuario = c.cod_administrador
    inner join subinstituicao d on d.cod_subInstituicao = c.cod_subInstituicao
    inner join instituicao e on e.cod_instituicao = d.cod_instituicao
    WHERE a.cod_usuario = $cod_usuario
    ";

// -- return $query;

    $bd = conecta();
    if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
        return '';
    }

    $desc_subInstituicao = $bd->SqlQueryShow('desc_subInstituicao');
    $desc_instituicao = $bd->SqlQueryShow('desc_instituicao');
    $nome = $bd->SqlQueryShow('nome');
    $cpf = $bd->SqlQueryShow('cpf');
    $email_usuario = $bd->SqlQueryShow('email_usuario');
    $senha = $bd->SqlQueryShow('senha');

    $query2="
    SELECT 
    g.desc_turma
    FROM cadastro_identificacao a
    inner JOIN staff sta on sta.cod_staff = a.cod_usuario
    inner JOIN staff_turma f on f.cod_staff = sta.cod_staff
    inner join turma g on f.cod_turma = g.cod_turma
    WHERE a.cod_usuario = 10
    ";

    if (!$bd->SqlExecuteQuery($query2) || $bd->SqlNumRows() <= 0) {
        return '';
    }

    $turmasArray = [];

    do {
        $desc_turma = $bd->SqlQueryShow('desc_turma');
        $turmasArray[] = $desc_turma;
    }while($bd->SqlFetchNext());

    $turmasString = is_array($turmasArray) ? implode(' | ', $turmasArray) : $turmasArray;


    return '
    <div class="tab-pane fade show active" id="dados-dmsStaff-' . $idModal . '" role="tabpanel" aria-labelledby="dados-dmsStaff-tab-' . $idModal . '">
        <div class="mb-">
            <div class="row g-3 align-items-center">
                <div class="col-md-8">
                    <label for="nome-' . $idModal . '" class="form-label fw-semibold">Nome</label>
                    <input type="text" id="nome-' . $idModal . '" class="form-control" value="' . htmlspecialchars($nome) . '" disabled>
                </div>
                <div class="col-md-4">
                    <label for="cpf-' . $idModal . '" class="form-label fw-semibold">CPF</label>
                    <input type="text" id="cpf-' . $idModal . '" class="form-control" value="' . formatarCPF($cpf) . '" disabled>
                </div>
                <div class="col-md-6">
                    <label for="nome-' . $idModal . '" class="form-label fw-semibold">Pertence a instituição:</label>
                    <input type="text" id="nome-' . $idModal . '" class="form-control" value="' . htmlspecialchars($desc_instituicao) . '" disabled>
                </div>
                <div class="col-md-6">
                    <label for="nome-' . $idModal . '" class="form-label fw-semibold">Sub-Instituição:</label>
                    <input type="text" id="nome-' . $idModal . '" class="form-control" value="' . htmlspecialchars($desc_subInstituicao) . '" disabled>
                </div>
                <div class="col-md-12">
                    <label for="nome-' . $idModal . '" class="form-label fw-semibold">Turmas:</label>
                    <input type="text" id="nome-' . $idModal . '" class="form-control" value="' . $turmasString . '" disabled>
                </div>
            </div>
        </div>
        <hr>
<h5>Dados de Login </h5>  
<p>Para atualizar a senha do seu login, digite a nova senha no campo da senha atual, clique no botão para prosseguir e confirme a alteração.</p>
<div class="mb-3">
    <div class="row g-3 align-items-center">
        <div class="col-md-6">
            <label  class="form-label fw-semibold">Email Cadastrado</label>
            <input type="text"  class="form-control" value="' . $email_usuario . '" disabled>
        </div>

        <div class="col-md-6">
            <label for="senha" class="form-label fw-semibold">Senha</label>
            <div class="input-group">
                <input type="password" class="form-control" value="' . $senha . '" id="senha" name="senha">
                <button class="btn btn-outline-secondary" type="button" onclick="toggleSenha()">
                    <img src="../../img/icone/olho.png" width="15" height="15" alt="Mostrar senha">
                </button>
            </div>
        </div>
    </div>
</div>
                <div class="col-md-2">
                <button type="button" onclick="modalMudarSenha(' . $cod_usuario . ')" class="btn btn-primary btn-sm">Modificar senha</button>
                </div>
         </div>
        </div> 
    </div>';
}

$retorno .= '<ul class="nav nav-tabs" id="abas" role="tablist">';

// Navegação por tipo de usuário
if ($cod_tipoRole == 1) { // TI
    $retorno .= navTI($idModal);

} elseif ($cod_tipoRole == 2) { // ADMI
    $retorno .= navADMI($idModal);

} elseif ($cod_tipoRole == 3) { // ADMS
    $retorno .= navADMS($idModal);

} elseif ($cod_tipoRole == 4 || $cod_tipoRole == 5) { // ADMS e STAFF
    $retorno .= navAdmsStaff($idModal);

// Jogador
} elseif ($cod_tipoRole == 6) {
    $retorno .= navDadosPessoais($idModal);
    $retorno .= navFichaMedica($idModal);
    $retorno .= navDadosResponsaveis($idModal);
    $retorno .= navMinhaNota($idModal);
    $retorno .= navNotasTreino($idModal);

// Tipo inválido
} else {
    $retorno .= '<li class="nav-item"><span class="text-danger">Tipo de usuário inválido</span></li>';
}

$retorno .= '</ul>'; // Fecha nav-tabs
$retorno .= '<div class="tab-content mt-3" id="conteudoDasAbas">';



if ($cod_tipoRole == 1) {
    $retorno .= conteudoTI($idModal, $cod_usuario);
} elseif ($cod_tipoRole == 2) {
    $retorno .= conteudoadmi($idModal, $cod_usuario);
} elseif ($cod_tipoRole == 3) {
    $retorno .= conteudoadms($idModal, $cod_usuario);
 
} elseif ($cod_tipoRole == 4 || $cod_tipoRole == 5) {
    $retorno .= conteudoAdmsStaff($idModal, $cod_usuario);
} 
// elseif ($cod_tipoRole == 5) {
//     $retorno .= conteudoDadosPessoais($idModal, $cod_tipoRole, $cod_usuario);
//     $retorno .= conteudoDadosLogin($idModal);
//     $retorno .= conteudoMinhasInstituicoes($idModal);
//     $retorno .= conteudoMinhasTurmas($idModal);
// }
elseif ($cod_tipoRole == 6) {
    $retorno .= conteudoDadosResponsaveis($idModal,$cod_usuario);
    $retorno .= conteudoMinhaNota($idModal,$cod_usuario);
    $retorno .= conteudoNotasTreino($idModal, $cod_usuario,$cod_tipoRole);
    $retorno .= conteudoDadosPessoais($idModal, $cod_tipoRole, $cod_usuario);
    $retorno .= conteudoFichaMedica($idModal,$cod_usuario);
}




$bd->SqlDisconnect();
exit($retorno);
