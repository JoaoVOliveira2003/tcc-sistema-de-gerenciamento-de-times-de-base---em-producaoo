<?php
require('../../../include/conecta.php');
$bd = conecta();
$retorno = '';

// se for TI = MOSTRA OS 3 EVENTOS GERAIS Q VÃO ACONTECER
// se for ADMI = mostra os 3 eventos da DA SUA $instituicao 
// se for ADMS = mostra os 3 eventos da sua subinstitucao que vá acontecer
// se for STAFF = MOSTRA OS 3 EVENTOS Q VC TEM DE TURMA 
// SE FOR STAFF|ADMS = MOSTRA OS 3 EVENTOS Q VC TEM DE TURMA 
// SE FOR JOGADOR = DA SUA TURMA




?>







<!DOCTYPE html>
<html lang="pt-br">
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">

  <div class="container">
    <?php
    $retorno = "
    <table class='table table-bordered'>
      <caption style='caption-side: top; text-align: left; font-weight: bold; font-size: 1.2em;'>PRÓXIMOS TRÊS EVENTOS</caption>
      <thead class='table-light'>
        <tr>
          <th>Data</th>
          <th>Local</th>
          <th>Título</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>25/05/2025</td>
          <td>Monza</td>
          <td>Treino sub-20</td>
        </tr>
        <tr>
          <td>10/06/2025</td>
          <td>Maracanã</td>
          <td>Peneira</td>
        </tr>
        <tr>
          <td>15/07/2025</td>
          <td>Guaraituba</td>
          <td>Aula de salsa</td>
        </tr>
        <tr>
          <td colspan='3'>
            <div class='d-flex justify-content-end'>
              <button class='btn btn-sm btn-secondary'>Ver eventos por completo</button>
            </div>
          </td>
        </tr>
      </tbody>
    </table>";
    
    echo $retorno;
    ?>
  </div>

  <!-- Bootstrap JS (opcional) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
