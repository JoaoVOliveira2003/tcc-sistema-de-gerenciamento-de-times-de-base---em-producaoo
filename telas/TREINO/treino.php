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
  <style>
    .sidebar {
      flex: 0 0 250px;
    }

    #relogio {
      font-size: 1.5rem;
      font-weight: bold;
    }

    .placar {
      font-size: 1.3rem;
      font-weight: bold;
      min-width: 30px;
      display: inline-block;
      text-align: center;
    }
  </style>
</head>

<body>

  <!-- TOPO COM PLACARES E RELÓGIO -->
  <div class="p-2 mx-auto d-flex justify-content-center align-items-center gap-4 flex-wrap">

    <button class="btn btn-primary" id="toggleLeft">☰ Esquerda</button>

    <!-- Placar Esquerda -->
    <div class="text-center">
      <label class="form-label m-0">Time vermelho.</label>
      <div class="btn-group btn-group-sm">
        <button type="button" class="btn btn-outline-danger" onclick="alterarPlacar('esquerda', -1)">-</button>
        <span class="placar px-2" id="placarEsquerda">0</span>
        <button type="button" class="btn btn-outline-danger" onclick="alterarPlacar('esquerda', 1)">+</button>
      </div>
    </div>

    <!-- Relógio -->
    <div class="text-center">
      <div id="relogio" class="mb-1">00:00</div>
      <button class="btn btn-warning btn-sm" onclick="pausarOuRetomar()">Pausar / Retomar</button>
   
    </div>

    <!-- Placar Direita -->
    <div class="text-center">
      <label class="form-label m-0">Time azul.</label>
      <div class="btn-group btn-group-sm">
        <button type="button" class="btn btn-outline-primary" onclick="alterarPlacar('direita', -1)">-</button>
        <span class="placar px-2" id="placarDireita">0</span>
        <button type="button" class="btn btn-outline-primary" onclick="alterarPlacar('direita', 1)">+</button>
      </div>
    </div>

    <button class="btn btn-primary" id="toggleRight">☰ Direita</button>
  </div>

  <!-- LAYOUT PRINCIPAL -->
  <div class="d-flex" style="min-height:100vh;">

    <!-- Sidebar Esquerda -->
    <div class="sidebar p-3 bg-light border-end" id="sidebarLeft">
      <h5>Lista Jogadores</h5>
      <!-- <button onclick="inserirRetirarBola()">inserirRetirarBola</button> -->
<button onclick="inserirRetirarBola()" type="button" class="btn btn-light" style="border: 1px solid #000;">Inserir/retirar bola</button>
      <hr>
      <div class="accordion" id="accordionLeft">
        <div id="listaDeJogadores"></div>
      </div>
    </div>

    <!-- Área Central -->
    <div id="areaCartas" class="d-flex justify-content-center align-items-center flex-grow-1"></div>

    <!-- Sidebar Direita -->
    <div class="sidebar p-3 bg-light border-start" id="sidebarRight">
      <h5>Ações</h5>
      <hr>
      <div class="mt-4">
        <button class="btn btn-success btn-sm w-100 mb-2" onclick="finalizarTreino()">Finalizar Treino</button>
      </div>
    </div>

  </div>

  <!-- SCRIPT -->
<script src="../../js/controleTreino.js"></script>
<script>
  const tempoMaxSegundosPHP = <?php echo $minutos * 60; ?>;
  const todosJogadores = <?php echo json_encode($listarJogadoresParaTreino); ?>;
  iniciarControlesTreino(todosJogadores, tempoMaxSegundosPHP);
</script>

</body>
</html>
