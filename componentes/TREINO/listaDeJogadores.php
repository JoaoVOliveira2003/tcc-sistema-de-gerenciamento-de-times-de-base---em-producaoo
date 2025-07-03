<?php
require('../../include/conecta.php');

$retorno = '';
$todosJogadores = getPost('todosJogadores');

$todosJogadores = array_map('intval', $todosJogadores);
$todosJogadores = implode(", ", $todosJogadores);

error_log($todosJogadores);



$bd = conecta();

$query = "
SELECT 
    c.nome,
    a.cod_jogador,
    a.data_nascimento,
    f.local_midia,
    d.desc_posicao,
    e.desc_esporte,
    TIMESTAMPDIFF(YEAR, a.data_nascimento, CURDATE()) AS idade,
    COALESCE(b_s.nota_jogador, b_any.nota_jogador, '???') AS nota_jogador
FROM jogador a
INNER JOIN cadastro_identificacao c ON c.cod_usuario = a.cod_jogador
INNER JOIN posicao d ON d.cod_posicao = a.posicao
INNER JOIN esporte e ON e.cod_esporte = a.cod_esporte
INNER JOIN midia_jogador f ON f.cod_jogador = a.cod_jogador
LEFT JOIN (
    -- Nota com ativo = 's'
    SELECT cod_jogador, nota_jogador
    FROM nota_jogador
    WHERE ativo = 's'
) b_s ON b_s.cod_jogador = a.cod_jogador
LEFT JOIN (
    -- Qualquer nota (caso não tenha ativo = 's')
    SELECT cod_jogador, nota_jogador
    FROM nota_jogador
) b_any ON b_any.cod_jogador = a.cod_jogador AND b_s.cod_jogador IS NULL
WHERE a.cod_jogador IN ($todosJogadores);
";

error_log($query);

if ($bd->SqlExecuteQuery($query)) {

    do {

        $cod_jogador = $bd->SqlQueryShow('cod_jogador');
        $nome = htmlspecialchars($bd->SqlQueryShow('nome'));
        $idade = $bd->SqlQueryShow('idade');
        $local_midia = $bd->SqlQueryShow('local_midia');
        $desc_posicao = $bd->SqlQueryShow('desc_posicao');
        $nota = $bd->SqlQueryShow('nota_jogador') ?: '??';
        $desc_esporte = $bd->SqlQueryShow('desc_esporte');

        // $retorno .= $local_midia;
        if ($local_midia != '' || $local_midia != null) {
            $local_midia = '../../img/jogador/' . $local_midia;
        } else {
            $local_midia = '../../img/icone/jogadorPadrao.png';
        }


        $retorno .= "
        <div class='accordion-item'>
            <h2 class='accordion-header' id='headingLeft$cod_jogador'>
                <button class='accordion-button collapsed' type='button' data-bs-toggle='collapse' data-bs-target='#collapseLeft$cod_jogador' aria-expanded='false' aria-controls='collapseLeft$cod_jogador'>
                    $nome
                </button>
            </h2>
            <div id='collapseLeft$cod_jogador' class='accordion-collapse collapse' aria-labelledby='headingLeft$cod_jogador'>
                <div class='accordion-body'>
                    <div style='
                        width: 200px;
                        border-radius: 15px;
                        padding: 10px;
                        text-align: center;
                        font-family: Arial, sans-serif;
                        color: #333;
                        box-shadow: 0 0 10px rgba(0,0,0,0.2);
                        margin: auto;
                    '>
                        <div style='font-size: 24px; font-weight: bold;'>$nota</div>
                        <div style='font-size: 14px;'>$desc_posicao</div>
                        <img onerror=\"this.onerror=null;this.src='../../img/icone/jogadorPadrao.png';\" 
                        src='$local_midia' alt='Foto de $nome' style='width: 100px; height: 100px; border-radius: 10px; margin: 10px 0;' />
                        <div style='font-size: 16px; font-weight: bold;'>$nome</div>
                        <div style='font-size: 13px;'>$desc_esporte</div>
                        <div style='font-size: 12px;'>$idade anos</div>
                        <div style='font-size: 10px; color: #555;'>ID: $cod_jogador</div>
                    </div>
                  <div class='d-flex gap-2 justify-content-center flex-wrap mt-3'>
                      <button type='button' onclick='criarCarta($cod_jogador, " . json_encode($nome) . ", " . json_encode($local_midia) . ")' class='btn btn-primary btn-sm'>Inserir no campo</button>
                      <button type='button' onclick='retirarCarta($cod_jogador)' class='btn btn-secondary btn-sm'>Retirar do campo</button>
                      <button type='button' onclick='mudarCorVermelho($cod_jogador)' class='btn btn-danger btn-sm'>Time vermelho</button>
                      <button type='button' onclick='mudarCorAzul($cod_jogador)' class='btn btn-info btn-sm text-white'>Time azul</button>
                  </div>
                </div>
            </div>
        </div>
        ";
    } while ($bd->SqlFetchNext());

} else {
    $retorno = "<div class='alert alert-warning'>Nenhum jogador encontrado.</div>";
}

$bd->SqlDisconnect();

exit($retorno);
