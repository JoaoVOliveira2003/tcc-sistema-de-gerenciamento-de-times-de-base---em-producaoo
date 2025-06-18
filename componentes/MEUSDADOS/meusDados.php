<?php
require('../../include/conecta.php');
$bd = conecta();
$cod_usuario =  18;
$cod_tipoRole = 6;

//$cod_usuario  = getPost('cod_usuario');
//$cod_tipoRole = getPost('cod_tipoRole');

$idModal = "modalDadosPessoa";
$retorno = '';

// Funções de navegação

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
// ------------------
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

function conteudoDadosPessoais($idModal, $cod_tipoRole, $cod_usuario)
{
    if ($cod_tipoRole == 1) {
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
    } else if ($cod_tipoRole == 2) {
    } else if ($cod_tipoRole == 3) {
    } else if ($cod_tipoRole == 4) {
    } else if ($cod_tipoRole == 5) {
    } else if ($cod_tipoRole == 6) {

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

function conteudoFichaMedica($idModal)
{
    return '
    <div class="tab-pane fade" id="ficha-medica-' . $idModal . '" role="tabpanel" aria-labelledby="ficha-medica-tab-' . $idModal . '">
        <p>Conteúdo da Aba Ficha Médica</p>
    </div>';
}

function conteudoDadosResponsaveis($idModal)
{
    return '
    <div class="tab-pane fade" id="dados-responsaveis-' . $idModal . '" role="tabpanel" aria-labelledby="dados-responsaveis-tab-' . $idModal . '">
        <p>Conteúdo da Aba Responsáveis</p>
    </div>';
}

function conteudoMinhaNota($idModal)
{
    return '
    <div class="tab-pane fade" id="minha-nota-' . $idModal . '" role="tabpanel" aria-labelledby="minha-nota-tab-' . $idModal . '">
        <p>Conteúdo da Aba Minha Nota</p>
    </div>';
}

function conteudoNotasTreino($idModal)
{
    return '
    <div class="tab-pane fade" id="notas-treino-' . $idModal . '" role="tabpanel" aria-labelledby="notas-treino-tab-' . $idModal . '">
        <p>Conteúdo da Aba Notas de Treino</p>
    </div>';
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

// ---------------------

function navAdmsStaff($idModal)
{
    return '
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="dados-dmsStaff-tab-' . $idModal . '" data-bs-toggle="tab" data-bs-target="#dados-dmsStaff-' . $idModal . '" type="button" role="tab" aria-controls="dados-dmsStaff-' . $idModal . '" aria-selected="true">Dados dmsStaff</button>
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



// Montagem HTML conforme role
$retorno .= '<ul class="nav nav-tabs" id="abas" role="tablist">';
//aqui
if ($cod_tipoRole == 1) { // TI
    $retorno .= navTI($idModal);
} elseif ($cod_tipoRole == 2) { // ADMI
    $retorno .= navADMI($idModal);

} elseif ($cod_tipoRole == 3) { // ADMS
    $retorno .= navADMS($idModal);

} elseif ($cod_tipoRole == 4 || $cod_tipoRole == 5) { // ADMS e STAFF 
    $retorno .= navAdmsStaff($idModal);

} 
// elseif ($cod_tipoRole == 5) { // STAFF
//     $retorno .= navDadosPessoais($idModal);
//     $retorno .= navDadosLogin($idModal);
//     $retorno .= navMinhasInstituicoes($idModal);
//     $retorno .= navMinhasTurmas($idModal);
// }
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
    $retorno .= conteudoTI($idModal, $cod_usuario);
} elseif ($cod_tipoRole == 2) {
    $retorno .= conteudoadmi($idModal, $cod_usuario);
} elseif ($cod_tipoRole == 3) {
    $retorno .= conteudoadms($idModal, $cod_usuario);
 
} elseif ($cod_tipoRole == 4 || $cod_tipoRole == 5) {
    $retorno .= conteudoAdmsStaff($idModal, $cod_usuario);
    // $retorno .= conteudoDadosPessoais($idModal, $cod_tipoRole, $cod_usuario);
    // $retorno .= conteudoDadosLogin($idModal);
    // $retorno .= conteudoMinhasInstituicoes($idModal);
    // $retorno .= conteudoMinhasTurmas($idModal);
} 
// elseif ($cod_tipoRole == 5) {
//     $retorno .= conteudoDadosPessoais($idModal, $cod_tipoRole, $cod_usuario);
//     $retorno .= conteudoDadosLogin($idModal);
//     $retorno .= conteudoMinhasInstituicoes($idModal);
//     $retorno .= conteudoMinhasTurmas($idModal);

// }
 elseif ($cod_tipoRole == 6) {
    $retorno .= conteudoDadosPessoais($idModal, $cod_tipoRole, $cod_usuario);
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
