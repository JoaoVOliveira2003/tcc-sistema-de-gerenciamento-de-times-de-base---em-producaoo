function meusDados(cod_usuario,cod_tipoRole){
  var pagina = "/tcc/componentes/MEUSDADOS/meusDados.php";
  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      cod_usuario: cod_usuario,cod_tipoRole:cod_tipoRole
    },
    success: function (data) {
       console.log(data);
      $("#meusDados").html(data);
    }
  });
}

function modalMudarSenha(cod) {
  var pagina = "/tcc/componentes/modalBasico.php";

  var senha = document.getElementById('senha').value;
var valor2 = senha;

  var campoHidden = '<input type="hidden" id="campoSenha" name="campoSenha" value="'+senha+'">';
  var idModal = "mudarSenha";
  var textoBotao = "Confirmar";
  var tituloModal = "Confirmar modificação";
  var funcaoModal = "mudarSenha";
  var textoModal =
    "Você tem certeza que deseja atualizar senha ?";
  var textoBotao = "Mudar";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      campoHidden:campoHidden,
      funcaoModal: funcaoModal,
      textoBotao: textoBotao,
      cod: cod,
      idModal: idModal,
      tituloModal: tituloModal,
      textoModal: textoModal,
      valor2:valor2
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

function mudarSenha(cod_usuario){
 var pagina = "/tcc/componentes/MEUSDADOS/mudarSenha.php";

 var senha = document.getElementById('campoSenha').value;

  let camposObrigatorios = {
    senha: senha,

  };
  let mensagemCamposObrigatorios = {
    senha: "senha",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      senha: senha,
      cod_usuario:cod_usuario
    },
    success: function (data) {
      
      if (data == "ok") {
        alert("Senha atualizados.", "Atenção", "50%", function () {
          location.reload();
        });
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });

}