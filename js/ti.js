$(document).ready(function() {
     selectNacoesIsolado();
     tabelaDeleteUpdate()
});


function gravarEstado() {
    var pagina = "gravarEstado.php";

    var nacao = document.getElementById('nacao').value;
    var desc_nacao = document.getElementById('desc_nacao').value;
    var sigla_estado = document.getElementById('sigla_estado').value;

    $.ajax({
        type: "POST",
        url: pagina,
        data: {nacao:nacao,desc_nacao:desc_nacao,sigla_estado:sigla_estado},
        success: function (data) {
        if(data=='ok'){
            alert('gravou');
        }
          
        },
        error: function (xhr, status, error) {
            console.error("Erro ao gravar nação:", error);
        }
    });
}

function atualizarEstado(){
    
}