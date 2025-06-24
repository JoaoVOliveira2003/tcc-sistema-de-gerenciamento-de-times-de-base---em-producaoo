<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
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
    if (value.length > 4) value = value.slice(0, 4);
    if (value.length >= 3) {
      value = value.slice(0, 2) + ':' + value.slice(2);
    }
    e.target.value = value;
  });
});

// Valida e envia o formulário
function enviarFormularioSeValido() {
  const cod_staff = document.getElementById("usuarioCodStaff").value.trim();
  const tempo_treino = document.getElementById("tempoInicial").value.trim();
  const cod_esporte = document.querySelector('#selectEsportes select')?.value || '';
  const valores = document.querySelectorAll('#listarJogadoresParaTreino input[type="checkbox"]:checked');
  const cod_jogadores = Array.from(valores).map(cb => cb.value);

  console.log(cod_jogadores);

  const camposObrigatorios = {
    tempo_treino,
    cod_esporte,
    cod_jogadores,
    cod_staff,
  };
  const mensagemCamposObrigatorios = {
    tempo_treino: "Tempo de treino",
    cod_esporte: "Esporte do treino",
    cod_jogadores: "Jogadores que participarão no treino",
    cod_staff: "Responsável (cod_staff)",
  };
  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) return;

  $.ajax({
    type: "POST",
    url: "/tcc/componentes/TREINO/gravarTreino.php",
    data: {
      cod_staff: cod_staff,
      tempo_treino: tempo_treino,
      cod_esporte: cod_esporte,
      cod_jogadores: cod_jogadores
    },
    success: function(data) {
      console.log(data);
      if(data == 'ok') {

  const form = document.getElementById('formTreino');

  let inputEsporte = document.querySelector('input[name="escolhaEsporte"]');
  if (!inputEsporte) {
    inputEsporte = document.createElement('input');
    inputEsporte.type = 'hidden';
    inputEsporte.name = 'escolhaEsporte';
    form.appendChild(inputEsporte);
  }
  inputEsporte.value = cod_esporte;

  // Jogadores: múltiplos valores, crie inputs hidden para cada um:
  // Remova inputs antigos para evitar duplicidade
  document.querySelectorAll('input[name="listarJogadoresParaTreino[]"]').forEach(el => el.remove());

  cod_jogadores.forEach(cod => {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'listarJogadoresParaTreino[]';
    input.value = cod;
    form.appendChild(input);
  });

  // Envia o formulário via POST para treino.php
  form.action = 'treino.php';
  form.method = 'POST';
  form.submit();

      }
      else {
        alert(data);
      }
    },
    error: function() {
      alert("Houve um erro ao tentar salvar o treino.");
    }
  });
}
</script>
</head>

<body>
<?php include('../../componentes/header.php'); ?>

<div class="container">
  <div class="mt-1">
    <h2 class="mb-3">Criar treino</h2>
    <h5 class="mb-4">Colocar um texto descritivo aqui depois</h5>

    <form method="POST" id="formTreino">
      <!-- Campo hidden para o id do staff -->
      <input type="hidden" id="usuarioCodStaff" name="cod_staff">

      <div class="row mt-3">
        <div class="col-md-6 mb-3">
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
