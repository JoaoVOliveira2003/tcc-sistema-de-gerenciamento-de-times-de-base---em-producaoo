<?php
require('../../include/conecta.php');
$bd = conecta();

$cod_pessoa = getPost('codPessoa');
$emailPessoa = getPost('emailPessoa');

$retorno = ['status' => ''];

// Consulta para verificar se o usuário existe
$query = "SELECT count(*) FROM cadastro_identificacao WHERE cod_usuario = {$cod_pessoa}";

if ($bd->SqlExecuteQuery($query)) {

    $existePessoa = $bd->SqlQueryShow('count(*)');

    if ($existePessoa > 0) {

        // Consulta para verificar se o cadastro está ativo
        $query = "SELECT ativo FROM cadastro_identificacao WHERE cod_usuario = {$cod_pessoa}";

        if ($bd->SqlExecuteQuery($query)) {

            $ativo = $bd->SqlQueryShow('ativo');

            // Se cadastro NÃO está ativo (ativo = 'n'), prosseguir
            if ($ativo == 'n') {

                // Consulta detalhada dos dados do usuário e relacionamentos
                $query = "
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
                        t.desc_turma,
                        si.desc_subInstituicao,
                        hl.desc_lesao,
                        hl.data_lesao,
                        hl.tempoFora_lesao
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
                    WHERE ci.cod_usuario = {$cod_pessoa}
                ";

                $dadosResponsaveis = '';
                $idsDosResponsaveis = [];

                $query2 = "SELECT cod_contatoResponsavel FROM jogador_contatoResponsavel WHERE cod_jogador = {$cod_pessoa}";

                if ($bd->SqlExecuteQuery($query2)) {
                    do {
                        $valor = $bd->SqlQueryShow('cod_contatoResponsavel');
                        $idsDosResponsaveis[] = $valor;
                    } while ($bd->SqlFetchNext());
                }

                // Para cada responsável, buscar seus dados e montar o HTML
                foreach ($idsDosResponsaveis as $idResponsavel) {
                    $query3 = "SELECT nomeResponsavel, tipoFiliacao, emailResponsavel, telefoneResponsavel 
                                   FROM contato_responsavel 
                                   WHERE cod_contatoResponsavel = {$idResponsavel}";



                    if ($bd->SqlExecuteQuery($query3)) {

                        $nomeResponsavel = $bd->SqlQueryShow('nomeResponsavel');
                        $tipoFiliacao = $bd->SqlQueryShow('tipoFiliacao');
                        $emailResponsavel = $bd->SqlQueryShow('emailResponsavel');
                        $telefoneResponsavel = $bd->SqlQueryShow('telefoneResponsavel');

                        $dadosResponsaveis .= "
                                            <div class='responsavel card mb-3 border rounded p-3 bg-light'>
                                            <div class='mb-2 pb-2'><strong>Responsável</strong></div>

                                            <div class='row g-2 mb-2'>
                                                <div class='col-md-6 mb-1'>
                                                <label class='form-label'>Nome do responsável:</label>
                                                <input type='text' class='form-control' value='{$nomeResponsavel}' disabled>
                                                </div>
                                                <div class='col-md-6 mb-1'>
                                                <label class='form-label'>Tipo de filiação:</label>
                                                <input type='text' class='form-control' value='{$tipoFiliacao}' disabled>
                                                </div>
                                            </div>

                                            <div class='row g-2 mb-2'>
                                                <div class='col-md-6 mb-1'>
                                                <label class='form-label'>Email do responsável:</label>
                                                <input type='text' class='form-control' value='{$emailResponsavel}' disabled>
                                                </div>
                                                <div class='col-md-6 mb-1'>
                                                <label class='form-label'>Telefone do responsável:</label>
                                                <input type='text' class='form-control' value='{$telefoneResponsavel}' disabled>
                                                </div> 
                                            </div>
                                            </div>";

                    }
                }


                $dadosLesoes = '';
                $idsDasLesoes = [];

                $query4 = "SELECT Cod_HistoricoLesoes FROM fichaMedica_historicoLesoes WHERE cod_jogador = {$cod_pessoa}";

                if ($bd->SqlExecuteQuery($query4)) {
                    do {
                        $valor = $bd->SqlQueryShow('Cod_HistoricoLesoes');
                        $idsDasLesoes[] = $valor;
                    } while ($bd->SqlFetchNext());
                }


                foreach ($idsDasLesoes as $idLesao) {
                    $query5 = "select his.desc_lesao,his.data_lesao,his.tempoFora_lesao,tip.desc_tipoLesao from historicoLesoes his 
                    inner join tipo_lesao tip on tip.cod_tipoLesao = his.cod_tipoLesao where Cod_HistoricoLesoes = {$idLesao}";

                    if ($bd->SqlExecuteQuery($query5)) {

                        $descLesao = $bd->SqlQueryShow('desc_lesao');
                        $dataLesaoBruta = $bd->SqlQueryShow('data_lesao');
                        $dataLesao = (!empty($dataLesaoBruta) && $dataLesaoBruta !== '---')
                            ? date('d/m/Y', strtotime($dataLesaoBruta))
                            : '';
                        $tempoForaLesao = $bd->SqlQueryShow('tempoFora_lesao');
                        $tipoLesao = $bd->SqlQueryShow('desc_tipoLesao');

                        $dadosLesoes .= "
                        <div class='responsavel card mb-3 border rounded p-3 bg-light'>
                        <div class='mb-3 pb-2'><strong>Dados da lesão</strong></div>
                        <div class='row g-2 mb-2'>
                            <div class='col-md-6 mb-2'>
                            <label for='tipo_lesao' class='form-label'>Tipo de lesão:</label>
                            <input type='text' class='form-control' value='$tipoLesao' disabled   >
                            </div>
                            <div class='col-md-6 mb-2'>
                            <label for='tempo_fora' class='form-label'>Tempo fora:</label>
                            <input type='text' class='form-control' value='$tempoForaLesao' disabled   >
                            </div>
                        </div>
                        <div class='row g-2 mb-2'>
                            <div class='col-md-6 mb-2'>
                            <label for='descricao_lesao' class='form-label'>Descrição da lesão:</label>
                            <input type='text' class='form-control' value='$descLesao'   disabled  >
                            </div>
                            <div class='col-md-6 mb-2'>
                            <label for='data_lesao' class='form-label'>Data da lesão:</label>
                            <input type='text' class='form-control' value='$dataLesao'   disabled >
                            </div>
                        </div>
                        </div>";
                    }
                }
                
                if ($bd->SqlExecuteQuery($query)) {
                    // Montar o array de retorno com os dados buscados
                    $retorno = [
                        'status' => 'ok',
                        'dadosResponsaveis' => $dadosResponsaveis,
                        'dadosLesoes' => $dadosLesoes,
                        'nome' => $bd->SqlQueryShow('nome'),
                        'cpf' => $bd->SqlQueryShow('cpf'),
                        'municipio' => $bd->SqlQueryShow('desc_municipio'),
                        'estado' => $bd->SqlQueryShow('desc_estado'),
                        'nacao' => $bd->SqlQueryShow('desc_nacao'),
                        'data_nascimento' => $bd->SqlQueryShow('data_nascimento'),
                        'posicao' => $bd->SqlQueryShow('desc_posicao'),
                        'cod_esporte' => $bd->SqlQueryShow('desc_esporte'),
                        'altura' => $bd->SqlQueryShow('altura'),
                        'peso' => $bd->SqlQueryShow('peso'),
                        'tipo_sanguineo' => $bd->SqlQueryShow('tipoSanguineo'),
                        'restricoes_medicas' => $bd->SqlQueryShow('restricoes_medicas'),
                        'alergias' => $bd->SqlQueryShow('alergias'),
                        'turma' => $bd->SqlQueryShow('desc_turma'),
                        'instituicao' => $bd->SqlQueryShow('desc_subInstituicao'),
                        'emailPessoa' => $emailPessoa,
                        'localImagem' => '../../img/jogador/' . $bd->SqlQueryShow('local_midia'),
                    ];

                } else {
                    $retorno['status'] = 'nok1'; // Erro na consulta detalhada
                }

            } else {
                $retorno['status'] = 'nok3'; // Cadastro já confirmado (ativo != 'n')
            }

        } else {
            $retorno['status'] = 'nok1'; // Erro ao buscar status "ativo"
        }

    } else {
        $retorno['status'] = 'nok2'; // Pessoa não existe
    }

} else {
    $retorno['status'] = 'nok1'; // Erro na consulta inicial
}

$bd->SqlDisconnect();

echo json_encode($retorno);
