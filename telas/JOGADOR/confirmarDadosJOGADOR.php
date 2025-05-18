<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <?php include('../../include/includeBase.php'); ?>
  <script src="../../js/funcoes.js"></script>
  <script src="../../js/jogador.js"></script>
  <script>
    $(document).ready(function () {
      const urlParams = new URLSearchParams(window.location.search);
      const codPessoa = urlParams.get('cod_pessoa');
      const emailDestino = urlParams.get('email');

      verificarCadastroJogador(codPessoa, emailDestino);

      $('#btnRecusar').attr('data-cod', codPessoa);
      $('#btnConfirmar').attr('data-cod', codPessoa);
    });
  </script>
</head>

<body>
  <div class="container">
    <div class="mt-2">
      <h2 class="mb-3">Confirmação de cadastro de <b>Jogador</b></h2>
      <h5 class="mb-2">
        Olá! <br> Você foi cadastrado como jogador no sistema de gestão de bases.
        Abaixo estão os seus dados cadastrados. Para confirmar a sua inscrição, preencha o campo senha e clique
        no botão "Confirmar".<br>
        Caso queira negar o cadastro, clique em "Recusar".
      </h5>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="nome_jogador" class="form-label">Nome do jogador:</label>
          <input type="text" class="form-control" id="nome_jogador" name="nome_jogador" placeholder="Digite o nome..."
            value="adms">
        </div>
        <div class="col-md-6 mb-3">
          <label for="email_usuario" class="form-label">Email do jogador:</label>
          <input type="email" class="form-control" id="email_usuario" name="email_usuario"
            placeholder="Digite o email..." value="ojoao953@gmail.com">
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="data_nascimento" class="form-label">Data de Nascimento:</label>
          <input type="date" class="form-control" id="data_nascimento" name="data_nascimento">
        </div>
        <div class="col-md-6 mb-3">
          <label for="cpf" class="form-label">CPF:</label>
          <input maxlength="14" oninput="aplicarMascaraCPF(this)" type="text" class="form-control" id="cpf" name="cpf"
            placeholder="Digite o CPF..." value="13432640900">
        </div>
      </div>

      <div class="row">
        <div class="col-md-4 mb-3">
          <label class="form-label" for="nacao">Nacionalidade:</label>
          <input type="text" class="form-control" id="nacao" name="nacao" value="">
        </div>
        <div class="col-md-4 mb-3">
          <label class="form-label" for="estado">Natural de:</label>
          <input type="text" class="form-control" id="estado" name="estado" value="">
        </div>
        <div class="col-md-4 mb-3">
          <label class="form-label" for="municipio">Município de nascimento:</label>
          <input type="text" class="form-control" id="municipio" name="municipio" value="">
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label class="form-label" for="subinstituicao">Pertence Sub-instituição:</label>
          <input type="text" class="form-control" id="subinstituicao" name="subinstituicao" value="">
        </div>
        <div class="col-md-6 mb-3">
          <label class="form-label" for="turma">Turma:</label>
          <input type="text" class="form-control" id="turma" name="turma" value="">
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label class="form-label" for="esporte">Esporte:</label>
          <input type="text" class="form-control" id="esporte" name="esporte" value="">
        </div>
        <div class="col-md-6 mb-3">
          <label class="form-label" for="posicao">Posição favorita:</label>
          <input type="text" class="form-control" id="posicao" name="posicao" value="">
        </div>
      </div>

      <center>
        <div class="col-md-4 mb-3 text-center">
          <label class="form-label d-block" for="localImagem">Foto Cadastrada:</label>
          <img alt="Foto do jogador" id="localImagem" name="localImagem" class="img-fluid rounded shadow"
            style="max-height: 200px; object-fit: cover;">
        </div>
      </center>

      <hr class="my-2">

      <label class="form-label">Dados dos responsáveis:</label>
      <div id="dadosResponsaveis"></div>

      <hr>
      <h5 class="mb-3">Ficha Médica</h5>
      <div class="row">
        <div class="col-md-4 mb-3">
          <label for="altura" class="form-label">Altura (cm):</label>
          <input type="text" maxlength="3" class="form-control" id="altura" name="altura" placeholder="Ex: 170">
        </div>
        <div class="col-md-4 mb-3">
          <label for="peso" class="form-label">Peso (kg):</label>
          <input type="text" maxlength="3" class="form-control" id="peso" name="peso" placeholder="Ex: 65">
        </div>
        <div class="col-md-4 mb-3">
          <label for="tipo_sanguineo" class="form-label">Tipo Sanguíneo:</label>
          <input type="text" class="form-control" id="tipo_sanguineo" name="tipo_sanguineo" placeholder="Ex: O+">
        </div>
      </div>



      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="restricoes_medicas" class="form-label">Restrições Médicas:</label>
          <input type="text" class="form-control" id="restricoes_medicas" name="restricoes_medicas"
            placeholder="Descreva as restrições, se houver">
        </div>
        <div class="col-md-6 mb-3">
          <label for="alergias" class="form-label">Alergias:</label>
          <input type="text" class="form-control" id="alergias" name="alergias" placeholder="Liste as alergias">
        </div>
      </div>

      <hr class="my-2">
      <label class="form-label">Lesão:</label>
      <div id="dadosLesoes"></div>

      <hr class="my-2">

      <div class="row">


        <div class="col-md-6 ">
          <label for="senha_usuario" class="form-label">Senha de login:</label>
          <input type="text" class="form-control" id="senha_usuario" value="">
        </div>
      </div>

      <hr>

      <button type="button" class="btn btn-primary mb-2 " id="btnConfirmar" onclick="confirmarCadastro(this.getAttribute('data-cod'))">Confirmar</button>
      <button type="button" class="btn btn-danger  mb-2 mt-1" id="btnRecusar" onclick="recusarCadastroJOGADOR(this.getAttribute('data-cod'))">Recusar</button>
  
                <div id="modalContainer"></div>

  
    </div>
  </div>
</body>

</html>