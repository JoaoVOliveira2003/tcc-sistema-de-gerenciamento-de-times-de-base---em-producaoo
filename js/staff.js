// ----------------------------------------------------------------------------------------------------
function gravarStaff() {
  var pagina = "/tcc/componentes/STAFF/gravar/gravarStaff.php";

  let campos = {
    municipio: true,
  };

  let mensagens = {
    municipio: "Município pertencente",
  };

  if (!verificarCampoId(campos, mensagens)) {
    return;
  }

  var municipio = document.getElementById("municipio") ? document.getElementById("municipio").value: "";
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
    municipio: "municipio de origem do usuario",
    nome: "nome do usuario",
    email: "Email do usuario",
    cpf: "Cpf do usuario",
    subinstitucao: "Instituição",
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

      if(data =='emailJaCadastrado'){
            escodendoModalCarregamento();

        alert(
          "Email já cadastrado.",
          "Atenção",
          "50%",
            function () {
                escodendoModalCarregamento();

          }
        );
      }


      if (data == "ok") {
        alert(
          "Dados de STAFF gravados. Para que o usuário possa se inscrever, ele deve confirmar seus dados pelo e-mail enviado.",
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

function verificarCadastroStaff(codPessoa, emailPessoa) {

  var pagina = "/tcc/componentes/Email/verificarCadastroStaff.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: { codPessoa: codPessoa, emailPessoa: emailPessoa },
    dataType: "json",
    success: function (data) {
      if (data.status === "nok1") {
        alert("Erro ao executar a consulta!", "Atenção", "80%", function () {
          window.location.href = "https://www.google.com";
        });
      } else if (data.status === "nok2") {
        alert("Pessoa não existe no sistema!", "Atenção", "80%", function () {
          window.location.href = "https://www.google.com";
        });
      } else if (data.status === "nok3") {
        alert("Cadastro já confirmado!", "Atenção", "80%", function () {
          window.location.href = "https://www.google.com";
        });
      } else if (data.status === "ok") {

        $("#nome").val(data.nome).prop("disabled", true);
        function formatarCPF(cpf) {
          return cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, "$1.$2.$3-$4");
        }

        $("#cpf").val(formatarCPF(data.cpf)).prop("disabled", true);

        $("#nacao").val(data.nacao).prop("disabled", true);
        $("#estado").val(data.estado).prop("disabled", true);
        $("#municipio").val(data.municipio).prop("disabled", true);
        $("#instituicao").val(data.instituicao).prop("disabled", true);

        $("#nacao").prop("disabled", true);
        $("#estado").prop("disabled", true);
        $("#municipio").prop("disabled", true);
        $("#instituicao").prop("disabled", true);

        $("input#email_usuario").val(data.emailPessoa).prop("disabled", true);
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro na requisição:", error);
      alert("Erro na comunicação com o servidor.");
    },
  });
}

function recusarCadastroStaff(cod) {
  var pagina = "/tcc/componentes/modalBasico.php";

  var idModal = "modalRecusarCadastroStaff";
  var textoBotao = "Excluir";
  var tituloModal = "Confirmar Exclusão";
  var funcaoModal = "deletarCadastroStaff";
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

function deletarCadastroStaff(cod) {
  var pagina = "/tcc/componentes/STAFF/deletar/deletarCadastroStaff.php";

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
