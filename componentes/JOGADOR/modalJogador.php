<?php
require('../../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod_jogador = getPost('cod_jogador');
$idModal = getPost('idModal');


// $query = "

// ";

// if (!$bd->SqlExecuteQuery($query) || $bd->SqlNumRows() <= 0) {
//     return;
// }

$retorno = '
<div class="modal fade" id="'.$idModal.'" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content shadow-sm border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="exampleModalLabel">Jogador: ' . $cod_jogador . '</h5>
            </div>
            <div class="modal-body p-4">
                <p>Conteúdo do jogador carregado dinamicamente.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="funcaoDoModal">Sei lá</button>
                <button type="button" class="btn btn-secondary" id="cancelarModal" data-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>';

echo $retorno;
?>