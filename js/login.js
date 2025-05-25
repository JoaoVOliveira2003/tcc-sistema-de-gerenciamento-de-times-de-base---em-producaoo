function fazerLogin (){
    var email = document.getElementById("email").value;
    var senha = document.getElementById("senha").value;

    const camposObrigatorios = {email,senha,}

    const mensagemCamposObrigatorios =
    {
    email: "Emial do usuário",
    senha: "Senha do usuário",
    }

    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) return;


    $.ajax({
    url: "/tcc/componentes/LOGIN/vistoriarLogin.php",
    type: "POST",
    data: {email: email,senha:senha,},
    success: function (data) {
      console.log(data);

      if (data == "ok") {
           window.location.href = "telaPosLogin.php";
      }
      else if (data == 'nok1'){
        alert("Usuário não encontrado");
      }
      else if (data == 'nok2'){
        alert("Email ou senha incorretos");
      }
      else if (data == 'nok3'){
        alert("Usuário não está ativo");
      }
    },
    error: function () {
      alert("Erro no login");
    },
  });
}

function atualizarSenha(){
    var email = document.getElementById("email").value;
    const camposObrigatorios = {email}
    const mensagemCamposObrigatorios ={email: "Emial do usuário",}

    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) return;
  
  
    $.ajax({
    url: "/tcc/componentes/LOGIN/atualizarSenha.php",
    type: "POST",
    data: {email: email,},
    success: function (data) {
      console.log(data);

      if (data == "ok") {
           window.location.href = "telaPosLogin.php";
      }
      else if (data == 'nok1'){
        alert("Usuário não encontrado");
      }
    },
    error: function () {
      alert("Erro atualizando senha");
    },
  });
}