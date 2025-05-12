function selectTipoLesao() {
  var pagina = "/tcc/componentes/selectBasico.php";

  var query = "select cod_tipoLesao,desc_tipoLesao from tipo_lesao";
  var codSelect = "cod_tipoLesao";
  var descSelect = "desc_tipoLesao";
  var label = "Tipo lesão:";
  var classLabel = "form-label";
  var forLabel = "tipo_lesao";
  var classSelect = "form-control";
  var idSelect = "tipo_lesao";
  var name = "tipo_lesao";
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
      $("#tipo_lesao").html(data);
    },
  });
}

function gravarJogador() {
  var pagina = "/tcc/componentes/jogador/gravar/gravarJogador.php";

  let campos = { municipio: true };
  let mensagens = { municipio: "Município pertencente" };
  if (!verificarCampoId(campos, mensagens)) return;

  let campos2 = { posicao: true };
  let mensagens2 = { posicao: "Qual é sua posição" };
  if (!verificarCampoId(campos2, mensagens2)) return;

  const responsaveis = [];
  let responsavelIncompleto = false;

  document
    .querySelectorAll("#responsaveis-container .responsavel")
    .forEach(function (card) {
      const nome = card
        .querySelector('input[name="responsavel_nome[]"]')
        .value.trim();
      const filiacao = card
        .querySelector('select[name="responsavel_filiacao[]"]')
        .value.trim();
      const email = card
        .querySelector('input[name="responsavel_email[]"]')
        .value.trim();
      const telefone = card
        .querySelector('input[name="responsavel_telefone[]"]')
        .value.trim();

      const todosPreenchidos = nome && filiacao && email && telefone;
      const algumPreenchido = nome || filiacao || email || telefone;

      if (todosPreenchidos) {
        responsaveis.push({ nome, filiacao, email, telefone });
      } else if (algumPreenchido) {
        responsavelIncompleto = true;
      }
    });

  if (responsavelIncompleto) {
    alert("Todos os campos do responsável devem ser preenchidos.");
    return;
  }

  if (responsaveis.length === 0) {
    alert(
      "É necessário informar pelo menos um responsável com todos os campos preenchidos."
    );
    return;
  }

  // Captura dos demais campos
  var data_nascimento = document.getElementById("dataNascimento").value;
  var municipio = document.getElementById("municipio")?.value || "";
  var nome = document.getElementById("nome").value;
  var email = document.getElementById("email_usuario").value;
  var cpf = document.getElementById("cpf").value;
  var posicao = document.getElementById("posicao").value;
  var imagemJogador = document.getElementById("imagemJogador").value;
  var selectEsporte = document.getElementById("selectEsporte").value;
  var selectPosicao = document.getElementById("selectPosicao").value;
  var altura = document.getElementById("altura").value;
  var peso = document.getElementById("peso").value;
  var tipo_sanguineo = document.getElementById("tipo_sanguineo").value;
  var restricoes_medicas = document.getElementById("restricoes_medicas").value;
  var alergias = document.getElementById("alergias").value;

  // Validação de campos obrigatórios
  let camposObrigatorios = {
    municipio,
    nome,
    email,
    cpf,
    posicao,
    data_nascimento,
    imagemJogador,
    selectEsporte,
    selectPosicao,
    altura,
    peso,
    tipo_sanguineo,
    restricoes_medicas,
    alergias,
  };

  let mensagemCamposObrigatorios = {
    municipio: "Município de origem do usuário",
    nome: "Nome do usuário",
    email: "Email do usuário",
    cpf: "CPF do usuário",
    posicao: "Posição",
    data_nascimento: "Data de nascimento",
    imagemJogador: "Imagem do jogador",
    selectEsporte: "Esporte",
    selectPosicao: "Posição",
    altura: "Altura",
    peso: "Peso",
    tipo_sanguineo: "Tipo sanguíneo",
    restricoes_medicas: "Restrições médicas",
    alergias: "Alergias",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) return;

  $.ajax({
    url: pagina,
    type: "POST",
    data: {
      municipio: municipio,
      nome: nome,
      email: email,
      cpf: cpf,
      posicao: posicao,
      data_nascimento: data_nascimento,
      imagemJogador: imagemJogador,
      selectEsporte: selectEsporte,
      selectPosicao: selectPosicao,
      altura: altura,
      peso: peso,
      tipo_sanguineo: tipo_sanguineo,
      restricoes_medicas: restricoes_medicas,
      alergias: alergias,
    },
    contentType: false,
    processData: false,
    success: function (data) {
      alert(data);
    },
    error: function () {
      alert("Erro ao gravar a imagem");
    },
  });
}

function gravarImagemJogador() {
  var pagina = "/tcc/componentes/jogador/gravar/gravarImagemJogador.php";

  var input = document.getElementById("imagemJogador");
  var formData = new FormData();
  formData.append("imagemJogador", input.files[0]);

  $.ajax({
    url: pagina,
    type: "POST",
    data: formData,
    contentType: false,
    processData: false,
    success: function (resposta) {
      alert(resposta);
    },
    error: function () {
      alert("Erro ao gravar a imagem");
    },
  });
}
