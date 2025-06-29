function listarJogadoresParaTreino(cod_staff){
  var pagina = "/tcc/componentes/TREINO/listarJogadoresParaTreino.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {cod_staff: cod_staff,},
    success: function (data) {
      $("#listarJogadoresParaTreino").html(data);
    },
  });
}

function listarEsportes(){
  var pagina = "/tcc/componentes/selectBasico.php";

  var query = "SELECT cod_esporte,desc_esporte FROM esporte;";
  var codSelect = "cod_esporte";
  var descSelect = "desc_esporte";
  var label = "Treino do esporte:";
  var classLabel = "form-label";
  var forLabel = "escolhaEsporte";
  var classSelect = "form-control";
  var idSelect = "escolhaEsporte";
  var name = "escolhaEsporte";
  var primeiroOption = "Escolha uma opção";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      query: query,
      codSelect: codSelect,
      descSelect: descSelect,
      label: label,
      classLabel: classLabel,
      forLabel: forLabel,
      classSelect: classSelect,
      idSelect: idSelect,
      name: name,
      primeiroOption: primeiroOption,
    },
    success: function (data) {
      $("#selectEsportes").html(data);
    },
  });
}

function listaDeJogadores(todosJogadores){
  var pagina = "/tcc/componentes/TREINO/listaDeJogadores.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {todosJogadores: todosJogadores,},
    success: function (data) {
      $("#listaDeJogadores").html(data);
    },
  });
}

// controleTreino.js

let tempoMaxSegundos;
let segundosPassados = 0;
let pausado = false;
let intervalo = null;

let placarEsquerda = 0;
let placarDireita = 0;

function formatarTempo(segundos) {
  const min = Math.floor(segundos / 60);
  const seg = segundos % 60;
  return `${min.toString().padStart(2, '0')}:${seg.toString().padStart(2, '0')}`;
}

function atualizarRelogio() {
  if (!pausado) {
    if (segundosPassados > tempoMaxSegundos) {
      clearInterval(intervalo);
      document.getElementById('relogio').textContent = "Encerrado!";
      return;
    }
    document.getElementById('relogio').textContent = formatarTempo(segundosPassados);
    segundosPassados++;
  }
}

function pausarOuRetomar() {
  pausado = !pausado;
  if (!pausado) {
    intervalo = setInterval(atualizarRelogio, 1000);
  } else {
    clearInterval(intervalo);
  }
}

function alterarPlacar(lado, valor) {
  if (lado === 'esquerda') {
    placarEsquerda = Math.max(0, placarEsquerda + valor);
    document.getElementById('placarEsquerda').textContent = placarEsquerda;
  } else if (lado === 'direita') {
    placarDireita = Math.max(0, placarDireita + valor);
    document.getElementById('placarDireita').textContent = placarDireita;
  }
}

function finalizarTreino() {
  window.location.href = "http://localhost/tcc/telas/login/telaPosLogin.php";
}

function iniciarControlesTreino(jogadores, tempoEmSegundos) {
  tempoMaxSegundos = tempoEmSegundos;
  listaDeJogadores(jogadores);
  intervalo = setInterval(atualizarRelogio, 1000);

  document.getElementById("toggleLeft").addEventListener("click", () => {
    document.getElementById("sidebarLeft").classList.toggle("d-none");
  });

  document.getElementById("toggleRight").addEventListener("click", () => {
    document.getElementById("sidebarRight").classList.toggle("d-none");
  });
}
