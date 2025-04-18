// gravar algo
function gravarSubInstituicao() {
    var pagina = "/tcc/componentes/ADMI/gravar/gravarSubInstituicao.php";

    let campos = {
        municipio: true
    };
    
    let mensagens = {
        municipio: "Município pertencente"
    };

    if (!verificarCampoId(campos, mensagens)) {
        return;
    }

    var municipio = document.getElementById("municipio").value;
    var desc_subInstituicao = document.getElementById("desc_subInstituicao").value;
    var institucao = document.getElementById("institucao").value;

    let camposObrigatorios = {
        municipio: municipio,
        desc_subInstituicao: desc_subInstituicao,
        institucao: institucao,
    };

    let mensagemCamposObrigatorios = {
        municipio: "Municipio pertencente",
        desc_subInstituicao: "Nome do estado",
        institucao: "institucao",
    };

    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
        return;
    }

    $.ajax({
        type: "POST",
        url: pagina,
        data: {
            municipio: municipio,
            desc_subInstituicao: desc_subInstituicao,
            institucao: institucao,
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

function tabelaDeleteUpdateSubInstituicao() {
    var pagina = "/tcc/componentes/tabelaDeleteUpdate.php";

    var query ="select inst.desc_instituicao, sub.Cod_SubInstituicao, sub.ativo, sub.desc_subInstituicao,mun.desc_Municipio from subInstituicao sub INNER JOIN Municipio mun ON mun.Cod_Municipio = sub.Cod_Municipio INNER JOIN instituicao inst ON inst.cod_instituicao = sub.cod_instituicao;"

    let titulosTh = {
        valor1: "Cod Sub. Instituicao",
        valor2: "Instituicao",
        valor5: "Sub. Instituicao",
        valor3: "Ativo",
        valor4: "Municipio",
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
        valor1: "Cod_SubInstituicao",  
        valor2: "desc_instituicao",   
        valor4: "desc_subInstituicao",               
        valor3: "ativo",       
        valor5: "desc_Municipio",    
    };

    let botoesTd = {
        valor1:
            '<button type="button" class="btn btn-secondary btn-sm" onclick="modalAtualizarSubInstituicao($Cod_SubInstituicao)">Atualizar</button>',
        valor2:
            '<button type="button" class="btn btn-secondary btn-sm" onclick="modalDeletarSubInstituicao($Cod_SubInstituicao)">Deletar</button>',
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
function modalDeletarSubInstituicao(cod) {
    var pagina = "/tcc/componentes/modalBasico.php";

    var idModal = "modalSubInstituicao";
    var textoBotao = "Excluir";
    var tituloModal = "Confirmar Exclusão";
    var funcaoModal = "deletarSubInstituicao";
    var textoModal =
        "Você tem certeza que deseja excluir a SubInstituicao com código = " + cod + "?";
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
function deletarSubInstituicao(cod) {
    var pagina = "/tcc/componentes/admi/deletar/deletarSubInstituicao.php";

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

// função de atualizar
function atualizarSubInstituicao(cod) {
    var pagina = "/tcc/componentes/admi/atualizar/atualizarSubInstituicao.php";

    var instituicao = document.getElementById("atualilizacaoIntituicao").value;
    var municipio = document.getElementById("atualilizacaoMunicipio").value;
    var desc_subInstituicao = document.getElementById("atualizacaoDesc_subInstituicao").value;
    var ativo = document.getElementById("atualizacaoAtivo_subInstitucao").value;

    let camposObrigatorios = {
        instituicao: instituicao,
        municipio: municipio,
        desc_subInstituicao: desc_subInstituicao,
        ativo: ativo,
    };
    
    let mensagemCamposObrigatorios = {
        municipio: "Instituição",
        municipio: "Município",
        desc_subInstituicao: "Nome da subinstituição",
        ativo: "Status (Ativo)"
    };
    
    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
        return;
    }

    $.ajax({
        type: "POST",
        url: pagina,
        data: {
            cod: cod,
            instituicao: instituicao,
            municipio: municipio,
            desc_subInstituicao: desc_subInstituicao,
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

//modais de deletar
async function modalAtualizarSubInstituicao(cod) {
    var pagina ="/tcc/componentes/admi/modalAtualizar/modalAtualizarSubInstituicao.php";

    var idModal = "modalAtualizarInstituicao";
    var tituloModal = "Confirmar Atualizacao";
    var funcaoModal = "atualizarSubInstituicao";
    var textoBotao = "Atualizar";

    var query ="select cod_instituicao from subinstituicao where cod_subinstituicao = " + cod;
    var valorProcurado = "cod_instituicao";
    var select = await acharPai(query, valorProcurado);

    var query2 ="select cod_municipio from subinstituicao where cod_subinstituicao = " + cod;
    var valorProcurado = "cod_municipio";
    var select2 = await acharPai(query2, valorProcurado);

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

            selecionarInstituicaoSelecionado(select);
            selectInstituicaoAtualizarMunicipio(select2);

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
function selecionarInstituicaoSelecionado(select) {
    var pagina = "/tcc/componentes/selectBasico.php";

    var query = "SELECT cod_instituicao, desc_instituicao FROM instituicao";
    var codSelect = "cod_instituicao";
    var descSelect = "desc_instituicao";
    var label = "Pertencente a:";
    var classLabel = "form-label";
    var forLabel = "atualilizacaoIntituicao";
    var classSelect = "form-control";
    var idSelect = "atualilizacaoIntituicao";
    var name = "atualilizacaoIntituicao";
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
            $("#selecionarInstituicaoSelecionado").html(data);
        },
    });
}

function selectInstituicaoAtualizarMunicipio(select) {
    var pagina = "/tcc/componentes/selectBasico.php";

    var query = "SELECT cod_municipio, desc_municipio FROM municipio";
    var codSelect = "cod_municipio";
    var descSelect = "desc_municipio";
    var label = "Pertencente a:";
    var classLabel = "form-label";
    var forLabel = "atualilizacaoMunicipio";
    var classSelect = "form-control";
    var idSelect = "atualilizacaoMunicipio";
    var name = "atualilizacaoMunicipio";
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
