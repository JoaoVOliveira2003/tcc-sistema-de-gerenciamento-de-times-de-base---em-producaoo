<?php

require('../../../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod_nacao = '';
$desc_municipio = '';
$sigla_municipio = '';

$cod_municipio = getPost('cod');
$idModal = getPost('idModal');
$tituloModal = getPost('tituloModal');
$funcaoModal = getPost('funcaoModal');
$textoModal = getPost('textoModal');
$textoBotao = getPost('textoBotao');

$query = "SELECT cod_estado, desc_municipio, sigla_municipio FROM municipio WHERE cod_municipio = " . $cod_municipio;


if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

$cod_nacao       = $bd->SqlQueryShow('cod_nacao');
$desc_municipio  = $bd->SqlQueryShow('desc_municipio');
$sigla_municipio = $bd->SqlQueryShow('sigla_municipio');

$retorno = '
<div class="modal fade" id="' . $idModal . '" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content shadow-sm border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="exampleModalLabel">' . $tituloModal . '</h5>
            </div>
            <div class="modal-body p-4">

                <div id="selectEstadoAtualizarMunicipio"></div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="atualizacaoDesc_municipio" class="form-label">Nome do município:</label>
                        <input value="' . $desc_municipio . '" type="text" class="form-control" id="atualizacaoDesc_municipio" placeholder="Digite algo...">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="atualizacaoSigla_municipio" class="form-label">Sigla do município:</label>
                        <input value="' . $sigla_municipio . '" type="text" class="form-control" id="atualizacaoSigla_municipio" maxlength="3" placeholder="Digite algo...">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="funcaoDoModal" onclick="' . $funcaoModal . '(\'' . $cod_municipio . '\')">' . $textoBotao . '</button>
                <button type="button" class="btn btn-secondary" id="cancelarModal" data-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>';

echo $retorno;
?>
