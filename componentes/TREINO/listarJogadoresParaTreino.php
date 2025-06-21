<?php
require('../../include/conecta.php');

$retorno = '';
$cod_staff = getPost('cod_staff');

$bd = conecta();

// Consulta todas as turmas e jogadores ligados ao staff
$query = "
    SELECT 
        e.cod_turma,
        e.desc_turma,
        d.cod_usuario,
        d.nome 
    FROM staff a
    INNER JOIN staff_turma b ON a.cod_staff = b.cod_staff
    INNER JOIN turma_jogador c ON c.cod_turma = b.cod_turma
    INNER JOIN turma e ON e.cod_turma = b.cod_turma
    INNER JOIN cadastro_identificacao d ON d.cod_usuario = c.cod_jogador
    WHERE a.cod_staff = $cod_staff
    ORDER BY e.desc_turma, d.nome
"; 

$retorno .= "<h4>Liste os jogadores que voce deseja que participe do treino: </h4>";
if ($bd->SqlExecuteQuery($query)) {
    $cod_turmaAtual = null;

    // Loop para percorrer todas as linhas
    do {
        $cod_turma = $bd->SqlQueryShow('cod_turma');
        $desc_turma = $bd->SqlQueryShow('desc_turma');
        $cod_usuario = $bd->SqlQueryShow('cod_usuario');
        $nome = $bd->SqlQueryShow('nome');

        // Quando mudar de turma, atualizamos o título
        if ($cod_turmaAtual != $cod_turma) {
            if ($cod_turmaAtual !== null) {
                $retorno .= "<hr>"; // Divisão entre turmas
            }
            $retorno .= "<h5>" . htmlentities($desc_turma) . "</h5>";
            $cod_turmaAtual = $cod_turma;
        }

        // Adiciona o checkbox do jogador
        $retorno .= '
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="' . htmlentities($cod_usuario) . '" id="user_' . htmlentities($cod_usuario) . '">
                <label class="form-check-label" for="user_' . htmlentities($cod_usuario) . '">
                    ' . htmlentities($nome) . '
                </label>
            </div>';
  } while ($bd->SqlFetchNext());

} else {
    $retorno = 'nok';
}

$bd->SqlDisconnect();

// Retorna o HTML final
exit($retorno);
