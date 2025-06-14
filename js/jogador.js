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
  var input = document.getElementById("imagemJogador");
  var formData = new FormData();
  formData.append("imagemJogador", input.files[0]);

  const pagina = "/tcc/componentes/jogador/gravar/gravarJogador.php";

  // Validação de município
  const campos = { municipio: true };
  const mensagens = { municipio: "Município pertencente" };
  if (!verificarCampoId(campos, mensagens)) return;

  // Validação de posição
  const campos2 = { posicao: true };
  const mensagens2 = { posicao: "Qual é sua posição" };
  if (!verificarCampoId(campos2, mensagens2)) return;

  // Validação dos responsáveis
  const responsaveis = [];
  let responsavelIncompleto = false;

  document
    .querySelectorAll("#responsaveis-container .responsavel")
    .forEach((card) => {
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

  const lesoes = [];
  let lesaoIncompleta = false;

  document.querySelectorAll("#lesoes-container .lesao").forEach((card) => {
    const tipoLesao = card
      .querySelector('select[name="cod_tipoLesao[]"]')
      .value.trim();
    const dataLesao = card
      .querySelector('input[name="data_lesao[]"]')
      .value.trim();
    const tempoFora = card
      .querySelector('input[name="tempoFora_lesao[]"]')
      .value.trim();
    const descLesao = card
      .querySelector('textarea[name="desc_lesao[]"]')
      .value.trim();

    const todosPreenchidos = tipoLesao && dataLesao && tempoFora && descLesao;

    if (todosPreenchidos) {
      lesoes.push({ tipoLesao, dataLesao, tempoFora, descLesao });
    }
  });

  if (lesaoIncompleta) {
    alert("Todos os campos da lesão devem ser preenchidos.");
    return;
  }

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
  const data_nascimento = document.getElementById("data_nascimento").value;
  const municipio = document.getElementById("municipio")?.value || "";
  const nome = document.getElementById("nome").value;
  const email = document.getElementById("email_usuario").value;
  const cpf = document.getElementById("cpf").value;
  const posicao = document.getElementById("posicao").value;
  const imagemJogador = document.getElementById("imagemJogador").value;
  const esporte = document.getElementById("esporte").value;
  const altura = document.getElementById("altura").value;
  const peso = document.getElementById("peso").value;
  const tipo_sanguineo = document.getElementById("tipo_sanguineo").value;
  const restricoes_medicas =
    document.getElementById("restricoes_medicas").value;
  const alergias = document.getElementById("alergias").value;
  const turma = document.getElementById("turma").value;

  const camposObrigatorios = {
    municipio,
    nome,
    email,
    cpf,
    posicao,
    data_nascimento,
    imagemJogador,
    esporte,
    posicao,
    turma,
    altura,
    peso,
    tipo_sanguineo,
    restricoes_medicas,
    alergias,
  };

  const mensagemCamposObrigatorios = {
    municipio: "Município de origem do usuário",
    nome: "Nome do usuário",
    email: "Email do usuário",
    cpf: "CPF do usuário",
    posicao: "Posição",
    data_nascimento: "Data de nascimento",
    imagemJogador: "Imagem do jogador",
    esporte: "Esporte",
    posicao: "Posição",
    altura: "Altura",
    peso: "Peso",
    tipo_sanguineo: "Tipo sanguíneo",
    restricoes_medicas: "Restrições médicas",
    alergias: "Alergias",
    turma: "Turma pertecente",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) return;

  formData.append("municipio", municipio);
  formData.append("nome", nome);
  formData.append("email", email);
  formData.append("cpf", cpf);
  formData.append("posicao", posicao);
  formData.append("data_nascimento", data_nascimento);
  formData.append("esporte", esporte);
  formData.append("altura", altura);
  formData.append("peso", peso);
  formData.append("tipo_sanguineo", tipo_sanguineo);
  formData.append("restricoes_medicas", restricoes_medicas);
  formData.append("alergias", alergias);
  formData.append("turma", turma);

  // Convertendo objetos para JSON e enviando como string
  formData.append("lesoes", JSON.stringify(lesoes));
  formData.append("responsaveis", JSON.stringify(responsaveis));

  modalCarregamento();

  $.ajax({
    url: "/tcc/componentes/jogador/gravar/gravarJogador.php",
    type: "POST",
    data: formData,
    contentType: false,
    processData: false,
    success: function (data) {
      escodendoModalCarregamento();

      if (data == "emailJaCadastrado") {
        escodendoModalCarregamento();

        alert("Email já cadastrado.", "Atenção", "50%", function () {
          escodendoModalCarregamento();
        });
      }

      if (data == "ok") {
        alert(
          "Dados de jogadores foram gravados. Para que o usuário possa se inscrever, ele deve confirmar seus dados pelo e-mail enviado.",
          "Atenção",
          "50%",
          function () {
            location.reload();
          }
        );
      }
    },
    error: function () {
      alert("Erro ao gravar dados do jogador");
    },
  });
}

function verificarCadastroJogador(codPessoa, emailPessoa) {
  var pagina = "/tcc/componentes/Email/verificarCadastroJogador.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: { codPessoa: codPessoa, emailPessoa: emailPessoa },
    dataType: "json",
    success: function (data) {
      if (data.status === "nok1") {
        alert("Erro ao executar a consulta!", "Atenção", "80%", function () {
          // window.location.href = "https://www.google.com";
        });
      } else if (data.status === "nok2") {
        alert("Pessoa não existe no sistema!", "Atenção", "80%", function () {
          // window.location.href = "https://www.google.com";
        });
      } else if (data.status === "nok3") {
        alert("Cadastro já confirmado!", "Atenção", "80%", function () {
          // window.location.href = "https://www.google.com";
        });
      } else if (data.status === "ok") {
        $("#nome").val(data.nome).prop("disabled", true);
        function formatarCPF(cpf) {
          return cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, "$1.$2.$3-$4");
        }

        $("#alergias").val(data.alergias).prop("disabled", true);
        $("#altura").val(data.altura).prop("disabled", true);
        $("#cpf").val(formatarCPF(data.cpf)).prop("disabled", true);
        $("#data_nascimento").val(data.data_nascimento).prop("disabled", true);
        $("#esporte").val(data.cod_esporte).prop("disabled", true);
        $("#estado").val(data.estado).prop("disabled", true);
        $("#imagemJogador").val(data.imagemJogador).prop("disabled", true);
        $("#municipio").val(data.municipio).prop("disabled", true);
        $("#nacao").val(data.nacao).prop("disabled", true);
        $("#peso").val(data.peso).prop("disabled", true);
        $("#posicao").val(data.posicao).prop("disabled", true);
        $("#restricoes_medicas")
          .val(data.restricoes_medicas)
          .prop("disabled", true);
        $("#subinstituicao").val(data.instituicao).prop("disabled", true);
        $("#tipo_sanguineo").val(data.tipo_sanguineo).prop("disabled", true);
        $("#turma").val(data.turma).prop("disabled", true);
        $("#nome_jogador").val("nome").prop("disabled", true);
        $("#email_jogador").val(data.emailPessoa).prop("disabled", true);

        $("#localImagem").attr("src", data.localImagem);

        $("#dadosResponsaveis").html(data.dadosResponsaveis);
        $("#dadosLesoes").html(data.dadosLesoes);

        $("input#email_usuario").val(data.emailPessoa).prop("disabled", true);
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro na requisição:", error);
      alert("Erro na comunicação com o servidor.");
    },
  });
}

