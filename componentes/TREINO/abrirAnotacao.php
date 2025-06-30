<?php
require('../../include/conecta.php');

$retorno = '';

$cod_jogador      = getPost('cod_jogador');
$nome             = getPost('nome');

$retorno = '
<div id="painelNota_'.$cod_jogador.'" class=" mb-3">
  <div class="d-flex justify-content-between align-items-center mb-2">
    <h6 class="mb-0">Crie uma nota de treino para:</h6>
    <button type="button" class="btn-close" aria-label="Fechar" onclick="fecharNotaTreino('.$cod_jogador.')"></button>
  </div>

  <div class="col-12 mb-3">
    <label class="form-label">Para jogador</label>
    <input class="form-control" disabled value="'.$nome.'">
  </div>

  <div class="col-12 mb-3">
    <label for="grauPrivacidade" class="form-label">Grau de Privacidade</label>
    <select class="form-select" id="grauPrivacidade" name="grauPrivacidade">
      <option value="">Selecione valor</option>
      <option value="1">privada</option>
      <option value="2">staff</option>
      <option value="3">staff e jogador</option>
    </select>
  </div>

  <div class="col-12 mb-3">
    <label for="descNotaTreino" class="form-label">Descrição da Nota</label>
    <textarea class="form-control" id="descNotaTreino" name="descNotaTreino" rows="3" placeholder="Digite a observação do jogador..."></textarea>
  </div>

  <button type="button" class="btn btn-success btn-sm" onclick="gravarNotaTreino('.$cod_jogador.')">Gravar anotação</button>
</div>

<hr>

<script>
  $(function(){
    $("#painelNota_'.$cod_jogador.'").slideDown("fast");
  });

  function fecharNotaTreino(cod_jogador) {
  const painel = document.getElementById("painelNota_" + cod_jogador);
  if (painel) {
    $(painel).slideUp("fast", function() {
      painel.remove();
    });
  }
}
</script>';

exit($retorno);