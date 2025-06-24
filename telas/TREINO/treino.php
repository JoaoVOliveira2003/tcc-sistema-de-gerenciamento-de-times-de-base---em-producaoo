<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();

$listarJogadoresParaTreino = $_POST['listarJogadoresParaTreino'];
$esporte = $_POST['escolhaEsporte'];
$tempoInicial = $_POST['tempoInicial'];
print_r($listarJogadoresParaTreino);
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
<link rel="stylesheet" href="treino.css">

</head>
<body>

<style>
  #areaCartas {
  position: relative;
  flex: 1;
  height: 600px;
  border: 1px solid #ccc;
  background-image: url('http://localhost/tcc/img/icone/campoFutebol.jpg');
  background-size: cover;       /* cobre toda a área */
  background-position: center;  /* centraliza a imagem */
  background-repeat: no-repeat; /* não repete */
  overflow: hidden;
}

.carta {
  position: absolute;
  width: 100px;
  height: 100px;
  background-color: #e0f7fa;
  border: 2px solid #00838f;
  border-radius: 10px;
  padding: 10px;
  cursor: grab;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
}
.sidebar {
  flex: 0 0 250px;
}
</style>

<div class="p-2 mx-auto d-flex justify-content-center align-items-center" >
  <button class="btn btn-primary" id="toggleLeft">☰ Esquerda</button>

  <div id="relogio" style="display:inline-block; margin: 0 20px; font-weight:bold; font-size:1.2em;">
    00:00
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
    if(segundosPassados > tempoMaxSegundos) {
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
</script>

<div class="d-flex" style="min-height:100vh;">
  
<!-- Sidebar Esquerda -->
  <div class="sidebar p-3 bg-light border-end" id="sidebarLeft">
    <h5>Lista Jogadores</h5>
    
    <div class="accordion" id="accordionLeft">
    
     <div class="accordion-item">
        <h2 class="accordion-header" id="headingLeft1">
          <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseLeft1">
            Seção 1
          </button>
        </h2>
        <div id="collapseLeft1" class="accordion-collapse collapse show">
          <div class="accordion-body">Conteúdo da Seção 1.</div>
        </div>
      </div>
      
      <div class="accordion-item">
        <h2 class="accordion-header" id="headingLeft2">
          <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#collapseLeft2">
            Seção 2
          </button>
        </h2>
        <div id="collapseLeft2" class="accordion-collapse collapse">
          <div class="accordion-body">Outra informação para o lado esquerdo.</div>
        </div>
      </div>
    
      
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

<!-- Scripts para as cartas arrastáveis e Toggle das sidebars -->
<script>

const area = document.getElementById("areaCartas");
const cartas = [
  { id: 1, titulo: "Carta 1", conteudo: "Conteúdo da carta 1" },
  { id: 2, titulo: "Carta 2", conteudo: "Conteúdo da carta 2" },
  { id: 3, titulo: "Carta 3", conteudo: "Conteúdo da carta 3" }
];









cartas.forEach((carta, index) => {
  const div = document.createElement("div");
  div.classList.add("carta");
  div.innerHTML = `<strong>${carta.titulo}</strong><br>${carta.conteudo}`;
  div.style.top = `${100 + index * 150}px`;
  div.style.left = "50px";

  div.onmousedown = function (e) {
    const shiftX = e.clientX - div.getBoundingClientRect().left;
    const shiftY = e.clientY - div.getBoundingClientRect().top;

    div.style.cursor = "grabbing";

    function moveAt(pageX, pageY) {
      const areaRect = area.getBoundingClientRect();
      let newLeft = pageX - shiftX - areaRect.left;
      let newTop = pageY - shiftY - areaRect.top;

      newLeft = Math.max(0, Math.min(newLeft, area.clientWidth - div.offsetWidth));
      newTop = Math.max(0, Math.min(newTop, area.clientHeight - div.offsetHeight));

      div.style.left = newLeft + "px";
      div.style.top = newTop + "px";
    }

    function onMouseMove(event) {
      moveAt(event.pageX, event.pageY);
    }

    function onMouseUp() {
      document.removeEventListener("mousemove", onMouseMove);
      document.removeEventListener("mouseup", onMouseUp);
      div.style.cursor = "grab";
    }

    document.addEventListener("mousemove", onMouseMove);
    document.addEventListener("mouseup", onMouseUp);
  };
  
  div.ondragstart = () => false;
  div.onclick = () => abrirDados(carta.titulo);
  area.appendChild(div);
});

function abrirDados(titulo) {
  console.log("foi clicado carta " + titulo);
}

// Toggle para sidebars
document.getElementById("toggleLeft").addEventListener("click", () => {
  document.getElementById("sidebarLeft").classList.toggle("d-none");
});

document.getElementById("toggleRight").addEventListener("click", () => {
  document.getElementById("sidebarRight").classList.toggle("d-none");
});

</script>
</body>
</html>