function recusarCadastroJOGADOR(cod) {
  var pagina = "/tcc/componentes/modalBasico.php";

  var idModal = "modalRecusarCadastroJOGADOR";
  var textoBotao = "Excluir";
  var tituloModal = "Confirmar Exclusão";
  var funcaoModal = "deletarCadastroJOGADOR";
  var textoModal = "Você tem certeza que deseja negar o cadastro ?";
  var textoBotao = "Recusar";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      funcaoModal: funcaoModal,
      textoBotao: textoBotao,
      cod: cod,
      idModal: idModal,
      tituloModal: tituloModal,
      textoModal: textoModal,
    },
    success: function (data) {
      $("#modalContainer").html(data);

      var modalElement = $("#" + idModal);
      modalElement.modal("show");

      modalElement.attr("aria-hidden", "false");

      $("#cancelarModal").on("click", function () {
        modalElement.modal("hide");
      });

      $("#funcaoDoModal").on("click", function () {
        modalElement.modal("hide");
      });
    },
    error: function (xhr, status, error) {
      console.error("Erro ao carregar os dados do estado:", error);
    },
  });
}

function deletarCadastroJOGADOR(cod) {
  var pagina = "/tcc/componentes/JOGADOR/deletar/deletarCadastroJOGADOR.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: { cod: cod },
    success: function (data) {
      if (data == "ok") {
        alert("Dados deletados!", "Atenção", "80%", function () {
          window.location.href = "https://www.google.com";
        });
      } else if (data == "nok") {
        alert(
          "Remoção incompleta,caso problema continuar,chame o suporte.",
          "Atenção",
          "50%",
          function () {
            location.reload();
          }
        );
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });
}

function listaTodosJogadores(cod_role, cod_usuario) {
  var pagina = "/tcc/componentes/JOGADOR/listaTodosJogadores.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: { cod_role: cod_role, cod_usuario: cod_usuario },
    success: function (data) {
      $("#todosJogadores").html(data);
    },
  });
}



 function vizualizarDadosJogador(cod_jogador) {
  var pagina = "/tcc/componentes/JOGADOR/modalDadosJogador.php";
  var idModal = "modalDadosJOGADOR";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      cod_jogador: cod_jogador,
      idModal:idModal,
    },
    success: function (data) {

      $("#modalContainer").html(data);

      // Usa a variável idModal definida no PHP via script
      var modalElement = $("#" + idModal);
      modalElement.modal("show");

      // Fecha com botão cancelar
      $("#cancelarModal").on("click", function () {
        modalElement.modal("hide");
      });

      // Fecha com o botão de ação
      $("#funcaoDoModal").on("click", function () {
        modalElement.modal("hide");
      });
    },
    error: function () {
      // Fecha o carregando mesmo em caso de erro
      $("#modalCarregando").modal("hide");
      alert("Erro ao carregar os dados do jogador.");
    }
  });
}


function abrirModalAtualizarNota(){
      const modal2 = new bootstrap.Modal(document.getElementById('modal2'));
      modal2.show();
}

function adicionarNota(cod_jogador){
  var cod_jogador = document.getElementById('novaNota').value;

  console.log(cod_jogador);
}