$(document).ready(function () {});

function gravarTurma() {
  var pagina = "/tcc/componentes/ADMS/gravar/gravarTurma.php";

  var turma = document.getElementById("desc_turma").value;
  var sub_instituto = document.getElementById("subinstitucao").value;

  console.log("subinstitucao: " + sub_instituto);

  let camposObrigatorios = {
    sub_instituto: sub_instituto,
    turma: turma,
  };

  let mensagemCamposObrigatorios = {
    sub_instituto: "Sub instituto pertencente",
    turma: "Nome do turma",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      sub_instituto: sub_instituto,
      turma: turma,
    },
    success: function (data) {
      console.log("Resposta do servidor:", data);
      if (data == "ok") {
        alert("Dados gravados.", "Atenção", "50%", function () {
          location.reload();
        });
      } else {
        alert("Erro ao gravar os dados.", "Atenção", "50%");
      }
    },
  });
}

function tabelaDeleteUpdateTurma() {
  var pagina = "/tcc/componentes/tabelaDeleteUpdate.php";

  var query =
    "SELECT tur.cod_turma, tur.desc_turma, tur.ativo, sub.desc_subInstituicao FROM turma tur INNER JOIN subinstituicao sub ON sub.cod_subInstituicao = tur.cod_subInstituicao;";

  let titulosTh = {
    valor1: "Cod. turma",
    valor2: "Turma",
    valor5: "Sub Instituicao",
    valor3: "Ativo",
    valor6: "Ações",
  };

  let styleTh = {
    valor1: "width: 15%;",
    valor2: "width: 20%;",
    valor3: "width: 10%;",
    valor4: "width: 10%;",
    valor5: "width: 30%;",
  };

  let variavelTd = {
    valor1: "cod_turma",
    valor2: "desc_turma",
    valor4: "desc_subInstituicao",
    valor3: "ativo",
  };

  let botoesTd = {
    valor1:
      '<button type="button" class="btn btn-secondary btn-sm" onclick="modalAtualizarTurma($cod_turma)">Atualizar</button>',
    valor2:
      '<button type="button" class="btn btn-secondary btn-sm" onclick="modalDeletarTurma($cod_turma)">Deletar</button>',
  };

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      query: query,
      titulosTh: JSON.stringify(titulosTh),
      styleTh: JSON.stringify(styleTh),
      variavelTd: JSON.stringify(variavelTd),
      botoesTd: JSON.stringify(botoesTd),
    },
    success: function (data) {
      $("#tabelaDeleteUpdate").html(data);
    },
  });
}

//modal de deletar
function modalDeletarTurma(cod) {
  var pagina = "/tcc/componentes/modalBasico.php";

  var idModal = "modalTurma";
  var textoBotao = "Excluir";
  var tituloModal = "Confirmar Exclusão";
  var funcaoModal = "deletarTurma";
  var textoModal =
    "Você tem certeza que deseja excluir a Turma com código = " + cod + "?";
  var textoBotao = "Deletar";

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

//função de deletar
function deletarTurma(cod) {
  var pagina = "/tcc/componentes/adms/deletar/deletarTurma.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: { cod: cod },
    success: function (data) {
      if (data == "ok") {
        alert("Dados deletados.", "Atenção", "50%", function () {
          location.reload();
        });
      } else if (data == "nok") {
        alert(
          "Remoção incompleta,caso estado tenha alguma turma, negada a remoção.",
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

async function modalAtualizarTurma(cod) {
  var pagina = "/tcc/componentes/adms/modalAtualizar/modalAtualizarTurma.php";

  var idModal = "modalAtualizarTurma";
  var tituloModal = "Confirmar Atualizacao";
  var funcaoModal = "atualizarTurma";
  var textoBotao = "Atualizar";

  var query = "select cod_subinstituicao from turma where cod_turma = " + cod;
  var valorProcurado = "cod_subinstituicao";
  var select = await acharPai(query, valorProcurado);

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      funcaoModal: funcaoModal,
      textoBotao: textoBotao,
      cod: cod,
      idModal: idModal,
      tituloModal: tituloModal,
    },
    success: function (data) {
      $("#modalContainer").html(data);

      var modalElement = $("#" + idModal);
      modalElement.modal("show");
      modalElement.attr("aria-hidden", "false");

      selecionarSubInstituicaoSelecionado(select);

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

//selects da tela
function selecionarSubInstituicaoSelecionado(select) {
  var pagina = "/tcc/componentes/selectBasico.php";

  var query =
    "SELECT cod_subinstituicao, desc_subinstituicao FROM subinstituicao";
  var codSelect = "cod_subinstituicao";
  var descSelect = "desc_subinstituicao";
  var label = "Pertencente a:";
  var classLabel = "form-label";
  var forLabel = "atualilizacaoSubIntituicao";
  var classSelect = "form-control";
  var idSelect = "atualilizacaoSubIntituicao";
  var name = "atualilizacaoSubIntituicao";
  var primeiroOption = "Escolha uma opção";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      select: select,
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
      $("#selecionarSubInstituicaoSelecionado").html(data);
    },
  });
}

function atualizarTurma(cod) {
  var pagina = "/tcc/componentes/adms/atualizar/atualizarTurma.php";

  var subIntituicao = document.getElementById(
    "atualilizacaoSubIntituicao"
  ).value;
  var turma = document.getElementById("atualizacaoDesc_turma").value;
  var ativo = document.getElementById("atualizacaoAtivo_subTurma").value;

  let camposObrigatorios = {
    subIntituicao: subIntituicao,
    turma: turma,
    ativo: ativo,
  };

  let mensagemCamposObrigatorios = {
    subIntituicao: "Sub. Intituicao",
    turma: "Nome da turma",
    ativo: "Status (Ativo)",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      cod: cod,
      subIntituicao: subIntituicao,
      turma: turma,
      ativo: ativo,
    },

    success: function (data) {
      if (data == "ok") {
        alert("Dados atualizados.", "Atenção", "50%", function () {
          location.reload();
        });
      } else if (data == "nok") {
        alert("atualização incompleta", "Atenção", "50%", function () {
          location.reload();
        });
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });
}
