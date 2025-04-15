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

function gravarEstado() {
    var pagina = "/tcc/componentes/TI/gravarEstado.php";


    var nacao = document.getElementById('nacao').value;
    var desc_estado = document.getElementById('desc_estado').value;
    var sigla_estado = document.getElementById('sigla_estado').value;

    let camposObrigatorios = {
        nacao: nacao,
        desc_estado: desc_estado,
        sigla_estado: sigla_estado
    };
    
    let mensagemCamposObrigatorios = {
        nacao: 'Nação pertencente',
        desc_estado: 'Nome do estado',
        sigla_estado: 'Sigla do estado'
    };

    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
        return; // Sai da função se houver campos inválidos
    }


    $.ajax({
        type: "POST",
        url: pagina,
        data: {nacao:nacao,desc_estado:desc_estado,sigla_estado:sigla_estado},
        success: function (data) {
        if(data=='ok'){
            alert('Dados gravados.', 'Atenção', '50%',function () {location.reload();});
        }
        },
        error: function (xhr, status, error) {
            console.error("Erro ao gravar nação:", error);
        }
    });
}

function gravarNacao() {
    var pagina = "/tcc/componentes/TI/gravarNacao.php";


    var desc_nacao = document.getElementById('desc_nacao').value;
    var sigla_nacao = document.getElementById('sigla_nacao').value;

    let camposObrigatorios = {
        desc_nacao: desc_nacao,
        sigla_nacao: sigla_nacao
    };
    let mensagemCamposObrigatorios = {
        desc_nacao: 'Nome da nacão',
        sigla_nacao: 'Sigla da nacão'
    };

    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
        return; 
    }


    $.ajax({
        type: "POST",
        url: pagina,
        data: {desc_nacao:desc_nacao,sigla_nacao:sigla_nacao},
        success: function (data) {
        if(data=='ok'){
            alert('Dados gravados.', 'Atenção', '50%',function () {location.reload();});
        }
        },
        error: function (xhr, status, error) {
            console.error("Erro ao gravar nação:", error);
        }
    });
}

function tabelaDeleteUpdateEstados() {
    var pagina = "/tcc/componentes/tabelaDeleteUpdate.php";
    
    var query = "SELECT est.cod_estado, nac.desc_nacao, est.desc_estado, est.sigla_estado FROM estado est INNER JOIN nacao nac ON est.cod_nacao = nac.cod_nacao ORDER BY est.cod_nacao";
    let titulosTh = {
        valor1: 'Código Estado',
        valor2: 'Nação',
        valor3: 'Estado',
        valor4: 'Sigla',
        valor5: 'Ações'
    };
    
    let styleTh = {
        valor1: 'width: 10%;',
        valor2: 'width: 30%;',
        valor3: 'width: 30%;',
        valor4: 'width: 10%;',
        valor5: 'width: 20%;'
    };

    let variavelTd = {
        valor1: 'cod_estado',
        valor2: 'desc_nacao',
        valor3: 'desc_estado',
        valor4: 'sigla_estado'
    };

    let botoesTd = {
        valor1: '<button type="button" class="btn btn-secondary btn-sm" onclick="modalAtualizarEstado($cod_estado)">Atualizar</button>',
        valor2: '<button type="button" class="btn btn-secondary btn-sm" onclick="modalDeletarEstado($cod_estado)">Deletar</button>'
    };
    

    $.ajax({
        type: "POST",
        url: pagina,
        data: {
            query: query,
            titulosTh: JSON.stringify(titulosTh),
            styleTh: JSON.stringify(styleTh),
            variavelTd: JSON.stringify(variavelTd),
            botoesTd: JSON.stringify(botoesTd)
        },
        success: function (data) {
            $("#tabelaDeleteUpdate").html(data);
        }
    });
}

