// http://localhost/tcc/telas/login/telaAtualizarSenha.php?cod_pessoa=2&email=ojoao953%40gmail.com

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
    
    modalCarregamento();

  
    $.ajax({
    url: "/tcc/componentes/LOGIN/atualizarSenha.php",
    type: "POST",
    data: {email: email,},
    success: function (data) {
      escodendoModalCarregamento();

      if (data == "ok") {

        alert("Favor, vá até sua caixa de emails para realizar a atualização de dados, caso não ache nada,procure em sua caixa SPAM.", "Atenção", "50%", function () {
          window.location.href = "index.php";
        });
      }
      else if (data == 'nok2' || data == 'nok3'){
        alert("Usuário não encontrado");
      }
      else if (data == 'nok1'){
        alert("Usuário não está ativo");
      }

    },
    error: function () {
      alert("Erro atualizando senha");
    },
  });
}

function mudarSenha(){
    var senha = document.getElementById("senha_usuario").value;
    var codPessoa = document.getElementById("codPessoa").value;

console.log(senha);
console.log(codPessoa);


    const camposObrigatorios = {senha,}

    const mensagemCamposObrigatorios =
    {
    senha: "Senha nova",
    }

    if (!verificarCampos(camposObrigatorios, mensagemCamposObrigatorios)) return;

  //   modalCarregamento();
  //   $.ajax({
  //   url: "/tcc/componentes/LOGIN/mudarSenha.php",
  //   type: "POST",
  //   data: {senha: senha,},
  //   success: function (data) {
  //     escodendoModalCarregamento();

  //     if (data == "ok") {
  //       alert("Senha alterada com sucesso", "Atenção", "50%", function () {
  //         window.location.href = "index.php";
  //       });
  //     }
  //     else if (data == 'nok1'){
  //       alert("Usuário não encontrado");
  //     }
  //     else if (data == 'nok2'){
  //       alert("Usuário não está ativo");
  //     }
  //   },
  //   error: function () {
  //     alert("Erro atualizando senha");
  //   },
  // });
}