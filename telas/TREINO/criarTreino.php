<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<?php include('../../include/includeBase.php'); ?>
<script src="../../js/funcoes.js"></script>
<script src="../../js/treino.js"></script>
<script>
$(document).ready(function() {
  const usuario = <?php echo json_encode($usuario); ?>;

  // Carrega esportes e jogadores
  listarEsportes();
  listarJogadoresParaTreino(usuario.cod_usuario);

  // Copia para o hidden
  document.getElementById("usuarioCodStaff").value = usuario.cod_usuario;

  // Máscara de tempo (MM:SS)
  const tempoInput = document.getElementById('tempoInicial');
  tempoInput.addEventListener('input', function(e) {
    let value = e.target.value.replace(/\D/g, '');
    if (value.length > 4) {
      value = value.slice(0, 4);
    }
    if (value.length >= 3) {
      value = value.slice(0, 2) + ':' + value.slice(2);
    }
    e.target.value = value;
  });
});

// Valida e envia o formulário
function enviarFormularioSeValido() {
  const usuario = <?php echo json_encode($usuario); ?>;

  const tempoInicial = document.getElementById("tempoInicial").value.trim();
  const esportes = document.querySelector('#selectEsportes select')?.value || '';
  const jogadoresMarcados = document.querySelectorAll('#listarJogadoresParaTreino input[type="checkbox"]:checked');

  if (!tempoInicial && !esportes && jogadoresMarcados.length === 0) {
    alert("Por favor, preencha ao menos o Tempo, selecione um Esporte ou marque um Jogador antes de iniciar.");
    return;
  }

  // Submete direto para treino.php
  document.querySelector("form").submit();
}
</script>
</head>

<body>
<?php include('../../componentes/header.php'); ?>

<div class="container">
  <div class="mt-1">
    <h2 class="mb-3">Criar treino</h2>
    <h5 class="mb-4">Colocar um texto bom aqui posteriormente</h5>

    <form method="POST" action="treino.php">
      <!-- Campo hidden para o id do staff -->
      <input type="hidden" id="usuarioCodStaff" name="cod_staff">

      <div class="row mt-3">
        <div class="col-md-6 mb-3">
          <!-- O JS vai injetar o select de esportes aqui -->
          <div id="selectEsportes"></div>
        </div>

        <div class="col-md-6 mb-3">
          <label for="tempoInicial" class="form-label font-weight-bold">Tempo de treino (min:seg):</label>
          <input
            type="text"
            class="form-control"
            id="tempoInicial"
            name="tempoInicial"
            placeholder="00:00"
            maxlength="5"
          />
        </div>
      </div>

      <hr>

      <div class="row mt-1">
        <div class="col-md-12">
          <!-- O JS vai injetar as checkbox dos jogadores aqui -->
          <div id="listarJogadoresParaTreino"></div>
        </div>
      </div>

      <hr>

      <button 
        type="button"
        class="btn btn-primary btn-sm"
        id="iniciarTreinoBtn"
        onClick="enviarFormularioSeValido()"
      >
        Iniciar treino
      </button>
    </form>
  </div>
</div>

</body>
</html>
