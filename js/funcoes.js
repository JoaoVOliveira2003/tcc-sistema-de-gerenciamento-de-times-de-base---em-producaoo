function selectInstituicoes() {
  var pagina = "/tcc/componentes/selectBasico.php";

  var query = "SELECT cod_instituicao,desc_instituicao FROM instituicao;";
  var codSelect = "cod_instituicao";
  var descSelect = "desc_instituicao";
  var label = "Pertence instituição:";
  var classLabel = "form-label";
  var forLabel = "institucao";
  var classSelect = "form-control mb-2";
  var idSelect = "institucao";
  var name = "institucao";
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
      $("#selectInstituicao").html(data);
    },
  });
}

function selectSubInstituicoes() {
  var pagina = "/tcc/componentes/selectBasico.php";

  var query =
    "SELECT Cod_SubInstituicao,desc_subInstituicao FROM subInstituicao;";
  var codSelect = "Cod_SubInstituicao";
  var descSelect = "desc_subInstituicao";
  var label = "Pertence Sub-instituição:";
  var classLabel = "form-label";
  var forLabel = "subinstitucao";
  var classSelect = "form-control mb-2";
  var idSelect = "subinstitucao";
  var name = "subinstitucao";
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
      $("#selectSubInstituicao").html(data);
    },
  });
}

function selectTiposInstituicoes() {
  var pagina = "/tcc/componentes/selectBasico.php";

  var query =
    "SELECT cod_tipo_instituicao, desc_tipo_instituicao FROM tipo_instituicao";
  var codSelect = "cod_tipo_instituicao";
  var descSelect = "desc_tipo_instituicao";
  var label = "Tipo de instituição a:";
  var classLabel = "form-label";
  var forLabel = "tipoInstituicao";
  var classSelect = "form-control mb-2";
  var idSelect = "tipoInstituicao";
  var name = "tipoInstituicao";
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
      $("#selectInstituicao").html(data);
    },
  });
}

function selectNacoesIsolado() {
  var pagina = "/tcc/componentes/selectBasico.php";

  var query = "SELECT cod_nacao, desc_nacao FROM nacao";
  var codSelect = "cod_nacao";
  var descSelect = "desc_nacao";
  var label = "Pertencente a:";
  var classLabel = "form-label";
  var forLabel = "nacao";
  var classSelect = "form-control";
  var idSelect = "nacao";
  var name = "nacao";
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
      $("#selectNacao").html(data);
    },
  });
}

function selectNacoes(cadastro) {
  var pagina = "/tcc/componentes/selectBasico.php";
  var query = "SELECT cod_nacao, desc_nacao FROM nacao";
  var codSelect = "cod_nacao";
  var descSelect = "desc_nacao";
  var onclick = "";

  var label = cadastro === "s" ? "Nacionalidade:" : "Nação:";
  var onchange = "selectEstados(this.value, '" + cadastro + "')";

  var classLabel = "form-label";
  var forLabel = "nacao";
  var classSelect = "form-control mb-2";
  var idSelect = "nacao";
  var name = "nacao";
  var primeiroOption = "Escolha uma opção";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      query: query,
      codSelect: codSelect,
      descSelect: descSelect,
      onclick: onclick,
      onchange: 'onchange="' + onchange + '"',
      label: label,
      classLabel: classLabel,
      forLabel: forLabel,
      classSelect: classSelect,
      idSelect: idSelect,
      name: name,
      primeiroOption: primeiroOption,
    },
    success: function (data) {
      $("#selectNacao").html(data);
    },
  });


}

function selectEstados(cod_nacao, cadastro) {
  var pagina = "/tcc/componentes/selectBasico.php";
  var query =
    "SELECT cod_estado, desc_estado FROM estado WHERE cod_nacao = " + cod_nacao;
  var codSelect = "cod_estado";
  var descSelect = "desc_estado";
  var onclick = "";

  var label = cadastro === "s" ? "Natural de:" : "Estado:";
  var onchange = "selectMunicipio(this.value, '" + cadastro + "')";

  var classLabel = "mt-1 form-label";
  var classSelect = "form-control mb-2";
  var forLabel = "estado";
  var idSelect = "estado";
  var name = "estado";
  var primeiroOption = "Escolha um estado";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      query: query,
      codSelect: codSelect,
      descSelect: descSelect,
      onclick: onclick,
      onchange: 'onchange="' + onchange + '"',
      label: label,
      classLabel: classLabel,
      forLabel: forLabel,
      classSelect: classSelect,
      idSelect: idSelect,
      name: name,
      primeiroOption: primeiroOption,
    },
    success: function (data) {
      $("#selectEstado").html(data);
    },
  });
}

