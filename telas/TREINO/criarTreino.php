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

  listarEsportes();
  listarJogadoresParaTreino(usuario.cod_usuario);

  // Preenche o campo hidden com o ID do staff
  $("#usuarioCodStaff").val(usuario.cod_usuario);

  // Máscara para o campo de tempo
  const tempoInput = document.getElementById("tempoInicial");
  tempoInput.addEventListener("input", function (e) {
    let value = e.target.value.replace(/\D/g, "");
    if (value.length > 4) value = value.slice(0, 4);
    if (value.length >= 3) {
      value = value.slice(0, 2) + ":" + value.slice(2);
    }
    e.target.value = value;
  });
});

// Valida e envia o formulário
function enviarFormularioSeValido() {

  const cod_staff = $("#usuarioCodStaff").val().trim();
  const tempo_treino = $("#tempoInicial").val().trim();
  const cod_esporte = $("#selectEsportes select").val() || '';
  const cod_jogadores = Array.from(document.querySelectorAll('#listarJogadoresParaTreino input[type="checkbox"]:checked')).map(cb => cb.value);

const nomeTreino = $("#nomeTreino").val().trim();

  const camposObrigatorios = {
    tempo_treino,
    cod_esporte,
    cod_jogadores,
    cod_staff,
    nomeTreino,
  };
  const mensagemCamposObrigatorios = {
    tempo_treino: "Tempo de treino",
    cod_esporte: "Esporte do treino",
    cod_jogadores: "Jogadores que participarão no treino",
    cod_staff: "Responsável (cod_staff)",
    nomeTreino : "Nome do treino"
  };
  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: "/tcc/componentes/TREINO/gravarTreino.php",
    data: {
      nomeTreino,
      cod_staff,
      tempo_treino,
      cod_esporte,
      cod_jogadores
    },
    success: function(data) {

      if (data != 'nok2' || data != 'nok1') {

        const form = document.getElementById('formTreino');
  
        const cod_treino = data.trim();


     let inputTreino = document.querySelector('input[name="cod_treino"]');
    if (!inputTreino) {
      inputTreino = document.createElement('input');
      inputTreino.type = 'hidden';
      inputTreino.name = 'cod_treino';
      form.appendChild(inputTreino);
    }
    inputTreino.value = cod_treino;


        // Esporte
        let inputEsporte = document.querySelector('input[name="escolhaEsporte"]');
        if (!inputEsporte) {
          inputEsporte = document.createElement('input');
          inputEsporte.type = 'hidden';
          inputEsporte.name = 'escolhaEsporte';
          form.appendChild(inputEsporte);
        }
        inputEsporte.value = cod_esporte;

        // Jogadores
        document.querySelectorAll('input[name="listarJogadoresParaTreino[]"]').forEach(el => el.remove());
        cod_jogadores.forEach(cod => {
          const input = document.createElement('input');
          input.type = 'hidden';
          input.name = 'listarJogadoresParaTreino[]';
          input.value = cod;
          form.appendChild(input);
        });

        // Submete para treino.php
        form.action = 'treino.php';
        form.method = 'POST';
        form.submit();
      } else {
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
      <input type="hidden" id="usuarioCodStaff" name="cod_staff">

      <div class="col-12 mb-3">
        <label for="nomeTreino" class="form-label">Nome do Treino</label>
        <input type="text" class="form-control" id="nomeTreino" name="nomeTreino" placeholder="Digite o nome do treino">
      </div>

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
        <div class="col-12">
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
