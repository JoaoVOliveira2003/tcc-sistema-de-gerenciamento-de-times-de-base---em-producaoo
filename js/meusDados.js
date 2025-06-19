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

function modalMudarDadoFichaMedica(cod){
var pagina = "/tcc/componentes/modalBasico.php";

  var altura   = document.getElementById('altura').value;
  var peso     = document.getElementById('peso').value;
  var alergias = document.getElementById('alergias').value;
  var restricoesMedicas = document.getElementById('restricoesMedicas').value;

  var campoHidden = '<input type="hidden" id="campoDados" name="campoDados" value="'+altura+'|'+peso+'|'+alergias+'|'+restricoesMedicas+'">';
  var idModal = "mudarDadoFichaMedica";
  var textoBotao = "Confirmar";
  var tituloModal = "Confirmar modificação";
  var funcaoModal = "mudarDadoFichaMedica";
  var textoModal =
    "Você tem certeza que deseja atualizar dados da ficha medica ?";
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

function mudarDadoFichaMedica(cod_usuario){
var pagina = "/tcc/componentes/MEUSDADOS/mudarDadoFichaMedica.php";

 var campoDados = document.getElementById('campoDados').value;
 var dados = campoDados.split('|');
  var altura = dados[0];
  var peso = dados[1];
  var alergias = dados[2];
  var restricoesMedicas = dados[3];

  let camposObrigatorios = {
    altura: altura,
    alergias:alergias,
    peso:peso,
    restricoesMedicas:restricoesMedicas,
  };

  let mensagemCamposObrigatorios = {
    senha: "senha",
    alergias:"Alergias",
    peso:"Peso",
    restricoesMedicas:"Restriçoes medicas"
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
    altura: altura,
    cod_usuario:cod_usuario,
    alergias:alergias,
    peso:peso,
    restricoesMedicas:restricoesMedicas
    },
    success: function (data) {
      
      if (data == "ok") {
        alert("Dados atualizados.", "Atenção", "50%", function () {
          location.reload();
        });
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });
}
// --------------
async function modalAtualizarLesoes(cod) {
  var pagina = "/tcc/componentes/MEUSDADOS/modalAtualizarLesoes.php";

  var idModal = "modalAtualizarLesoes";
  var tituloModal = "Confirmar Atualizacao";
  var funcaoModal = "atualizarLesao";
  var textoBotao = "Atualizar";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      funcaoModal: funcaoModal,
      textoBotao: textoBotao,
      idModal: idModal,
      tituloModal: tituloModal,
      cod:cod
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

function atualizarLesao(cod){
  var pagina = "/tcc/componentes/MEUSDADOS/mudarDadoFichaMedica.php";
  var cod_tipoLesao = document.getElementById('cod_tipoLesao').value;
  var tempo_fora = document.getElementById('tempo_fora').value;
  var data_lesao = document.getElementById('data_lesao').value;
  var desc_lesao = document.getElementById('desc_lesao').value;

let camposObrigatorios = {
    cod_tipoLesao: cod_tipoLesao,
    tempo_fora:tempo_fora,
    data_lesao:data_lesao,
    desc_lesao:desc_lesao,
  };

  let mensagemCamposObrigatorios = {
    cod_tipoLesao: "Tipo de lesão",
    tempo_fora:"Tempo fora",
    data_lesao:"Data lesão",
    desc_lesao:"Descrição da lesão"
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
    cod:cod,
    cod_tipoLesao: cod_tipoLesao,
    tempo_fora:tempo_fora,
    data_lesao:data_lesao,
    desc_lesao:desc_lesao,
    },
    success: function (data) {
      if (data == "ok") {
        alert("Dados atualizados.", "Atenção", "50%", function () {
          location.reload();
        });
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });
}
// --------------
async function modalAdicionarResponsavel(cod) {
  
  var pagina = "/tcc/componentes/MEUSDADOS/modalAdicionarResponsavel.php";

  var idModal = "modalAdicionarResponsavel";
  var tituloModal = "Confirmar Atualizacao";
  var funcaoModal = "adicionarResponsavel";
  var textoBotao = "Atualizar";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      funcaoModal: funcaoModal,
      textoBotao: textoBotao,
      idModal: idModal,
      tituloModal: tituloModal,
      cod:cod
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

function adicionarResponsavel(cod){

var pagina = "/tcc/componentes/MEUSDADOS/adicionarResponsavel.php";
 
var responsavel_nome = document.getElementById('responsavel_nome').value;
var responsavel_filiacao = document.getElementById('responsavel_filiacao').value;
var responsavel_email = document.getElementById('responsavel_email').value;
var responsavel_telefone = document.getElementById('responsavel_telefone').value;


let camposObrigatorios = {
    responsavel_nome: responsavel_nome,
    responsavel_filiacao:responsavel_filiacao,
    responsavel_email:responsavel_email,
    responsavel_telefone:responsavel_telefone,
  };

  let mensagemCamposObrigatorios = {
    responsavel_nome: "Nome",
    responsavel_filiacao:"Tipo de filiação",
    responsavel_email:"Email",
    responsavel_telefone:"Telefone"
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
    cod:cod,
    responsavel_nome: responsavel_nome,
    responsavel_filiacao:responsavel_filiacao,
    responsavel_email:responsavel_email,
    responsavel_telefone:responsavel_telefone,
    },
    success: function (data) {

      if (data == "ok") {
        alert("Dados atualizados.", "Atenção", "50%", function () {
          location.reload();
        });
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });
}

// ----------
function modalRetirarResponsavel(cod){
  var pagina = "/tcc/componentes/modalBasico.php";

  var idModal = "deletarResponsavel";
  var textoBotao = "Confirmar";
  var tituloModal = "Confirmar modificação";
  var funcaoModal = "deletarResponsavel";
  var textoModal =
    "Você tem certeza que deseja deletar responsavel ?";
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


function deletarResponsavel(cod){
  var pagina = "/tcc/componentes/MEUSDADOS/deletarResponsavel.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
    cod:cod,

    },
    success: function (data) {
      if(data == "nok1"){
        alert("Jogador deve ter 1 responsavel cadastrado,impossibilitada a retirada.", "Atenção", "50%",);
      }
      if (data == "ok") {
        alert("Dados atualizados.", "Atenção", "50%", function () {
          location.reload();
        });
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro ao gravar nação:", error);
    },
  });
}