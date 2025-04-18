<?php
require('../../../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod_nacao = '';
$desc_estado = '';
$sigla_estado = '';

$cod = getPost('cod');

$idModal = getPost('idModal');
$tituloModal = getPost('tituloModal');
$funcaoModal = getPost('funcaoModal');
$textoModal = getPost('textoModal');
$textoBotao = getPost('textoBotao');

$query = "select desc_instituicao,ativo from instituicao where cod_instituicao = " . $cod;

if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

$desc_instituicao = $bd->SqlQueryShow('desc_instituicao');
$ativo = $bd->SqlQueryShow('ativo');

$retorno = '<div class="modal fade" id="' . $idModal . '" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content shadow-sm border-0">
        
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="exampleModalLabel">' . $tituloModal . '</h5>

            </div>
            <div class="modal-body p-4">
                <div id="selectEstadoAtualizarInstituicao"></div>

                <div class="row mt-3">
                    <div class="col-md-6 mb-3">
                        <label for="atualizacaoDesc_instituicao" class="form-label font-weight-bold">Nome da instituição:</label>
                        <input type="text" class="form-control" id="atualizacaoDesc_instituicao" value="' . $desc_instituicao . '" placeholder="Digite o nome do estado...">
                    </div>                    
                    <div class="col-md-6 mb-3">
                        <label for="atualizacaoAtivo_instituicao" class="form-label font-weight-bold">Ativo:</label>
                        <select id="atualizacaoAtivo_instituicao" name="ativo" class="form-select">
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