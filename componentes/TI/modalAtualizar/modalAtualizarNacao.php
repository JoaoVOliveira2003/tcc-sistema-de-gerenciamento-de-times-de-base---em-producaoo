<?php
require('../../../include/conecta.php');
$bd = conecta();
$retorno = '';

$desc_nacao ='';
$sigla_nacao ='';

$cod   = getPost('cod');
$idModal      = getPost('idModal');
$tituloModal  = getPost('tituloModal');
$funcaoModal  = getPost('funcaoModal');
$textoModal   = getPost('textoModal');
$textoBotao   = getPost('textoBotao');

$query ="select sigla_nacao,desc_nacao from nacao where cod_nacao= ". $cod;


if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

$desc_nacao = $bd->SqlQueryShow('desc_nacao');
$sigla_nacao = $bd->SqlQueryShow('sigla_nacao');

$retorno = '
<div class="modal fade" id="' . $idModal . '" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content shadow-sm border-0">
        
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="exampleModalLabel">' . $tituloModal . '</h5>

            </div>
            <div class="modal-body p-4">
                <div class="row mt-3">
                    <div class="col-md-6 mb-3">
                        <label for="atualizacaoDesc_nacao" class="form-label font-weight-bold">Nome da nação:</label>
                        <input type="text" class="form-control" id="atualizacaoDesc_nacao" value="'.$desc_nacao.'" placeholder="Digite o nome do estado...">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="atualizacaoSigla_nacao" class="form-label font-weight-bold">Sigla da nação:</label>
                        <input type="text" class="form-control" id="atualizacaoSigla_nacao" value="'.$sigla_nacao.'" maxlength="3" placeholder="Digite a sigla...">
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
