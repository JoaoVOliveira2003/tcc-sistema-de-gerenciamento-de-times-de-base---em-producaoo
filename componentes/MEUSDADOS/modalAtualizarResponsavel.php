<?php
require('../../include/conecta.php');
$bd = conecta();
$retorno = '';

$cod = getPost('cod');
$idModal = getPost('idModal');
$tituloModal = getPost('tituloModal');
$funcaoModal = getPost('funcaoModal');
$textoBotao = getPost('textoBotao');



$retorno = '
<div class="modal fade" id="' . $idModal . '" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content shadow-sm ">

      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="exampleModalLabel">' . $tituloModal . '</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Fechar"></button>
      </div>

      <div class="modal-body">
        <div id="lesoes-container">
          <div class="lesao mb-3">
            <div class="">
              <div class="row g-3 align-items-end">

                <!-- Tipo de lesão -->
                <div class="col-md-6">
                  <label class="form-label" for="cod_tipoLesao">Tipo de lesão</label>
                  <select name="cod_tipoLesao" id="cod_tipoLesao" class="form-select">
                    <option value="">Selecione...</option>
                    <option value="1">Lesões de Pele</option>
                    <option value="2">Lesões Musculares</option>
                    <option value="3">Lesões nas Articulações</option>
                    <option value="4">Lesões Neurológicas</option>
                    <option value="5">Lesões no Pé e Tornozelo</option>
                    <option value="6">Lesões no Pescoço ou Coluna</option>
                    <option value="7">Lesões no Quadril ou Lombar</option>
                    <option value="8">Lesões nos Ligamentos</option>
                    <option value="9">Lesões nos Meniscos</option>
                    <option value="10">Lesões nos Ossos</option>
                    <option value="11">Lesões nos Tendões</option>
                  </select>
                </div>

                <!-- Data da lesão -->
                <div class="col-md-3">
                  <label class="form-label" for="data_lesao">Data da lesão</label>
                  <input type="date" name="data_lesao" id="data_lesao" class="form-control">
                </div>

                <!-- Tempo fora -->
                <div class="col-md-3">
                  <label class="form-label" for="tempo_fora">Tempo fora</label>
                  <input type="text" id="tempo_fora" class="form-control" placeholder="Ex: 2 semanas">
                </div>

                <!-- Descrição da lesão -->
                <div class="col-md-12">
                  <label class="form-label" for="desc_lesao">Descrição da lesão</label>
                  <textarea name="desc_lesao" id="desc_lesao" class="form-control" rows="2" placeholder="Descreva a lesão..."></textarea>
                </div>

              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="modal-footer ">
        <button type="button" class="btn btn-danger" id="funcaoDoModal" onclick="' . $funcaoModal . '(\'' . $cod . '\')">' . $textoBotao . '</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
      </div>

    </div>
  </div>
</div>';


echo $retorno;
?>
