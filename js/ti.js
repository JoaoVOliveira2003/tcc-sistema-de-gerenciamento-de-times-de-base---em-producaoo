// gravar algo
function gravarEstado() {
  var pagina = "/tcc/componentes/TI/gravar/gravarEstado.php";

  var nacao = document.getElementById("nacao").value;
  var desc_estado = document.getElementById("desc_estado").value;
  var sigla_estado = document.getElementById("sigla_estado").value;

  let camposObrigatorios = {
    nacao: nacao,
    desc_estado: desc_estado,
    sigla_estado: sigla_estado,
  };

  let mensagemCamposObrigatorios = {
    nacao: "Nação pertencente",
    desc_estado: "Nome do estado",
    sigla_estado: "Sigla do estado",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      nacao: nacao,
      desc_estado: desc_estado,
      sigla_estado: sigla_estado,
    },
    success: function (data) {
      if (data == "ok") {
        alert("Dados gravados.", "Atenção", "50%", function () {
          location.reload();
        });
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });
}

function gravarMunicipio() {
  var pagina = "/tcc/componentes/TI/gravar/gravarMunicipio.php";

  var estado = document.getElementById("estado").value;
  var desc_municipio = document.getElementById("desc_municipio").value;
  var sigla_municipio = document.getElementById("sigla_municipio").value;

  let camposObrigatorios = {
    estado: estado,
    desc_municipio: desc_municipio,
    sigla_municipio: sigla_municipio,
  };

  let mensagemCamposObrigatorios = {
    estado: "estado pertencente",
    desc_municipio: "Nome do municipio",
    sigla_emunicipio: "Sigla do municipio",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      estado: estado,
      desc_municipio: desc_municipio,
      sigla_municipio: sigla_municipio,
    },
    success: function (data) {
      if (data == "ok") {
        alert("Dados gravados.", "Atenção", "50%", function () {
          location.reload();
        });
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });
}

function gravarInstituicao() {
  var pagina = "/tcc/componentes/TI/gravar/gravarInstituicao.php";

  var tipoInstituicao = document.getElementById("tipoInstituicao").value;
  var desc_instituicao = document.getElementById("desc_instituicao").value;

  let camposObrigatorios = {
    tipoInstituicao: tipoInstituicao,
    desc_instituicao: desc_instituicao,
  };

  let mensagemCamposObrigatorios = {
    tipoInstituicao: "Tipo de instituicao ",
    desc_instituicao: "Nome da instituicao",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      tipoInstituicao: tipoInstituicao,
      desc_instituicao: desc_instituicao,
    },
    success: function (data) {
      if (data == "ok") {
        alert("Dados gravados.", "Atenção", "50%", function () {
          location.reload();
        });
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });
}

