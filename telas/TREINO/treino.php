<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();
$esporte = $_POST['escolhaEsporte'];
$tempoInicial = $_POST['tempoInicial'];
$listarJogadoresParaTreino = $_POST['listarJogadoresParaTreino']; 
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<?php include('../../include/includeBase.php'); ?>
<script src="../../js/funcoes.js"></script>
<script src="../../js/treino.js"></script>
<style>
  #areaCartas {
    position: relative;
    width: 100%;
    height: 600px;
    border: 1px solid #ccc;
    background-color: #fafafa;
    overflow: hidden;
  }
  .carta {
    position: absolute;
    width: 200px;
    height: 120px;
    background-color: #e0f7fa;
    border: 2px solid #00838f;
    border-radius: 10px;
    padding: 10px;
    cursor: grab;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
  }
</style>
</head>
<body>
<?php include('../../componentes/header.php'); ?>

<div class="container">
  <div id="areaCartas"></div>
</div>

<script>
const cartas = [
  { id: 1, titulo: "Carta 1", conteudo: "Conteúdo da carta 1" },
  { id: 2, titulo: "Carta 2", conteudo: "Conteúdo da carta 2" },
  { id: 3, titulo: "Carta 3", conteudo: "Conteúdo da carta 3" }
];

const area = document.getElementById("areaCartas");

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

      // Limites para não sair do container
      newLeft = Math.max(0, Math.min(newLeft, area.clientWidth - div.offsetWidth));
      newTop = Math.max(0, Math.min(newTop, area.clientHeight - div.offsetHeight));

      div.style.left = newLeft + "px";
      div.style.top = newTop + "px";
    }

    function onMouseMove(event) {
      moveAt(event.pageX, event.pageY);
    }

    document.addEventListener("mousemove", onMouseMove);

    div.onmouseup = function () {
      document.removeEventListener("mousemove", onMouseMove);
      div.onmouseup = null;
      div.style.cursor = "grab";
    };
  };
  div.ondragstart = () => false;

  div.onclick = () => abrirDados(carta.titulo);
  area.appendChild(div);
});

function abrirDados(titulo) {
  console.log("foi clicado carta " + titulo);
}
</script>
</body>
</html>
