<?php
require('../../include/conecta.php');

$retorno = '';
$cod_staff = getPost('cod_staff');

$bd = conecta();

// Consulta todas as turmas e jogadores ligados ao staff
$query = "
    SELECT 
    a.cod_jogador,
    a.data_nascimento,
    TIMESTAMPDIFF(YEAR, a.data_nascimento, CURDATE()) AS idade,
    b.nota_jogador
FROM jogador a
LEFT JOIN nota_jogador b ON b.cod_jogador = a.cod_jogador
where a.cod_jogador in (20,21,25)
;
"; 

$retorno .= "<div class='accordion-item>";
if ($bd->SqlExecuteQuery($query)) {

    // Loop para percorrer todas as linhas
    do {
        $cod_turma = $bd->SqlQueryShow('cod_turma');

    $retorno .="
     <div class='accordion-item'>
        <h2 class='accordion-header' id='headingLeft1'>
          <button class='accordion-button' type='button' data-bs-toggle='collapse' data-bs-target='#collapseLeft1'>
            Seção 1
          </button>
        </h2>
        <div id='collapseLeft1' class='accordion-collapse collapse show'>
          <div class='accordion-body'>Conteúdo da Seção 1.</div>
        </div>
      </div>
    ";

  } while ($bd->SqlFetchNext());

} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();

// Retorna o HTML final
exit($retorno);
