$(document).ready(function() {
     selectNacoesIsolado();
});

function teste() {
    var select = document.getElementById('nacao');
    var cod_nacao = select.value; // valor do <option>
    var desc_nacao = select.options[select.selectedIndex].text; // texto do <option>

    console.log("Código:", cod_nacao);
    console.log("Descrição:", desc_nacao);
}


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
