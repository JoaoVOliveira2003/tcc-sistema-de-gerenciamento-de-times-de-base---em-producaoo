function meusDados(cod_usuario,cod_tipoRole){
  var pagina = "/tcc/componentes/MEUSDADOS/meusDados.php";

  console.log(cod_usuario +'|'+cod_tipoRole);

  $.ajax({
    type: "POST",
    url: pagina,
    data: {
      cod_usuario: cod_usuario,cod_tipoRole:cod_tipoRole
    },
    success: function (data) {
      console.log(data);
      $("#meusDados").html(data);
    }
  });
}