function gravarNacao() {
  var pagina = "/tcc/componentes/TI/gravar/gravarNacao.php";

  var desc_nacao = document.getElementById("desc_nacao").value;
  var sigla_nacao = document.getElementById("sigla_nacao").value;

  let camposObrigatorios = {
    desc_nacao: desc_nacao,
    sigla_nacao: sigla_nacao,
  };
  let mensagemCamposObrigatorios = {
    desc_nacao: "Nome da nacão",
    sigla_nacao: "Sigla da nacão",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: { desc_nacao: desc_nacao, sigla_nacao: sigla_nacao },
    success: function (data) {
      if (data == "ok") {
        alert("Dados gravados.", "Atenção", "50%", function () {
          location.reload();
        });
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });
}

function gravarTI() {
  var pagina = "/tcc/componentes/TI/gravar/gravarTI.php";

  // Verificação de campos obrigatórios
  let campos = {
    municipio: true,
  };

  let mensagens = {
    municipio: "Município pertencente",
  };

  if (!verificarCampoId(campos, mensagens)) {
    return;
  }

  var municipio = document.getElementById("municipio")
    ? document.getElementById("municipio").value
    : "";
  var nome = document.getElementById("nome").value;
  var email = document.getElementById("email_usuario").value;
  var cpf = document.getElementById("cpf").value;

  let camposObrigatorios = {
    municipio: municipio,
    nome: nome,
    email: email,
    cpf: cpf,
  };

  let mensagemCamposObrigatorios = {
    municipio: "municipio de origem do usuario",
    nome: "nome do usuario",
    email: "Email do usuario",
    cpf: "Cpf do usuario",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  modalCarregamento();

  $.ajax({
    type: "POST",
    url: pagina,
    data: { municipio: municipio, nome: nome, email: email, cpf: cpf },
    success: function (data) {
      escodendoModalCarregamento();

      if (data == "ok") {
        alert(
          "Dados de TI gravados. Para que o usuário possa se inscrever, ele deve confirmar seus dados pelo e-mail enviado.",
          "Atenção",
          "50%",
          function () {
            location.reload();
          }
        );
      }
    },
    error: function (xhr, status, error) {
      hideLoadingModal(); // Esconde o modal de carregamento
      console.error("Erro ao gravar dados:", error);
      alert(
        "Ocorreu um erro ao gravar os dados. Verifique a conexão e tente novamente.",
        "Erro"
      );
    },
  });
}

//tabelas de atualizar e deletar
function tabelaDeleteUpdateMunicipio() {
  var pagina = "/tcc/componentes/tabelaDeleteUpdate.php";

  var query =
    "SELECT mun.cod_municipio, mun.desc_municipio, est.desc_estado, mun.sigla_municipio FROM municipio mun INNER JOIN estado est ON est.cod_estado = mun.cod_estado ORDER BY est.cod_estado;";

  let titulosTh = {
    valor1: "Código municipio",
    valor2: "Estado",
    valor3: "Municipio",
    valor4: "Sigla",
    valor5: "Ações",
  };

  let styleTh = {
    valor1: "width: 20%;",
    valor2: "width: 20%;",
    valor3: "width: 30%;",
    valor4: "width: 10%;",
    valor5: "width: 20%;",
  };

  let variavelTd = {
    valor1: "cod_municipio",
    valor2: "desc_estado",
    valor3: "desc_municipio",
    valor4: "sigla_municipio",
  };

  let botoesTd = {
    valor1:
      '<button type="button" class="btn btn-secondary btn-sm" onclick="modalAtualizarMunicipio($cod_municipio)">Atualizar</button>',
    valor2:
      '<button type="button" class="btn btn-secondary btn-sm" onclick="modalDeletarMunicipio($cod_municipio)">Deletar</button>',
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

function tabelaDeleteUpdateEstados() {
  var pagina = "/tcc/componentes/tabelaDeleteUpdate.php";

  var query =
    "SELECT est.cod_estado, nac.desc_nacao, est.desc_estado, est.sigla_estado FROM estado est INNER JOIN nacao nac ON est.cod_nacao = nac.cod_nacao ORDER BY est.cod_nacao";
  let titulosTh = {
    valor1: "Código Estado",
    valor2: "Nação",
    valor3: "Estado",
    valor4: "Sigla",
    valor5: "Ações",
  };

  let styleTh = {
    valor1: "width: 10%;",
    valor2: "width: 30%;",
    valor3: "width: 30%;",
    valor4: "width: 10%;",
    valor5: "width: 20%;",
  };

  let variavelTd = {
    valor1: "cod_estado",
    valor2: "desc_nacao",
    valor3: "desc_estado",
    valor4: "sigla_estado",
  };

  let botoesTd = {
    valor1:
      '<button type="button" class="btn btn-secondary btn-sm" onclick="modalAtualizarEstado($cod_estado)">Atualizar</button>',
    valor2:
      '<button type="button" class="btn btn-secondary btn-sm" onclick="modalDeletarEstado($cod_estado)">Deletar</button>',
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

function tabelaDeleteUpdateNacao() {
  var pagina = "/tcc/componentes/tabelaDeleteUpdate.php";

  var query = "SELECT cod_nacao, desc_nacao, sigla_nacao FROM nacao;";

  let titulosTh = {
    valor1: "Código nacao",
    valor2: "Nação",
    valor4: "Sigla",
    valor5: "Acao",
  };

  let styleTh = {
    valor1: "width: 33%;",
    valor2: "width: 33%;",
    valor3: "width: 33%;",
  };

  let variavelTd = {
    valor1: "cod_nacao",
    valor2: "desc_nacao",
    valor3: "sigla_nacao",
  };

  let botoesTd = {
    valor1:
      '<button type="button" class="btn btn-secondary btn-sm" onclick="modalAtualizarNacao($cod_nacao)">Atualizar</button>',
    valor2:
      '<button type="button" class="btn btn-secondary btn-sm" onclick="modalDeletarNacao($cod_nacao)">Deletar</button>',
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

function tabelaDeleteUpdateInstituicao() {
  var pagina = "/tcc/componentes/tabelaDeleteUpdate.php";
  var query =
    "SELECT inst.cod_instituicao, inst.ativo,tinst.desc_tipo_instituicao, inst.desc_instituicao, inst.cod_tipo_instituicao FROM instituicao inst INNER JOIN tipo_instituicao tinst ON inst.cod_tipo_instituicao = tinst.cod_tipo_instituicao ORDER BY inst.cod_tipo_instituicao;";

  let titulosTh = {
    valor1: "Cod Instituicao",
    valor3: "Tipo instituicao",
    valor4: "Istituicao",
    valor2: "Ativo",
    valor5: "Açoes",
  };

  let styleTh = {
    valor1: "10%",
    valor2: "25%",
    valor3: "30%",
    valor4: "20%",
    valor5: "20%",
  };

  let variavelTd = {
    valor1: "cod_instituicao",
    valor3: "desc_tipo_instituicao",
    valor4: "desc_instituicao",
    valor2: "ativo",
  };

  let botoesTd = {
    valor1:
      '<button type="button" class="btn btn-secondary btn-sm" onclick="modalAtualizarInstituicao($cod_instituicao)">Atualizar</button>',
    valor2:
      '<button type="button" class="btn btn-secondary btn-sm" onclick="modalDeletarInstituicao($cod_instituicao)">Deletar</button>',
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
function modalDeletarEstado(cod) {
  var pagina = "/tcc/componentes/modalBasico.php";

  var idModal = "modalDeletarEstado";
  var textoBotao = "Excluir";
  var tituloModal = "Confirmar Exclusão";
  var funcaoModal = "deletarEstado";
  var textoModal =
    "Você tem certeza que deseja excluir o estado com código = " + cod + "?";
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

function modalDeletarNacao(cod) {
  var pagina = "/tcc/componentes/modalBasico.php";

  var idModal = "modalDeletarEstado";
  var textoBotao = "Excluir";
  var tituloModal = "Confirmar Exclusão";
  var funcaoModal = "deletarNacao";
  var textoModal =
    "Você tem certeza que deseja excluir a nacão com código = " + cod + "?";
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

function modalDeletarInstituicao(cod) {
  var pagina = "/tcc/componentes/modalBasico.php";

  var idModal = "modalDeletarInstituicao";
  var textoBotao = "Excluir";
  var tituloModal = "Confirmar Exclusão";
  var funcaoModal = "deletarInstituicao";
  var textoModal =
    "Você tem certeza que deseja excluir a Instituicao com código = " +
    cod +
    "?";
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

function modalDeletarMunicipio(cod) {
  var pagina = "/tcc/componentes/modalBasico.php";

  var idModal = "modalDeletarMunicipio";
  var textoBotao = "Excluir";
  var tituloModal = "Confirmar Exclusão";
  var funcaoModal = "deletarMunicipio";
  var textoModal =
    "Você tem certeza que deseja excluir o municipio do código = " + cod + "?";
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
function deletarEstado(cod_estado) {
  var pagina = "/tcc/componentes/ti/deletar/deletarEstado.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: { cod_estado: cod_estado },
    success: function (data) {
      if (data == "ok") {
        alert("Dados deletados.", "Atenção", "50%", function () {
          location.reload();
        });
      } else if (data == "nok") {
        alert(
          "Remoção incompleta,caso estado tenha algum muinicipio,negada a remoção.",
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

function deletarMunicipio(cod) {
  var pagina = "/tcc/componentes/ti/deletar/deletarMunicipio.php";

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
          "Remoção incompleta,caso estado tenha algum muinicipio,negada a remoção.",
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

function deletarNacao(cod) {
  var pagina = "/tcc/componentes/ti/deletar/deletarNacao.php";

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
          "Remoção incompleta,caso nacão tenha algum estado,negada a remoção.",
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

function deletarInstituicao(cod) {
  var pagina = "/tcc/componentes/ti/deletar/deletarInstituicao.php";

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
          "Remoção incompleta,caso Instituicao tenha algum Sub-Instituicao, negada a remoção.",
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

// função de atualizar
function atualizarEstado(cod_estado) {
  var pagina = "/tcc/componentes/TI/atualizar/atualizarEstado.php";

  var nacao = document.getElementById("atualilizacaoNacao").value;
  var desc_estado = document.getElementById("atualizacaoDesc_estado").value;
  var sigla_estado = document.getElementById("atualizacaoSigla_estado").value;

  let camposObrigatorios = {
    nacao: nacao,
    desc_estado: desc_estado,
    sigla_estado: sigla_estado,
  };
  let mensagemCamposObrigatorios = {
    desc_nacao: "Nacão",
    desc_estado: "desc_estado",
    sigla_estado: "sigla_estado",
  };
  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      cod_estado: cod_estado,
      nacao: nacao,
      desc_estado: desc_estado,
      sigla_estado: sigla_estado,
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

function atualizarMunicipio(cod) {
  var pagina = "/tcc/componentes/TI/atualizar/atualizarMunicipio.php";

  var cod_estado = document.getElementById("atualilizacaoEstado").value;
  var desc_municipio = document.getElementById(
    "atualizacaoDesc_municipio"
  ).value;
  var sigla_municipio = document.getElementById(
    "atualizacaoSigla_municipio"
  ).value;

  let camposObrigatorios = {
    cod_estado: cod_estado,
    desc_municipio: desc_municipio,
    sigla_municipio: sigla_municipio,
  };
  let mensagemCamposObrigatorios = {
    cod_estado: "estado",
    desc_municipio: "desc_municipio",
    sigla_municipio: "sigla_municipio",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      cod: cod,
      cod_estado: cod_estado,
      desc_municipio: desc_municipio,
      sigla_municipio: sigla_municipio,
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

function atualizarNacao(cod_nacao) {
  var pagina = "/tcc/componentes/TI/atualizar/atualizarNacao.php";

  var desc_nacao = document.getElementById("atualizacaoDesc_nacao").value;
  var sigla_nacao = document.getElementById("atualizacaoSigla_nacao").value;

  let camposObrigatorios = {
    desc_nacao: desc_nacao,
    sigla_nacao: sigla_nacao,
  };
  let mensagemCamposObrigatorios = {
    desc_nacao: "Nome da nacão",
    sigla_nacao: "Sigla da nacão",
  };
  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      cod_nacao: cod_nacao,
      desc_nacao: desc_nacao,
      sigla_nacao: sigla_nacao,
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

function atualizarInstituicao(cod) {
  var pagina = "/tcc/componentes/TI/atualizar/atualizarInstituicao.php";

  var desc_instituicao = document.getElementById(
    "atualizacaoDesc_instituicao"
  ).value;
  var atualizacaoAtivo_instituicao = document.getElementById(
    "atualizacaoAtivo_instituicao"
  ).value;
  var atualizacaoTipoInstituicao = document.getElementById(
    "atualizacaoTipoInstituicao"
  ).value;

  let camposObrigatorios = {
    atualizacaoTipoInstituicao: atualizacaoTipoInstituicao,
    desc_instituicao: desc_instituicao,
    atualizacaoAtivo_instituicao: atualizacaoAtivo_instituicao,
  };
  let mensagemCamposObrigatorios = {
    atualizacaoTipoInstituicao: "Tipo da instituição",
    desc_instituicao: "Nome da instituição",
    atualizacaoAtivo_instituicao: "Ativo",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      cod: cod,
      atualizacaoAtivo_instituicao: atualizacaoAtivo_instituicao,
      desc_instituicao: desc_instituicao,
      atualizacaoTipoInstituicao: atualizacaoTipoInstituicao,
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

//modais de deletar
async function modalAtualizarEstado(cod_estado) {
  var pagina = "/tcc/componentes/TI/modalAtualizar/modalAtualizarEstado.php";

  var query = "select cod_nacao from estado where cod_estado = " + cod_estado;
  var valorProcurado = "cod_nacao";
  var select = await acharPai(query, valorProcurado);

  var idModal = "modalAtualizacaoEstado";
  var tituloModal = "Confirmar Atualizacao";
  var funcaoModal = "atualizarEstado";
  var textoBotao = "Atualizar";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      funcaoModal: funcaoModal,
      textoBotao: textoBotao,
      cod_estado: cod_estado,
      idModal: idModal,
      tituloModal: tituloModal,
    },
    success: function (data) {
      $("#modalContainer").html(data);

      var modalElement = $("#" + idModal);
      modalElement.modal("show");
      modalElement.attr("aria-hidden", "false");

      selectNacoesAtualizarEstado(select);

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

async function modalAtualizarNacao(cod) {
  var pagina = "/tcc/componentes/TI/modalAtualizar/modalAtualizarNacao.php";

  var idModal = "modalAtualizacaoNacao";
  var tituloModal = "Confirmar Atualizacao";
  var funcaoModal = "atualizarNacao";
  var textoBotao = "Atualizar";

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

async function modalAtualizarMunicipio(cod) {
  var pagina = "/tcc/componentes/TI/modalAtualizar/modalAtualizarMunicipio.php";

  var idModal = "modalAtualizacaoMunicipio";
  var tituloModal = "Confirmar Atualizacao";
  var funcaoModal = "atualizarMunicipio";
  var textoBotao = "Atualizar";

  var query = "select cod_estado from municipio where cod_municipio = " + cod;
  var valorProcurado = "cod_estado";
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

      selectEstadoAtualizarMunicipio(select);

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

async function modalAtualizarInstituicao(cod) {
  var pagina =
    "/tcc/componentes/TI/modalAtualizar/modalAtualizarInstituicao.php";

  var idModal = "modalAtualizarInstituicao";
  var tituloModal = "Confirmar Atualizacao";
  var funcaoModal = "atualizarInstituicao";
  var textoBotao = "Atualizar";

  var query =
    "select cod_tipo_instituicao from instituicao where cod_instituicao = " +
    cod;
  var valorProcurado = "cod_tipo_instituicao";
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

      selecionarTipoInstituicaoSelecionado(select);

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
function selectNacoesAtualizarEstado(select) {
  var pagina = "/tcc/componentes/selectBasico.php";

  var query = "SELECT cod_nacao, desc_nacao FROM nacao";
  var codSelect = "cod_nacao";
  var descSelect = "desc_nacao";
  var label = "Pertencente a:";
  var classLabel = "form-label";
  var forLabel = "atualilizacaoNacao";
  var classSelect = "form-control";
  var idSelect = "atualilizacaoNacao";
  var name = "atualilizacaoNacao";
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
      $("#selectNacoesAtualizarEstado").html(data);
    },
  });
}

function selectEstadoAtualizarMunicipio(select) {
  var pagina = "/tcc/componentes/selectBasico.php";

  var query = "SELECT cod_estado, desc_estado FROM estado";
  var codSelect = "cod_estado";
  var descSelect = "desc_estado";
  var label = "Pertencente a:";
  var classLabel = "form-label";
  var forLabel = "atualilizacaoEstado";
  var classSelect = "form-control";
  var idSelect = "atualilizacaoEstado";
  var name = "atualilizacaoEstado";
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
      $("#selectEstadoAtualizarMunicipio").html(data);
    },
  });
}

function selecionarTipoInstituicaoSelecionado(select) {
  var pagina = "/tcc/componentes/selectBasico.php";

  var query =
    "SELECT cod_tipo_instituicao, desc_tipo_instituicao FROM tipo_instituicao";
  var codSelect = "cod_tipo_instituicao";
  var descSelect = "desc_tipo_instituicao";
  var label = "Tipo de instituição a:";
  var classLabel = "form-label";
  var forLabel = "atualizacaoTipoInstituicao";
  var classSelect = "form-control mb-2";
  var idSelect = "atualizacaoTipoInstituicao";
  var name = "atualizacaoTipoInstituicao";
  var primeiroOption = "Escolha uma opção";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      query: query,
      codSelect: codSelect,
      descSelect: descSelect,
      select: select,
      label: label,
      classLabel: classLabel,
      forLabel: forLabel,
      classSelect: classSelect,
      idSelect: idSelect,
      name: name,
      primeiroOption: primeiroOption,
    },
    success: function (data) {
      $("#selectEstadoAtualizarInstituicao").html(data);
    },
  });
}
