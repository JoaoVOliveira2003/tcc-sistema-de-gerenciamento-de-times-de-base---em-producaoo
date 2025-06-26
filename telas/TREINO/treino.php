<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();

$listarJogadoresParaTreino = $_POST['listarJogadoresParaTreino'];
$esporte = $_POST['escolhaEsporte'];
$tempoInicial = $_POST['tempoInicial'];
$cod_treino = $_POST['cod_treino'];

if ($esporte == '1') {
  $url = 'http://localhost/tcc/img/icone/campoFutebol.jpg';
} elseif ($esporte == '2') {
  $url = 'http://localhost/tcc/img/icone/campoVolei.jpg';
} elseif ($esporte == '3') {
  $url = 'http://localhost/tcc/img/icone/campoBasquete.png';
}

list($minutos, $segundos) = explode(':', $tempoInicial);
$minutos = (int)$minutos;
include('../../componentes/header.php');
?>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1.0" />
  <?php include('../../include/includeBase.php'); ?>
  <script src="../../js/funcoes.js"></script>
  <script src="../../js/treino.js"></script>
  <script src="../../js/treinoCartas.js"></script>
  <link rel="stylesheet" href="treino.css">

</head>

<body>
  <style>
   .sidebar {
      flex: 0 0 250px;
    }
  </style>

  <div class="p-2 mx-auto d-flex justify-content-center align-items-center">
    <button class="btn btn-primary" id="toggleLeft">☰ Esquerda</button>

    <div id="relogio" style="display:inline-block; margin: 0 20px; font-weight:bold; font-size:1.2em;">
      00:00 | 0:0
    </div>

    <button class="btn btn-primary" id="toggleRight">☰ Direita</button>
  </div>

  <script>
    const tempoMaxMinutos = <?php echo $minutos; ?>;
    const tempoMaxSegundos = tempoMaxMinutos * 60;

    const relogio = document.getElementById('relogio');

    let segundosPassados = 0;

    function formatarTempo(segundos) {
      const min = Math.floor(segundos / 60);
      const seg = segundos % 60;
      return `${min.toString().padStart(2,'0')}:${seg.toString().padStart(2,'0')}`;
    }

    function atualizarRelogio() {
      if (segundosPassados > tempoMaxSegundos) {
        clearInterval(intervalo);
        relogio.textContent = "Tempo encerrado!";
        return;
      }

      relogio.textContent = formatarTempo(segundosPassados);
      segundosPassados++;
    }

    // Começa o cronômetro
    atualizarRelogio();

    const intervalo = setInterval(atualizarRelogio, 1000);
    const todosJogadores = <?php echo json_encode($listarJogadoresParaTreino); ?>;
    const esporte = <?php echo json_encode($esporte); ?>;
    const tempoInicial = <?php echo json_encode($tempoInicial); ?>;
    const codTreino = <?php echo json_encode($cod_treino); ?>;

    listaDeJogadores(todosJogadores);

    document.getElementById("toggleLeft").addEventListener("click", () => {
      document.getElementById("sidebarLeft").classList.toggle("d-none");
    });

    document.getElementById("toggleRight").addEventListener("click", () => {
      document.getElementById("sidebarRight").classList.toggle("d-none");
    });
</script>

  <div class="d-flex" style="min-height:100vh;">

    <!-- Sidebar Esquerda -->
    <div class="sidebar p-3 bg-light border-end" id="sidebarLeft">
      <h5>Lista Jogadores</h5>
      <div class="accordion" id="accordionLeft">
        <div id="listaDeJogadores"></div>
      </div>
    </div>

    <!-- Área Central -->
    <div id="areaCartas" class="d-flex justify-content-center align-items-center"></div>

    <!-- Sidebar Direita -->
    <div class="sidebar p-3 bg-light border-start" id="sidebarRight">
      <h5>Ações</h5>
      <div class="accordion" id="accordionRight">
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingRight1">
            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseRight1">
              Info A
            </button>
          </h2>
          <div id="collapseRight1" class="accordion-collapse collapse show">
            <div class="accordion-body">Detalhes para o lado direito.</div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingRight2">
            <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#collapseRight2">
              Info B
            </button>
          </h2>
          <div id="collapseRight2" class="accordion-collapse collapse">
            <div class="accordion-body">Outra informação para o lado direito.</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>