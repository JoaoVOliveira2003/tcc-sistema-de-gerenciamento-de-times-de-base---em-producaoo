<?php

    function getPost($key) {
        if (isset($_POST[$key])) {
            return $_POST[$key];
        }
        return ''; 
    }
 
    function formatarCPF($cpfBruto) {
    $cpfNumeros = preg_replace('/\D/', '', $cpfBruto);

    if (strlen($cpfNumeros) !== 11) {
        return "CPF inválido";
    }

    return preg_replace('/(\d{3})(\d{3})(\d{3})(\d{2})/', '$1.$2.$3-$4', $cpfNumeros);
    }

function formatarData($dataBruta) {
    // Se for a data zerada "0000-00-00", retorna formatado manualmente
    if ($dataBruta === '0000-00-00') {
        return '00/00/0000';
    }

    // Verifica se está no formato esperado (YYYY-MM-DD)
    if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $dataBruta)) {
        $partes = explode('-', $dataBruta);
        return $partes[2] . '/' . $partes[1] . '/' . $partes[0];
    }

    return 'Data inválida';
}

function formatarDataHora($dataBruta) {
    if (empty($dataBruta)) {
        return '';
    }

    try {
        $data = new DateTime($dataBruta);
        return $data->format('d/m/Y | H:i');
    } catch (Exception $e) {
        return 'Data inválida';
    }
}

    
?>