function listarJogadoresParaTreino(cod_staff){
  var pagina = "/tcc/componentes/TREINO/listarJogadoresParaTreino.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {cod_staff: cod_staff,},
    success: function (data) {
      $("#listarJogadoresParaTreino").html(data);
    },
  });
}

function listarEsportes(){
  var pagina = "/tcc/componentes/selectBasico.php";

  var query = "SELECT cod_esporte,desc_esporte FROM esporte;";
  var codSelect = "cod_esporte";
  var descSelect = "desc_esporte";
  var label = "Treino do esporte:";
  var classLabel = "form-label";
  var forLabel = "escolhaEsporte";
  var classSelect = "form-control";
  var idSelect = "escolhaEsporte";
  var name = "escolhaEsporte";
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
      $("#selectEsportes").html(data);
    },
  });
}

function listaDeJogadores(todosJogadores){
    var pagina = "/tcc/componentes/TREINO/listaDeJogadores.php";

  $.ajax({
    type: "POST",
    url: pagina,
    data: {todosJogadores: todosJogadores,},
    success: function (data) {
      $("#listaDeJogadores").html(data);
    },
  });
}