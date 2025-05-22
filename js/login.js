function fazerLogin (){
    var email = document.getElementById("email").value;
    var senha = document.getElementById("senha").value;

    const camposObrigatorios = {
    email,
    senha,
    }

    const mensagemCamposObrigatorios = {
    municipio: "Município de origem do usuário",
    nome: "Nome do usuário",
     }

    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) return;


    $.ajax({
    url: "/tcc/componentes/login/vistoriarLogin.php",
    type: "POST",
    data: formData,
    contentType: false,
    processData: false,
    success: function (data) {
      if (data == "ok") {
           window.location.href = "home.html";
      }
      else if (data == 'nok1'){
        alert("Usuário não encontrado");
      }
            else if (data == 'nok2'){
        alert("Email ou senha incorretos");
      }
    },
    error: function () {
      alert("Erro ao gravar dados do jogador");
    },
  });


}