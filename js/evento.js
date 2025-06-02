function gravarEvento() {
    const cod_staff = document.getElementById('cod_staff').value;
    cod_staff = 6; 
    const titulo = document.getElementById('titulo').value;
    const local = document.getElementById('local').value;
    const data_evento = document.getElementById('data_evento').value;
    const horario_evento = document.getElementById('horario_evento').value;
    const desc_evento = document.getElementById('desc_evento').value;
    const selectTurma = document.getElementById('turma') ? document.getElementById('turma').value : null;

    const camposObrigatorios = {
        titulo,
        local,
        data_evento,
        horario_evento,
        desc_evento,
        selectTurma,
    };

    const mensagemCamposObrigatorios = {
        titulo: "Título do evento",
        local: "Local do evento",
        data_evento: "Data do evento",
        horario_evento: "Horário do evento",
        desc_evento: "Descrição do evento",
        selectTurma: "Turma",
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
            turma: selectTurma
        },
        success: function (data) {
            if (data == "ok") {
                alert("Evento cadastrado!");
            } else if (data == 'nok1') {
                alert("Usuário não encontrado");
            } else {
                alert("Resposta inesperada: " + data);
            }
        },
        error: function () {
            alert("Erro na requisição");
        },
    });
}
