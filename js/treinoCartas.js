function criarCarta(cod_jogador, nome, local_midia) {
  // Verifica se já existe uma carta com este id
  if (document.querySelector(`.carta[data-id='${cod_jogador}']`)) {
    return; // Já existe, ignora
  }

  const cor = "#e0f7fa";

  const areaCartas = document.getElementById("areaCartas");

  const quantidadeCartas = document.querySelectorAll(".carta").length;
  const elementoCarta = document.createElement("div");
  elementoCarta.classList.add("carta");
  elementoCarta.setAttribute("data-id", cod_jogador);

  // Conteúdo com centralização via style inline no container e estilos na img e texto
  elementoCarta.innerHTML = `
    <div style="
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100%;
      text-align: center;
      font-family: Arial, sans-serif;
      font-size: 14px;
      color: #333;
    ">
      <img src="${local_midia}" alt="Imagem" 
        onerror="this.onerror=null;this.src='../../img/icone/jogadorPadrao.png';"
        style="width: 60px; height: 60px; object-fit: cover; border-radius: 50%; margin-bottom: 8px;"
      />
      <strong style="word-break: break-word;">${nome}</strong>
    </div>
  `;

  // Estilos da carta
  elementoCarta.style.position = "absolute";
  elementoCarta.style.width = "120px";       // compacto, mas não tão pequeno
  elementoCarta.style.height = "140px";      // espaço para imagem + nome
  elementoCarta.style.backgroundColor = cor; // usa cor personalizada
  elementoCarta.style.border = "2px solid rgb(0, 0, 0)";  // corrigido o border
  elementoCarta.style.borderRadius = "10px";
  elementoCarta.style.padding = "10px";
  elementoCarta.style.cursor = "grab";
  elementoCarta.style.boxShadow = "2px 2px 10px rgba(0, 0, 0, 0.2)";
  elementoCarta.style.userSelect = "none"; // evita seleção do texto ao arrastar

  // Posicionamento inicial, você pode ajustar conforme quiser
  elementoCarta.style.top = `${25 + quantidadeCartas * 25}px`;
  elementoCarta.style.left = "0px";

  // Código de movimentação do mouse continua igual
  elementoCarta.onmousedown = function (evento) {
    const deslocamentoX = evento.clientX - elementoCarta.getBoundingClientRect().left;
    const deslocamentoY = evento.clientY - elementoCarta.getBoundingClientRect().top;
    elementoCarta.style.cursor = "grabbing";

    function moverPara(paginaX, paginaY) {
      const limitesArea = areaCartas.getBoundingClientRect();
      let novaEsquerda = paginaX - deslocamentoX - limitesArea.left;
      let novoTopo = paginaY - deslocamentoY - limitesArea.top;

      novaEsquerda = Math.max(0, Math.min(novaEsquerda, areaCartas.clientWidth - elementoCarta.offsetWidth));
      novoTopo = Math.max(0, Math.min(novoTopo, areaCartas.clientHeight - elementoCarta.offsetHeight));

      elementoCarta.style.left = novaEsquerda + "px";
      elementoCarta.style.top = novoTopo + "px";
    }

    function aoMoverMouse(evento) {
      moverPara(evento.pageX, evento.pageY);
    }

    function aoSoltarMouse() {
      document.removeEventListener("mousemove", aoMoverMouse);
      document.removeEventListener("mouseup", aoSoltarMouse);
      elementoCarta.style.cursor = "grab";
    }

    document.addEventListener("mousemove", aoMoverMouse);
    document.addEventListener("mouseup", aoSoltarMouse);
  };

  elementoCarta.ondragstart = () => false;
  // Ajuste aqui se quiser usar o nome direto, pois novaCarta não está definida no seu código
  elementoCarta.onclick = () => abrirDados(nome);

  areaCartas.appendChild(elementoCarta);
}


// Função para remover carta permanece a mesma
function retirarCarta(cod_jogador) {
  const carta = document.querySelector(`.carta[data-id='${cod_jogador}']`);
  if (carta) {
    carta.remove();
  } else {
    console.log(`Carta com id ${cod_jogador} não encontrada.`);
  }
}


function mudarCorVermelho(cod_jogador) {
  const carta = document.querySelector(`.carta[data-id='${cod_jogador}']`);
  if (carta) {
    carta.style.backgroundColor = "#ffcdd2";
  } else {
    console.log(`Carta com id ${cod_jogador} não encontrada.`);
  }
}

function mudarCorAzul(cod_jogador) {
  const carta = document.querySelector(`.carta[data-id='${cod_jogador}']`);
  if (carta) {
    carta.style.backgroundColor = "#e0f7fa";
  } else {
    console.log(`Carta com id ${cod_jogador} não encontrada.`);
  }
}
