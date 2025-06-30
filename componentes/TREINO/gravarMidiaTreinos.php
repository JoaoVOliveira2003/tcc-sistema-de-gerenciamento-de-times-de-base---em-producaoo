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
    $novoNome = $codTreino . '-' . $nomeOriginal;
    $caminhoFinal = $destinoBase . $novoNome;

    if (!move_uploaded_file($tmpName, $caminhoFinal)) {
        echo "Falha ao mover o arquivo $nomeOriginal";
        exit;
    }

    $query = "INSERT INTO midia_treinojogo (local_midia) VALUES ('$novoNome')";
    if ($bd->SqlExecuteQuery($query)) {
        $cod_midiaTreino = $bd->getLastInsertId();

        $query = "INSERT INTO midia_treino (cod_midiaTreino, cod_treino) VALUES ($cod_midiaTreino, $codTreino)";
        $bd->SqlExecuteQuery($query);
    } else {
        echo $query;
        exit;
    }
}

echo "ok";