function tabelaDeleteUpdateNacao() {
    var pagina = "/tcc/componentes/tabelaDeleteUpdate.php";
    
    var query = 'SELECT cod_nacao, desc_nacao, sigla_nacao FROM nacao;'

    let titulosTh = {
        valor1: 'Código nacao',
        valor2: 'Nação',
        valor4: 'Sigla',
        valor5: 'Acao',
    };
    
    let styleTh = {
        valor1: 'width: 33%;',
        valor2: 'width: 33%;',
        valor3: 'width: 33%;',
    };

    let variavelTd = {
        valor1: 'cod_nacao',
        valor2: 'desc_nacao',
        valor3: 'sigla_nacao'
    };

    let botoesTd = {
        valor1: '<button type="button" class="btn btn-secondary btn-sm" onclick="modalAtualizarNacao($cod_nacao)">Atualizar</button>',
        valor2: '<button type="button" class="btn btn-secondary btn-sm" onclick="modalDeletarNacao($cod_nacao)">Deletar</button>'
    };
    

    $.ajax({
        type: "POST",
        url: pagina,
        data: {
            query: query,
            titulosTh: JSON.stringify(titulosTh),
            styleTh: JSON.stringify(styleTh),
            variavelTd: JSON.stringify(variavelTd),
            botoesTd: JSON.stringify(botoesTd)
        },
        success: function (data) {
            $("#tabelaDeleteUpdate").html(data);
        }
    });
}

function modalDeletarEstado(cod) {
    var pagina = "/tcc/componentes/modalBasico.php";  

    var idModal = "modalDeletarEstado";  
    var textoBotao = "Excluir";
    var tituloModal = "Confirmar Exclusão";  
    var funcaoModal = "deletarEstado";  
    var textoModal = "Você tem certeza que deseja excluir o estado com código = " + cod + "?";
    var textoBotao = "Deletar";

    $.ajax({
        type: "POST",
        url: pagina,
        data: {funcaoModal: funcaoModal,textoBotao:textoBotao, cod: cod, idModal: idModal, tituloModal: tituloModal, textoModal: textoModal},
        success: function (data) {
            $('#modalContainer').html(data);

            var modalElement = $('#' + idModal);
            modalElement.modal('show'); 

            modalElement.attr('aria-hidden', 'false');

            $('#cancelarModal').on('click', function () {
                modalElement.modal('hide');
            });


            $('#funcaoDoModal').on('click', function () {
                modalElement.modal('hide');

            });
        },
        error: function (xhr, status, error) {
            console.error("Erro ao carregar os dados do estado:", error);
        }
    }); 
}

function modalDeletarNacao(cod) {
    var pagina = "/tcc/componentes/modalBasico.php";  

    var idModal     = "modalDeletarEstado";  
    var textoBotao  = "Excluir";
    var tituloModal = "Confirmar Exclusão";  
    var funcaoModal = "deletarNacao";  
    var textoModal  = "Você tem certeza que deseja excluir a nacão com código = " + cod + "?";
    var textoBotao  = "Deletar";

    $.ajax({
        type: "POST",
        url: pagina,
        data: {funcaoModal: funcaoModal,textoBotao:textoBotao, cod: cod, idModal: idModal, tituloModal: tituloModal, textoModal: textoModal},
        success: function (data) {

            $('#modalContainer').html(data);

            var modalElement = $('#' + idModal);
            modalElement.modal('show'); 

            modalElement.attr('aria-hidden', 'false');

            $('#cancelarModal').on('click', function () {
                modalElement.modal('hide');
            });


            $('#funcaoDoModal').on('click', function () {
                modalElement.modal('hide');

            });
        },
        error: function (xhr, status, error) {
            console.error("Erro ao carregar os dados do estado:", error);
        }
    }); 
}

function deletarEstado(cod_estado){
    var pagina = "/tcc/componentes/ti/deletarEstado.php";

    $.ajax({
        type: "POST",
        url: pagina,
        data: {cod_estado:cod_estado},
        success: function (data) {
        if(data=='ok'){
            alert('Dados deletados.', 'Atenção', '50%',function () {location.reload();});
        }
        else if(data=="nok"){
            alert('Remoção incompleta,caso estado tenha algum muinicipio,negada a remoção.', 'Atenção', '50%',function () {location.reload();});
        }
        },
        error: function (xhr, status, error) {
            console.error("Erro ao gravar nação:", error);
        }
    }); 

}

function deletarNacao(cod){
    var pagina = "/tcc/componentes/ti/deletarNacao.php";

    $.ajax({
        type: "POST",
        url: pagina,
        data: {cod:cod},
        success: function (data) {
        if(data=='ok'){
            alert('Dados deletados.', 'Atenção', '50%',function () {location.reload();});
        }
        else if(data=="nok"){
            alert('Remoção incompleta,caso nacão tenha algum estado,negada a remoção.', 'Atenção', '50%',function () {location.reload();});
        }
        },
        error: function (xhr, status, error) {
            console.error("Erro ao gravar nação:", error);
        }
    }); 

}

