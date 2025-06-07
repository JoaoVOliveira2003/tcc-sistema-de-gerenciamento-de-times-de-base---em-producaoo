function gravarEvento() {
    const cod_staff = document.getElementById('cod_staff').value;
    const titulo = document.getElementById('titulo').value;
    const local = document.getElementById('local').value;
    const data_evento = document.getElementById('data_evento').value;
    const horario_evento = document.getElementById('horario_evento').value;
    const desc_evento = document.getElementById('desc_evento').value;
    const turma = document.getElementById('turma') ? document.getElementById('turma').value : null;

    const camposObrigatorios = {
        titulo,
        local,
        data_evento,
        horario_evento,
        desc_evento,
        turma,
    };

    const mensagemCamposObrigatorios = {
        titulo: "Título do evento",
        local: "Local do evento",
        data_evento: "Data do evento",
        horario_evento: "Horário do evento",
        desc_evento: "Descrição do evento",
        turma: "Turma",
    };

    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) return;

    $.ajax({
        url: "/tcc/componentes/Evento/gravar/gravarEvento.php",
        type: "POST",
        data: {
            cod_staff: cod_staff,
            titulo_evento: titulo,
            local: local,
            data_evento: data_evento,
            horario_evento: horario_evento,
            desc_evento: desc_evento,
            turma: turma
        },
        success: function (data) {
            if (data == "ok") {
                alert("Evento cadastrado!");
            } else if (data == 'nok1' || data == 'nok2') {
                alert("Evento não cadastrado");
            } else {
                alert("Resposta inesperada: " + data);
            }
        },
        error: function () {
            alert("Erro na requisição");
        },
    });
}

function proximosTresEventos(cod_role,cod_usuario){
var pagina = "/tcc/componentes/Evento/tabelaInicialEvento/proximoTresEventos.php";

 $.ajax({
    type: "POST",
    url: pagina,
    data: {cod_role:cod_role,cod_usuario:cod_usuario},
    success: function (data) {
      $("#proximosTresEventos").html(data);
    },
  });
}

function todosEventos(cod_role,cod_usuario){
  var pagina = "/tcc/componentes/Evento/tabelaInicialEvento/todosEventos.php";
  $.ajax({
    type: "POST",
    url: pagina,
    data: {cod_role:cod_role,cod_usuario:cod_usuario},
    success: function (data) {
      $("#todosEventos").html(data);
    },
  });
}

function cancelarEvento(cod_evento) {
    var pagina = "/tcc/componentes/Evento/atualizar/cancelarEvento.php";

    $.ajax({
        type: "POST",
        url: pagina,
        data: { cod_evento: cod_evento },
        success: function (data) {
            if (data === "ok") {
                alert("Evento foi desativado.","Atenção","50%",function () {location.reload();}
                );
            } else if (data === "nok") {
                alert("Erro no cancelamento.","Atenção","50%");
            }
        }
    });
}
