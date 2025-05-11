function selectTipoLesao() {
  var pagina = "/tcc/componentes/selectBasico.php";

  var query = "select cod_tipoLesao,desc_tipoLesao from tipo_lesao";
  var codSelect = "cod_tipoLesao";
  var descSelect = "desc_tipoLesao";
  var label = "Tipo lesão:";
  var classLabel = "form-label";
  var forLabel = "tipo_lesao";
  var classSelect = "form-control";
  var idSelect = "tipo_lesao";
  var name = "tipo_lesao";
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
      $("#tipo_lesao").html(data);
    },
  });
}