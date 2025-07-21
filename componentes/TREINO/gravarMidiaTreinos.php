<?php
require('../../include/conecta.php');
$bd = conecta();

if (!isset($_FILES['midias']) || !isset($_POST['cod_treino'])) {
    exit('Dados ausentes');
}

$codTreino = intval($_POST['cod_treino']);
$destinoBase = $_SERVER['DOCUMENT_ROOT'] . "/tcc/img/treino/";

if (!is_dir($destinoBase)) {
    if (!mkdir($destinoBase, 0777, true)) {
        exit("Erro ao criar a pasta de destino.");
    }
}

foreach ($_FILES['midias']['tmp_name'] as $index => $tmpName) {
    $nomeOriginal = basename($_FILES['midias']['name'][$index]);
    $nomeSanitizado = preg_replace('/[^A-Za-z0-9_.-]/', '_', $nomeOriginal); // Substitui tudo que não for letra, número, underline, ponto ou traço
    $novoNome = $codTreino . '-' . $nomeSanitizado;
    $caminhoFinal = $destinoBase . $novoNome;

    if (!move_uploaded_file($tmpName, $caminhoFinal)) {
        echo "Falha ao mover o arquivo $nomeOriginal";
        exit;
    }

    $query = "INSERT INTO midia_treinojogo (local_midia) VALUES ('" . addslashes($novoNome) . "')";
    if ($bd->SqlExecuteQuery($query)) {
        $cod_midiaTreino = $bd->getLastInsertId();

        $queryVinculo = "INSERT INTO midia_treino (cod_midiaTreino, cod_treino) VALUES ($cod_midiaTreino, $codTreino)";
        if (!$bd->SqlExecuteQuery($queryVinculo)) {
            echo "Erro ao inserir vínculo da mídia: $queryVinculo";
            exit;
        }
    } else {
        echo "Erro ao inserir mídia: $query";
        exit;
    }
}

echo "ok";
