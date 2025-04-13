$(document).ready(function() {
});

function teste(){
    console.log('oie');
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
    var classSelect = "form-control form-control-sm";
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
    $("#selectMunicipio").html('<option value="">Escolha um municipio</option>');

    var pagina = "componentes/selectBasico.php";

    var query = "select cod_estado,desc_estado from estado where cod_nacao = " + cod_nacao;

    var codSelect = "cod_estado";
    var descSelect = "desc_estado";
    var onchange = "onchange='selectMunicipio(this.value)'";
    var label = "Estado:";
    var classLabel = "mt-1 form-label";
    var classSelect = "form-control form-control-sm";
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
    var pagina = "componentes/selectBasico.php";
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

function selectNacoesIsolado() {
    var pagina = "/tcc/componentes/selectBasico.php";

    var query = "SELECT cod_nacao, desc_nacao FROM nacao";
    var codSelect = "cod_nacao";
    var descSelect = "desc_nacao";
    var label = "Pertencente a:";
    var classLabel = "form-label";
    var forLabel = "nacao";
    var classSelect = "form-control form-control-sm";
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

function tabelaDeleteUpdate() {
    var pagina = "/tcc/componentes/tabelaDeleteUpdate.php";

    $.ajax({
        type: "POST",
        url: pagina,
        data: { },
        success: function (data) {
            $("#tabelaDeleteUpdate").html(data);
        }
    });
}
