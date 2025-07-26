// ----------------------------------------------------------------------------------------------------
function gravarStaffadms() {
  var pagina = "/tcc/componentes/STAFFADMS/gravar/gravarStaffAdms.php";

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
  var subinstitucao = document.getElementById("subinstitucao").value;

  let camposObrigatorios = {
    municipio: municipio,
    subinstitucao: subinstitucao,
    nome: nome,
    email: email,
    cpf: cpf,
  };

  let mensagemCamposObrigatorios = {
    municipio: "Municipio de origem do usuário",
    nome: "Nome do usuário",
    email: "Email do usuário",
    cpf: "Cpf do usuário",
    subinstitucao: "Sub-Instituição",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  modalCarregamento();

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      municipio: municipio,
      nome: nome,
      email: email,
      cpf: cpf,
      subinstitucao: subinstitucao,
    },
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
          "Dados de STAFF/ADMS   gravados. Para que o usuário possa se inscrever, ele deve confirmar seus dados pelo e-mail enviado.",
          "Atenção",
          "50%",
          function () {
            location.reload();
          }
        );
      }
    },
    error: function (xhr, status, error) {
      hideLoadingModal();
      console.error("Erro ao gravar dados:", error);
      alert(
        "Ocorreu um erro ao gravar os dados. Verifique a conexão e tente novamente.",
        "Erro"
      );
    },
  });
}

function recusarCadastroStaffAdms(cod) {
  var pagina = "/tcc/componentes/modalBasico.php";

  var idModal = "modalRecusarCadastroStaffAdms";
  var textoBotao = "Excluir";
  var tituloModal = "Confirmar exclusão";
  var funcaoModal = "deletarCadastroStaffAdms";
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

function deletarCadastroStaffAdms(cod) {
  var pagina = "/tcc/componentes/STAFF/deletar/deletarCadastroStaffAdms.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: { cod: cod },
    success: function (data) {
      if (data == "ok") {
        alert("Dados deletados!", "Atenção", "50%", function () {
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
// ----------------------------------------------------------------------------------------------------
