<?php
include '../../include/verificaSessao.php';
$usuario = verificarLogin();
?>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <?php include('../../include/includeBase.php'); ?>
  <script src="../../js/funcoes.js"></script>
  <script src="../../js/treino.js"></script>
  <script>
    $(document).ready(function() {
      const usuario = <?php echo json_encode($usuario); ?>;
      
      listarEsportes();
      listarJogadoresParaTreino(usuario.cod_usuario)


      document.getElementById("usuarioCodStaff").value = usuario.cod_usuario;

      // Máscara de tempo (MM:SS)
      const tempoInput = document.getElementById('tempoInicial');
      tempoInput.addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, ''); // Remove não dígitos

        if (value.length > 4) {
          value = value.slice(0, 4); // Limita a 4 dígitos
        }

        if (value.length >= 3) {
          value = value.slice(0, 2) + ':' + value.slice(2);
        }

        e.target.value = value;
      });
    });
  </script>
</head>

<?php include('../../componentes/header.php'); ?>

<body>
  <div class="container">
    <div class="mt-1">
      <h2 class="mb-3">Criar treino.</h2>
      <h5 class="mb-4">Colocar um texto bom aqui posteriormente</h5>
      <!-- Lista dos jogadores do treino
      -- Esporte do treino
      Tempo do treino
      -- placar do treino(vai ser feito com o codesporte)
      -- cod staff -->
       <form method="POST" action="treino.php">
        <input type="hidden" id="usuarioCodStaff">

        <div class="row mt-3">
          <div class="col-md-6 mb-3">
            <div id="selectEsportes"></div>
          </div>
          <div class="col-md-6 mb-3">
            <label for="tempoInicial" class="form-label font-weight-bold">Tempo de treino (min:seg):</label>
            <input type="text" class="form-control" id="tempoInicial" placeholder="00:00" maxlength="5">
          </div>
        </div>
 <hr>
        <div class="row mt-1">
          
          <div class="col-md-12 ">
            <div>

            </div>
            
            <div id="listarJogadoresParaTreino"></div>
        </div>
        </div>
    <hr>
        <!-- <input type="text" name="tempo" placeholder="Tempo">
        <input type="text" name="pessoas" placeholder="Pessoas"> -->
        <button type="submit" class="btn btn-primary btn-sm">Iniciar treino</button>

      </form>


    </div>
  </div>
</body>

</html>