function atualizarEstado(cod_estado){
    var pagina = "/tcc/componentes/TI/atualizarEstado.php";

    var nacao = document.getElementById('atualilizacaoNacao').value;
    var desc_estado = document.getElementById('atualizacaoDesc_estado').value;
    var sigla_estado = document.getElementById('atualizacaoSigla_estado').value;

    let camposObrigatorios = {
        nacao: nacao,
        desc_estado: desc_estado,
        sigla_estado:sigla_estado
    };
    let mensagemCamposObrigatorios = {
        desc_nacao: 'Nacão',
        desc_estado: 'desc_estado',
        sigla_estado:'sigla_estado'
    };
    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
        return; 
    }
   
    $.ajax({
        type: "POST",
        url: pagina,
        data: {cod_estado:cod_estado,nacao:nacao,desc_estado:desc_estado,sigla_estado:sigla_estado},
        success: function (data) {
        if(data=='ok'){
            alert('Dados atualizados.', 'Atenção', '50%',function () {location.reload();});
        }
        else if(data=="nok"){
            alert('atualização incompleta', 'Atenção', '50%',function () {location.reload();});
        }
        },
        error: function (xhr, status, error) {
            console.error("Erro ao gravar nação:", error);
        }
    }); 
}

function atualizarNacao(cod_nacao){
    var pagina = "/tcc/componentes/TI/atualizarNacao.php";

    var desc_nacao = document.getElementById('atualizacaoDesc_nacao').value;
    var sigla_nacao = document.getElementById('atualizacaoSigla_nacao').value;

    let camposObrigatorios = {
        desc_nacao: desc_nacao,
        sigla_nacao: sigla_nacao
    };
    let mensagemCamposObrigatorios = {
        desc_nacao: 'Nome da nacão',
        sigla_nacao: 'Sigla da nacão'
    };
    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) {
        return; 
    }

    $.ajax({
        type: "POST",
        url: pagina,
        data: {cod_nacao:cod_nacao,desc_nacao:desc_nacao,sigla_nacao:sigla_nacao},
        success: function (data) {
        if(data=='ok'){
            alert('Dados atualizados.', 'Atenção', '50%',function () {location.reload();});
        }
        else if(data=="nok"){
            alert('atualização incompleta', 'Atenção', '50%',function () {location.reload();});
        }
        },
        error: function (xhr, status, error) {
            console.error("Erro ao gravar nação:", error);
        }
    }); 
}

async function modalAtualizarEstado(cod_estado) {
    var pagina = "/tcc/componentes/TI/modalAtualizarEstado.php";  

    
    var query = 'select cod_nacao from estado where cod_estado = ' + cod_estado; 
    var valorProcurado = 'cod_nacao';
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
            tituloModal: tituloModal
        },
        success: function (data) {
            $('#modalContainer').html(data);

            var modalElement = $('#' + idModal);
            modalElement.modal('show'); 
            modalElement.attr('aria-hidden', 'false');


            selectNacoesAtualizarEstado(select);

            $('#cancelarModal').on('click', function () {
                modalElement.modal('hide');
            });

            $('#funcaoDoModal').on('click', function () {
                modalElement.modal('hide');
            });
        },
        error: function (xhr, status, error) {
            console.error("Erro ao carregar os dados do estado:", error);
        }
    }); 
}

async function modalAtualizarNacao(cod) {
    var pagina = "/tcc/componentes/TI/modalAtualizarNacao.php";  
    
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
            tituloModal: tituloModal
        },
        success: function (data) {
            
            $('#modalContainer').html(data);

            var modalElement = $('#' + idModal);
            modalElement.modal('show'); 
            modalElement.attr('aria-hidden', 'false');

            $('#cancelarModal').on('click', function () {
                modalElement.modal('hide');
            });

            $('#funcaoDoModal').on('click', function () {
                modalElement.modal('hide');
            });
        },
        error: function (xhr, status, error) {
            console.error("Erro ao carregar os dados do estado:", error);
        }
    }); 
}

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
            select:select,            
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
            $("#selectNacoesAtualizarEstado").html(data);       
        }
    });
}