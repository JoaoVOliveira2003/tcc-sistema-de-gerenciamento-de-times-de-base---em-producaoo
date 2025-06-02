<?php
require('../../../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod_estado   = getPost('cod_estado');
$idModal      = getPost('idModal');
$tituloModal  = getPost('tituloModal');
$funcaoModal  = getPost('funcaoModal');
$textoModal   = getPost('textoModal');
$textoBotao   = getPost('textoBotao');

$cod_nacao = '';
$desc_estado = '';
$sigla_estado = '';

$cod = getPost('cod');


$query ="SELECT 
            tur.cod_turma,
            tur.desc_turma,
            tur.ativo,
            sub.desc_subInstituicao
         FROM turma tur 
         INNER JOIN subinstituicao sub ON sub.cod_subInstituicao = tur.cod_subInstituicao
         where tur.cod_turma = $cod
        ";

if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

$ativo = $bd->SqlQueryShow('ativo');
$desc_turma = $bd->SqlQueryShow('desc_turma');



$retorno = '<div class="modal fade" id="' . $idModal . '" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content shadow-sm border-0">
        
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="exampleModalLabel">' . $tituloModal . '</h5>

            </div>
            <div class="modal-body p-4">
                    <div id="selecionarSubInstituicaoSelecionado"></div>
                <div class="row mt-3">
                    <div class="col-md-6 mb-3">
                        <label for="atualizacaoDesc_turma" class="form-label font-weight-bold">Nome da turma:</label>
                        <input type="text" class="form-control" id="atualizacaoDesc_turma" value="' . $desc_turma . '" placeholder="Digite o nome do estado...">
                    </div>                    
                    <div class="col-md-6 mb-3">
                        <label for="atualizacaoAtivo_subTurma" class="form-label font-weight-bold">Ativo:</label>
                        <select id="atualizacaoAtivo_subTurma" name="ativo" class="form-select">
                            <option value="">Selecione</option>
                            <option value="s"' . ($ativo === 's' ? ' selected' : '') . '>Sim</option>
                            <option value="n"' . ($ativo === 'n' ? ' selected' : '') . '>Não</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="funcaoDoModal" onclick="' . $funcaoModal . '(\'' . $cod . '\')">' . $textoBotao . '</button>
                <button type="button" class="btn btn-secondary" id="cancelarModal" data-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>';

echo $retorno;
?>