function selectMunicipio(cod_estado, cadastro) {
  var pagina = "/tcc/componentes/selectBasico.php";
  var query =
    "SELECT cod_municipio, desc_municipio FROM municipio WHERE cod_estado = " +
    cod_estado;
  var codSelect = "cod_municipio";
  var descSelect = "desc_municipio";
  var onclick = "";

  var label = cadastro === "s" ? "Município de nascimento:" : "Município:";
  var onchange = "";

  var classLabel = "form-label";
  var classSelect = "form-control";
  var forLabel = "municipio";
  var idSelect = "municipio";
  var name = "municipio";
  var primeiroOption = "Escolha um município";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      query: query,
      codSelect: codSelect,
      descSelect: descSelect,
      onclick: onclick,
      onchange: 'onchange="' + onchange + '"',
      label: label,
      classLabel: classLabel,
      forLabel: forLabel,
      classSelect: classSelect,
      idSelect: idSelect,
      name: name,
      primeiroOption: primeiroOption,
    },
    success: function (data) {
      $("#selectMunicipio").html(data);
    },
  });
}

function alert(mensagem, titulo, width, funcao) {
  if (typeof titulo == "function") {
    funcao = titulo;
    titulo = "ALERTA";
  }

  if (typeof titulo != "string") {
    titulo = "ALERTA";
  }

  if (typeof width == "undefined") {
    width = "60%";
  }

  if (
    /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
      navigator.userAgent
    )
  ) {
    width = "auto";
  }

  mensagem = String(mensagem).replace("\n", "<br>");

  return $.confirm({
    title: `<div style="display: flex; justify-content: space-between; align-items: center;">
                    <h2><b>${titulo}</b></h2>
                </div>`,
    content: `<div>${mensagem}</div>`,
    type: "green",
    typeAnimated: false,
    useBootstrap: false,
    boxWidth: width,
    columnClass: "medium",
    backgroundDismiss: false,
    closeIcon: false,
    onOpenBefore: function () {
      window.__alertCallback = funcao;
    },
    buttons: {
      btFechar: {
        text: "Fechar",
        btnClass: "btn-green",
        action: function () {
          if (typeof funcao === "function") {
            setTimeout(funcao, 0);
          }
          window.__alertCallback = null;
        },
      },
    },
  });
}

function verificarCampos(campos, mensagens) {
  let mensagensErro = "";

  for (let campo in campos) {
    if (
      campos[campo] === null ||
      campos[campo] === undefined ||
      campos[campo].toString().trim() === ""
    ) {
      let nomeCampo = mensagens[campo] || campo;
      mensagensErro +=
        "<b>" + nomeCampo + "</b>" + " precisa ser preenchido.<br>";
    }
    if (campo === "cpf" && !validarCPF(campos[campo])) {
      let nomeCampo = mensagens[campo] || campo;
      mensagensErro += "<b>" + nomeCampo + "</b>" + " inválido.<br>";
    }
  }

  if (mensagensErro.length > 0) {
    alert(mensagensErro);
    return false;
  }

  return true;
}

function verificarCampoId(campos, mensagens) {
  let mensagensErro = "";

  for (let idCampo in campos) {
    let elemento = document.getElementById(idCampo);

    // Agora exibe mensagem se o campo NÃO EXISTE
    if (!elemento) {
      let nomeCampo = mensagens[idCampo] || idCampo;
      mensagensErro += "<b>" + nomeCampo + "</b> precisa ser preenchido.<br>";
      continue;
    }

    let valor = elemento.value;

    if (
      valor === null ||
      valor === undefined ||
      valor.toString().trim() === ""
    ) {
      let nomeCampo = mensagens[idCampo] || idCampo;
      mensagensErro += "<b>" + nomeCampo + "</b> precisa ser preenchido.<br>";
    }
  }

  if (mensagensErro.length > 0) {
    alert(mensagensErro);
    return false;
  }

  return true;
}

