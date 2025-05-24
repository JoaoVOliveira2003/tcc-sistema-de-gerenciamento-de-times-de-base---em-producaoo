<?php
require('../../../include/conecta.php');
require('../../Email/EnviarGmail.php');
$retorno = 'ok';

$bd = conecta();

$cod_role = 6;
$municipio = getPost('municipio');
$nome = getPost('nome');
$email = getPost('email');
$cpf = getPost('cpf');
$posicao = getPost('posicao');
$data_nascimento = getPost('data_nascimento');
$esporte = getPost('esporte');
$altura = getPost('altura');
$peso = getPost('peso');
$tipo_sanguineo = getPost('tipo_sanguineo');
$restricoes_medicas = getPost('restricoes_medicas');
$alergias = getPost('alergias');
$responsaveis = json_decode(getPost('responsaveis'), true);
$lesoes = json_decode(getPost('lesoes'), true);
$cod_turma = getPost('turma');

$emailBase = 'ojoao953@gmail.com';
$query = "SELECT COUNT(*) FROM login_usuario WHERE email_usuario = '$email'";
if ($bd->SqlExecuteQuery($query)) {
    $count = $bd->SqlQueryShow("COUNT(*)");
    if ($count > 0 && $email != $emailBase) {
        $retorno = 'emailJaCadastrado';
        $bd->SqlDisconnect();
        exit($retorno);
    }
}

if (!isset($_FILES['imagemJogador'])) {
    exit('nok-sem-imagem');
}

// Processa a imagem
$tmp = $_FILES['imagemJogador']['tmp_name'];
$nomeOriginal = pathinfo($_FILES['imagemJogador']['name'], PATHINFO_FILENAME);
$extensao = pathinfo($_FILES['imagemJogador']['name'], PATHINFO_EXTENSION);
$nomeImagem = substr(str_shuffle('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'), 0, 4) . '_' . $nomeOriginal . '.' . $extensao;
$pasta = '../../../img/jogador/';
$destino = $pasta . $nomeImagem;

// 1. cadastro_identificacao
$query1 = "INSERT INTO cadastro_identificacao (nome, cpf, cod_municipio, ativo) VALUES ('$nome', '$cpf', '$municipio', 'n')";
if ($bd->SqlExecuteQuery($query1)) {
    $cod_pessoa = $bd->getLastInsertId();

    // 2. role_cadastro
    $query2 = "INSERT INTO role_cadastro (cod_usuario, cod_tipoRole) VALUES ($cod_pessoa, $cod_role)";
    if ($bd->SqlExecuteQuery($query2)) {

        // 3. cadastro_jogador
        $query3 = "INSERT INTO jogador (cod_jogador, data_nascimento, posicao, esporte) VALUES ($cod_pessoa, '$data_nascimento', $posicao, $esporte)";
        if ($bd->SqlExecuteQuery($query3)) {

            // 4. turma_jogador
            $query4 = "INSERT INTO turma_jogador (cod_turma, cod_jogador) VALUES ($cod_turma, $cod_pessoa)";
            if ($bd->SqlExecuteQuery($query4)) {

                // 5. Upload da imagem e midia_jogador
                if (move_uploaded_file($tmp, $destino)) {
                    $query5 = "INSERT INTO midia_jogador (cod_jogador, local_midia) VALUES ($cod_pessoa, '$nomeImagem')";
                    if ($bd->SqlExecuteQuery($query5)) {

                        // 6. fichaMedica
                        $query6 = "INSERT INTO fichaMedica (cod_jogador, altura, peso, tipoSanguineo, restricoes_medicas, alergias, data_atualizacao) 
                                   VALUES ($cod_pessoa, $altura, $peso, '$tipo_sanguineo', '$restricoes_medicas', '$alergias', NOW())";
                        if ($bd->SqlExecuteQuery($query6)) {

                            // 7. contato_responsavel e jogador_contatoResponsavel
                            foreach ($responsaveis as $resp) {
                                $nomeR = $resp['nome'];
                                $filiacao = $resp['filiacao'];
                                $emailR = $resp['email'];
                                $telefone = preg_replace('/\D/', '', $resp['telefone']);

                                $queryResp = "INSERT INTO contato_responsavel (nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel) 
                                              VALUES ('$nomeR', '$filiacao', '$emailR', '$telefone')";
                                            if ($bd->SqlExecuteQuery($queryResp)) {
                                    $cod_contatoResp = $bd->getLastInsertId();

                                    $queryVinculo = "INSERT INTO jogador_contatoResponsavel (cod_jogador, cod_contatoResponsavel) 
                                                     VALUES ($cod_pessoa, $cod_contatoResp)";
                                    if (!$bd->SqlExecuteQuery($queryVinculo)) {
                                        $retorno = 'nok-erro query 7b';
                                        break;
                                    }
                                } else {
                                    $retorno = 'nok-erro query 7a';
                                    break;
                                }
                            }

                            // 8. historicoLesoes e fichaMedica_historicoLesoes
                            if ($retorno === 'ok') {
                                foreach ($lesoes as $lesao) {
                                    $tipo = $lesao['tipoLesao'];
                                    $data = $lesao['dataLesao'];
                                    $tempo = $lesao['tempoFora'];
                                    $desc = $lesao['descLesao'];

                                    $queryLesao = "INSERT INTO historicoLesoes (cod_tipoLesao, desc_lesao, data_lesao, tempoFora_lesao) 
                                                   VALUES ($tipo, '$desc', '$data', '$tempo')";
                                    if ($bd->SqlExecuteQuery($queryLesao)) {
                                        $cod_lesao = $bd->getLastInsertId();
                                        $queryVinculoLesao = "INSERT INTO fichaMedica_historicoLesoes (cod_jogador, cod_historicoLesoes) 
                                                              VALUES ($cod_pessoa, $cod_lesao)";
                                        if (!$bd->SqlExecuteQuery($queryVinculoLesao)) {
                                            $retorno = 'nok-erro query 8b';
                                            break;
                                        }
                                    } else {
                                        $retorno = 'nok-erro query 8a';
                                        break;
                                    }
                                }
                            }

                        } else {
                            $retorno = 'nok-erro query 6'; // fichaMedica
                        }

                    } else {
                        $retorno = 'nok-erro query 5'; // midia_jogador
                    }

                } else {
                    $retorno = 'nok-erro upload imagem';
                }

            } else {
                $retorno = 'nok-erro query 4'; // turma_jogador
            }

        } else {
            $retorno = 'nok-erro query 3'; // cadastro_jogador
        }

    } else {
        $retorno = 'nok-erro query 2'; // role_cadastro
    }

} else {
    $retorno = 'nok-erro query 1'; // cadastro_identificacao
}

// Se tudo ocorreu bem, envia o e-mail
                $query = "INSERT INTO login_usuario (email_usuario, cod_usuario) VALUES ('$email', $cod_pessoa)";
                if ($bd->SqlExecuteQuery($query)) {
                    enviarGmail($email, $nome, $cod_role, $cod_pessoa);
                    $retorno = 'ok';
                } else {
                    $retorno = 'nok';
                }
// Resposta final
exit($retorno);
?>
