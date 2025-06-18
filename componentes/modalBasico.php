<?php
require('../include/conecta.php');
$retorno='';

$cod = getPost('cod');


$idModal = getPost('idModal');
$tituloModal = getPost('tituloModal');
$funcaoModal = getPost('funcaoModal');
$textoModal = getPost('textoModal');
$textoBotao = getPost( 'textoBotao');
$campoHidden = getPost( 'campoHidden');
if($campoHidden){
$retorno .= $campoHidden;
}    

$retorno .= '
    <div class="modal fade show" id="' . $idModal .'" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">' . $tituloModal . '</h5>
                </div>
                <div class="modal-body">
                    <p>' . $textoModal . '</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="funcaoDoModal" onclick="' . $funcaoModal . '(\'' . $cod . '\')">'. $textoBotao .'</button>
                    <button type="button" class="btn btn-secondary" id="cancelarModal" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>';

echo $retorno;
?>
