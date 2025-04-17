<?php
require('../../../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod_nacao='';
$desc_estado ='';
$sigla_estado ='';

$cod_estado   = getPost('cod_estado');
$idModal      = getPost('idModal');
$tituloModal  = getPost('tituloModal');
$funcaoModal  = getPost('funcaoModal');
$textoModal   = getPost('textoModal');
$textoBotao   = getPost('textoBotao');


$query ="select cod_nacao,desc_estado,sigla_estado from estado WHERE cod_estado =". $cod_estado;

if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

$cod_nacao = $bd->SqlQueryShow('cod_nacao');
$desc_estado = $bd->SqlQueryShow('desc_estado');
$sigla_estado = $bd->SqlQueryShow('sigla_estado');


$retorno = '
<div class="modal fade" id="' . $idModal . '" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content shadow-sm border-0">
        
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="exampleModalLabel">' . $tituloModal . '</h5>

            </div>
            <div class="modal-body p-4">
                <div id="selectNacoesAtualizarEstado"></div>

                <div class="row mt-3">
                    <div class="col-md-6 mb-3">
                        <label for="atualizacaoDesc_estado" class="form-label font-weight-bold">Nome do estado:</label>
                        <input type="text" class="form-control" id="atualizacaoDesc_estado" value="'.$desc_estado.'" placeholder="Digite o nome do estado...">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="atualizacaoSigla_estado" class="form-label font-weight-bold">Sigla do estado:</label>
                        <input type="text" class="form-control" id="atualizacaoSigla_estado" value="'.$sigla_estado.'" maxlength="3" placeholder="Digite a sigla...">
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="funcaoDoModal" onclick="' . $funcaoModal . '(\'' . $cod_estado . '\')">' . $textoBotao . '</button>
                <button type="button" class="btn btn-secondary" id="cancelarModal" data-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>';

echo $retorno;
?>
