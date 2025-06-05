<?php
require('../../include/conecta.php');
$bd = conecta();
$retorno = '';

$idModal = getPost('idModal');
$tituloModal = getPost('tituloModal');
$funcaoModal = getPost('funcaoModal');
$textoModal = getPost('textoModal');
$textoBotao = getPost('textoBotao');

$cod_usuario = getPost('cod_usuario');
$cod_SubInstituicao = getPost('cod_SubInstituicao');

// Primeiro: buscar turmas já vinculadas ao staff
$query = "SELECT cod_turma FROM staff_turma WHERE cod_staff = $cod_usuario;";
$turmas = [];

if ($bd->SqlExecuteQuery($query) && $bd->SqlNumRows() > 0) {
    do {
        $cod_turma_vinculada = $bd->SqlQueryShow('cod_turma');
        $turmas[] = $cod_turma_vinculada;
    } while ($bd->SqlFetchNext());
}

$query = "SELECT cod_turma, desc_turma FROM turma WHERE cod_subInstituicao = $cod_SubInstituicao AND ativo = 's'";
if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
    return;
}

$retorno .= '<div class="modal fade" id="' . $idModal . '" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content shadow-sm border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="exampleModalLabel">' . $tituloModal . ' - ao selecionar uma turma, você estará vinculando a turma ao staff.</h5>
            </div>
            <div class="modal-body p-4">
                <div class="row mt-3">
';

do {
    $cod_turma = $bd->SqlQueryShow('cod_turma');
    $desc_turma = $bd->SqlQueryShow('desc_turma');

    // Verifica se esta turma está no array de turmas já vinculadas
    $checked = in_array($cod_turma, $turmas) ? 'checked' : '';

    $retorno .= '
        <div class="col-md-6 mb-2">
            <div class="form-check">
                <input class="form-check-input" style="font-size: 18px;" type="checkbox" value="' . $cod_turma . '" id="turma_' . $cod_turma . '" ' . $checked . '>
                <label class="form-check-label" style="font-size: 18px;" for="turma_' . $cod_turma . '">' . $desc_turma . '</label>
            </div>
        </div>
    ';
} while ($bd->SqlFetchNext());

$retorno .= '
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="funcaoDoModal" onclick="' . $funcaoModal . '(\'' . $cod_usuario . '\')">' . $textoBotao . '</button>
                <button type="button" class="btn btn-secondary" id="cancelarModal" data-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>';

echo $retorno;
?>
