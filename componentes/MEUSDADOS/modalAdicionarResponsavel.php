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

          <!-- Nome do responsável -->
          <div class="col-md-6">
            <label class="form-label">Nome do Responsável:</label>
            <input type="text" id="responsavel_nome" name="responsavel_nome" class="form-control" placeholder="Nome do Responsável" required>
          </div>

          <!-- Tipo de filiação -->
          <div class="col-md-6">
            <label class="form-label">Tipo de Filiação:</label>
            <select name="responsavel_filiacao[]" id="responsavel_filiacao" class="form-select" required>
              <option value="" disabled selected>Selecione</option>
              <option value="Pai">Pai</option>
              <option value="Mãe">Mãe</option>
              <option value="Responsável legal">Responsável legal</option>
              <option value="Outro">Outro</option>
            </select>
          </div>
        </div>

        <div class="row g-2 mt-2">
          <!-- Email do responsável -->
          <div class="col-md-6">
            <label class="form-label">Email do Responsável:</label>
            <input type="email" name="responsavel_email[]" id="responsavel_email" class="form-control" placeholder="Email do Responsável" required>
          </div>

          <!-- Telefone do responsável -->
<!-- Telefone do responsável -->
<div class="col-md-5">
  <label class="form-label">Telefone do Responsável:</label>
  <input type="text" id="responsavel_telefone" name="responsavel_telefone[]"
         class="form-control telefone-mask"
         placeholder="(99) 99999-9999"
         maxlength="15" inputmode="numeric" pattern="\d*" required>
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
</div>
<script>
  $(document).ready(function () {
    // Aplica máscara aos campos existentes
    $(".telefone-mask").mask("(00) 00000-0000");

    // Aplica máscara também a novos campos dinamicamente adicionados
    $(document).on("input", ".telefone-mask", function () {
      $(this).mask("(00) 00000-0000");

      // Remove letras ou caracteres inválidos
      this.value = this.value.replace(/[^0-9()\s-]/g, "");
    });
  });
</script>
';


echo $retorno;
?>
