function listarJogadoresParaTreino(cod_staff) {
  var pagina = "/tcc/componentes/TREINO/listarJogadoresParaTreino.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: { cod_staff: cod_staff },
    success: function (data) {
      $("#listarJogadoresParaTreino").html(data);
    },
  });
}

function listarEsportes() {
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

function listaDeJogadores(todosJogadores) {
  var pagina = "/tcc/componentes/TREINO/listaDeJogadores.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: { todosJogadores: todosJogadores },
    success: function (data) {
      $("#listaDeJogadores").html(data);
    },
  });
}

let tempoMaxSegundos;
let segundosPassados = 0;
let pausado = false;
let intervalo = null;

let placarEsquerda = 0;
let placarDireita = 0;

function formatarTempo(segundos) {
  const min = Math.floor(segundos / 60);
  const seg = segundos % 60;
  return `${min.toString().padStart(2, "0")}:${seg
    .toString()
    .padStart(2, "0")}`;
}

function atualizarRelogio() {
  if (!pausado) {
    if (segundosPassados > tempoMaxSegundos) {
      clearInterval(intervalo);
      document.getElementById("relogio").textContent = "Encerrado!";
      return;
    }
    document.getElementById("relogio").textContent =
      formatarTempo(segundosPassados);
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
  if (lado === "esquerda") {
    placarEsquerda = Math.max(0, placarEsquerda + valor);
    document.getElementById("placarEsquerda").textContent = placarEsquerda;
  } else if (lado === "direita") {
    placarDireita = Math.max(0, placarDireita + valor);
    document.getElementById("placarDireita").textContent = placarDireita;
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

function gravarMidiaTreino(cod_treino) {
  const input = document.getElementById("midiaTreino");
  const arquivos = input.files;

  if (arquivos.length === 0) {
    alert("Nenhum arquivo selecionado.");
    return;
  }

  const formData = new FormData();
  formData.append("cod_treino", cod_treino);

  for (let i = 0; i < arquivos.length; i++) {
    formData.append("midias[]", arquivos[i]);
  }

  $.ajax({
    url: "/tcc/componentes/TREINO/gravarMidiaTreinos.php", // <-- caminho OK
    type: "POST",
    data: formData,
    processData: false,
    contentType: false,
    success: function (data) {
      if (data.trim() === "ok") {
        alert("Mídias gravadas com sucesso!");
        input.value = ""; // Limpa o input
      } else {
        console.error("Erro:", data);
        alert(data);
      }
    },
    error: function () {
      alert("Erro na requisição.");
    },
  });
}

function gravarNotaTreino(cod_jogador) {
  var pagina = "/tcc/componentes/TREINO/gravarNotaTreino.php";

  var cod_treino = document.getElementById("cod_treino").value;
  var cod_staff = document.getElementById("cod_staff").value;

  var relogio = document.getElementById("relogio").textContent;
  var grauPrivacidade = document.getElementById("grauPrivacidade").value;
  var descNotaTreino = document.getElementById("descNotaTreino").value;

  let camposObrigatorios = {
    grauPrivacidade: grauPrivacidade,
    descNotaTreino: descNotaTreino,
  };

  let mensagemCamposObrigatorios = {
    grauPrivacidade: "Grau de privacidade.",
    descNotaTreino: "Descrição da nota.",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  // console.log(cod_jogador);
  // console.log(grauPrivacidade);
  // console.log(descNotaTreino);
  // console.log(relogio);
  // console.log(cod_treino);
  // console.log(cod_staff);

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      cod_staff: cod_staff,
      cod_treino: cod_treino,
      relogio: relogio,
      cod_jogador: cod_jogador,
      grauPrivacidade: grauPrivacidade,
      descNotaTreino: descNotaTreino,
    },
    success: function (data) {
      console.log(data);
      if (data == "ok") {
        fecharNotaTreino(cod_jogador);
        alert("Nota de treino gravada.");
      } else {
        alert("Problema na gravação.");
      }
    },
  });
}
