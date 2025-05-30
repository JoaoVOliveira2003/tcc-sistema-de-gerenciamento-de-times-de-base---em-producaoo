<?php
require('../../include/conecta.php');
$bd = conecta();

$cod_pessoa = getPost('codPessoa');
$emailPessoa = getPost('emailPessoa');

$retorno = [
    'status' => '',
];

$query = "SELECT count(*) FROM cadastro_identificacao WHERE cod_usuario = " . $cod_pessoa;

if ($bd->SqlExecuteQuery($query)) {

    $existePessoa = $bd->SqlQueryShow('count(*)');

    if ($existePessoa > 0) {

        $query = "SELECT ativo FROM cadastro_identificacao WHERE cod_usuario = " . $cod_pessoa;

        if ($bd->SqlExecuteQuery($query)) {
            $ativo = $bd->SqlQueryShow('ativo');

            if ($ativo == 'n') {
              $query = "SELECT ci.nome, ci.cpf, ci.ativo, mun.desc_municipio, est.desc_estado, nac.desc_nacao,ins.desc_instituicao
                        FROM cadastro_identificacao ci
                        INNER JOIN municipio mun ON mun.cod_municipio = ci.cod_municipio
                        INNER JOIN estado est ON mun.cod_estado = est.cod_estado
                        INNER JOIN nacao nac ON nac.cod_nacao = est.cod_nacao
                        inner join administrador_instituicao admins on ci.cod_usuario = admins.cod_administrador
                        inner join instituicao ins on ins.cod_instituicao = admins.cod_instituicao
                        WHERE ci.cod_usuario = " . $cod_pessoa;

                
                if ($bd->SqlExecuteQuery($query)) {
                    $retorno = [
                        'status' => 'ok',
                        'nome' => $bd->SqlQueryShow('nome'),
                        'cpf' => $bd->SqlQueryShow('cpf'),
                        'municipio' => $bd->SqlQueryShow('desc_municipio'),
                        'estado' => $bd->SqlQueryShow('desc_estado'),
                        'nacao' => $bd->SqlQueryShow('desc_nacao'),
                        'instituicao' => $bd->SqlQueryShow('desc_instituicao'),  
                        'emailPessoa'=> $emailPessoa
                    ];
                } else {
                    $retorno['status'] = 'nok1'; // Erro na consulta de dados
                }
            } else {
                $retorno['status'] = 'nok3'; // Cadastro já confirmado
            }
        } else {
            $retorno['status'] = 'nok1'; // Erro ao buscar "ativo"
        }
    } else {
        $retorno['status'] = 'nok2'; // Pessoa não existe
    }
} else {
    $retorno['status'] = 'nok1'; // Erro na consulta inicial
}

$bd->SqlDisconnect();

echo(json_encode($retorno));