function acharPai(query, valorProcurado) {
  return new Promise(function (resolve, reject) {
    $.ajax({
      type: "POST",
      url: "/tcc/componentes/acharPai.php",
      data: {
        query: query,
        valorProcurado: valorProcurado,
      },
      success: function (data) {
        resolve(data);
      },
      error: function (err) {
        reject(err);
      },
    });
  });
}

function validarCPF(cpf) {
  cpf = cpf.replace(/[^\d]+/g, ""); // Remove caracteres não numéricos

  if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf)) {
    return false; // CPF com todos dígitos iguais é inválido
  }

  let soma = 0;
  for (let i = 0; i < 9; i++) {
    soma += parseInt(cpf.charAt(i)) * (10 - i);
  }
  let resto = (soma * 10) % 11;
  if (resto === 10 || resto === 11) resto = 0;
  if (resto !== parseInt(cpf.charAt(9))) return false;

  soma = 0;
  for (let i = 0; i < 10; i++) {
    soma += parseInt(cpf.charAt(i)) * (11 - i);
  }
  resto = (soma * 10) % 11;
  if (resto === 10 || resto === 11) resto = 0;
  if (resto !== parseInt(cpf.charAt(10))) return false;

  return true;
}

function aplicarMascaraCPF(campo) {
  let valor = campo.value.replace(/\D/g, ""); // Remove tudo que não é número

  if (valor.length > 3) {
    valor = valor.replace(/^(\d{3})(\d)/, "$1.$2");
  }
  if (valor.length > 6) {
    valor = valor.replace(/^(\d{3})\.(\d{3})(\d)/, "$1.$2.$3");
  }
  if (valor.length > 9) {
    valor = valor.replace(/^(\d{3})\.(\d{3})\.(\d{3})(\d)/, "$1.$2.$3-$4");
  }

  campo.value = valor;
}

function validarDataNascimento(data) {
  const regex = /^(\d{2})\/(\d{2})\/(\d{4})$/;
  const match = data.match(regex);

  if (!match) return false;

  const dia = parseInt(match[1], 10);
  const mes = parseInt(match[2], 10) - 1; // Mês começa do 0 (janeiro) no JS
  const ano = parseInt(match[3], 10);

  const dataNascimento = new Date(ano, mes, dia);

  if (
    dataNascimento.getDate() !== dia ||
    dataNascimento.getMonth() !== mes ||
    dataNascimento.getFullYear() !== ano
  ) {
    return false;
  }

  const hoje = new Date();
  let idade = hoje.getFullYear() - ano;
  const mesAtual = hoje.getMonth();
  const diaAtual = hoje.getDate();

  if (mesAtual < mes || (mesAtual === mes && diaAtual < dia)) {
    idade--;
  }

  return idade >= 0 && idade <= 120;
}

function validarTamanho(tamanho) {
  return tamanho >= 30 && tamanho <= 300;
}

function validarPeso(peso) {
  return peso >= 1 && peso <= 500;
}

function modalCarregamento() {
  $("#modalCarregando").modal("show"); // Exibe o modal
  var contador = 0;
  var carregandoText = document.getElementById("carregandoText");

  var interval = setInterval(function () {
    if (contador === 0) {
      carregandoText.innerHTML = "*..";
    } else if (contador === 1) {
      carregandoText.innerHTML = ".*.";
    } else {
      carregandoText.innerHTML = "..*";
    }
    contador = (contador + 1) % 3;
  }, 500);
}

function escodendoModalCarregamento() {
  $("#modalCarregando").modal("hide");
}

function teste(){
  console.log("teste");
}


function confirmarCadastro(cod){
  var pagina = "/tcc/componentes/confirmarCadastro.php";

  var senha = document.getElementById("senha_usuario").value;
  var email = document.getElementById("email_usuario").value;

  let camposObrigatorios = {
    senha:senha
  };

  let mensagemCamposObrigatorios = {
    senha: "Senha ",
  };

  if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
    return;
  }

  $.ajax({
    type: "POST",
    url: pagina,
    data: {email:email,cod:cod,senha:senha},
    success: function (data) 
   
    {
      console.log(data);
      if (data == "ok") {
        alert(
          "Dados atualizado, agora você podera realizar cadastro ! <br> ao clicar no botão 'fechar' ele ira ser enviado a tela do login.",
          "Atenção",
          "50%",
          function () {
            window.location.href = "/tcc/telas/LOGIN/index.php";
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