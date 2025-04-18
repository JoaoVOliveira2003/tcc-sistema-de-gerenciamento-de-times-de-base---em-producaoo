function teste(){
    console.log('oie');
}

function selectInstituicoes(){
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
            primeiroOption: primeiroOption
        },
        success: function (data) {
            $("#selectInstituicao").html(data);       
        }
    });    
}

function selectSubInstituicoes(){
    var pagina = "/tcc/componentes/selectBasico.php";

    var query = "SELECT Cod_SubInstituicao,desc_subInstituicao FROM subInstituicao;";
    var codSelect = "cod_subinstituicao";
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
            primeiroOption: primeiroOption
        },
        success: function (data) {
            $("#selectSubInstituicao").html(data);       
        }
    });    
}


function  selectTiposInstituicoes(){
    var pagina = "/tcc/componentes/selectBasico.php";

    var query = "SELECT cod_tipo_instituicao, desc_tipo_instituicao FROM tipo_instituicao";
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
            primeiroOption: primeiroOption
        },
        success: function (data) {
            $("#selectInstituicao").html(data);       
        }
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
            primeiroOption: primeiroOption
        },
        success: function (data) {
            $("#selectNacao").html(data);       
        }
    });
}

function selectNacoes() {  
    var pagina = "/tcc/componentes/selectBasico.php";
                
    var query = "SELECT cod_nacao, desc_nacao FROM nacao";
    var codSelect = "cod_nacao";
    var descSelect = "desc_nacao";
    var onclick = "";
    var onchange = "onchange='selectEstados(this.value)'";
    var label = "Nação:";
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
            onchange: onchange,
            label: label,
            classLabel: classLabel,
            forLabel: forLabel,
            classSelect: classSelect,
            idSelect: idSelect,
            name: name,
            primeiroOption: primeiroOption
        },
        success: function (data) {
            $("#selectNacao").html(data);
        }
    });
}

function selectEstados(cod_nacao) {

    var pagina = "/tcc/componentes/selectBasico.php";

    var query = "select cod_estado,desc_estado from estado where cod_nacao = " + cod_nacao;

    var codSelect = "cod_estado";
    var descSelect = "desc_estado";
    var onchange = "onchange='selectMunicipio(this.value)'";
    var label = "Estado:";
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
            onchange: onchange,
            label: label,
            classLabel: classLabel,
            forLabel: forLabel,
            classSelect: classSelect,
            idSelect: idSelect,
            name: name,
            primeiroOption: primeiroOption
        },
        success: function (data) {
            $("#selectEstado").html(data);
        }
    });
}

function selectMunicipio(cod_estado) {
    var pagina = "/tcc/componentes/selectBasico.php";
    var query = "select cod_municipio,desc_municipio from municipio where cod_estado = " + cod_estado;

    var codSelect = "cod_municipio";
    var descSelect = "desc_municipio";
    var onchange = "onchange='teste(this.value)'";
    var label = "Municipio:";
    var classLabel = "mt-1 form-label";
    var classSelect = "form-control form-control-sm";
    var forLabel = "municipio";
    var idSelect = "municipio";
    var name = "municipio";
    var primeiroOption = "Escolha um municipio";

    $.ajax({
        type: "POST",
        url: pagina,
        data: {
            query: query,
            codSelect: codSelect,
            descSelect: descSelect,
            onclick: onclick,
            onchange: onchange,
            label: label,
            classLabel: classLabel,
            forLabel: forLabel,
            classSelect: classSelect,
            idSelect: idSelect,
            name: name,
            primeiroOption: primeiroOption
        },
        success: function (data) {
            $("#selectMunicipio").html(data);
        }
    });
}

function alert(mensagem, titulo, width, funcao) {
    if (typeof (titulo) == "function") {
        funcao = titulo;
        titulo = 'ALERTA';
    }

    if (typeof (titulo) != 'string') {
        titulo = 'ALERTA';
    }

    if (typeof (width) == "undefined") {
        width = "60%";
    }

    if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
        width = 'auto';
    }

    mensagem = String(mensagem).replace("\n", "<br>");

    return $.confirm({
        title: `<div style="display: flex; justify-content: space-between; align-items: center;">
                    <h2><b>${titulo}</b></h2>
                </div>`,
        content: `<div>${mensagem}</div>`,
        type: 'green',
        typeAnimated: false,
        useBootstrap: false,
        boxWidth: width,
        columnClass: 'medium',
        backgroundDismiss: false,
        closeIcon: false,
        onOpenBefore: function () {
            window.__alertCallback = funcao;
        },
        buttons: {
            "btFechar": {
                text: "Fechar",
                btnClass: "btn-green",
                action: function () {
                    if (typeof funcao === "function") {
                        setTimeout(funcao, 0);
                    }
                    window.__alertCallback = null;
                }
            }
        }
    });
}

function verificarCampos(campos, mensagens) {
    let mensagensErro = '';
  
    for (let campo in campos) {
      if (campos[campo] === null ||campos[campo] === undefined ||campos[campo].toString().trim() === ""      ) 
      {
        let nomeCampo = mensagens[campo] || campo; 
        mensagensErro += "<b>" + nomeCampo + "</b>"+ " precisa ser preenchido.<br>";
      }
    }
  
    if (mensagensErro.length > 0) {
      alert(mensagensErro);
      return false;
    }
  
    return true;  
}

function verificarCampoId(campos, mensagens) {
    let mensagensErro = '';

    for (let idCampo in campos) {
        let elemento = document.getElementById(idCampo);

        // Agora exibe mensagem se o campo NÃO EXISTE
        if (!elemento) {
            let nomeCampo = mensagens[idCampo] || idCampo;
            mensagensErro += "<b>" + nomeCampo + "</b> precisa ser preenchido.<br>";
            continue;
        }

        let valor = elemento.value;

        if (valor === null || valor === undefined || valor.toString().trim() === "") {
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
                valorProcurado: valorProcurado
            },
            success: function (data) {
                resolve(data); 
            },
            error: function (err) {
                reject(err); 
            }
        });
    });
}


