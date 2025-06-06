<?php

class Database {
    private $pdo;
    private $stmt;
    private $result;
    private $currentIndex = 0;

    public function __construct($host, $dbname, $user, $pass) {
        try {
            $this->pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die("Erro na conexão: " . $e->getMessage());
        }
    }

    public function SqlExecuteQuery($query) {
        try {
            $this->stmt = $this->pdo->prepare($query);
            $executou = $this->stmt->execute();
            if ($executou) {
                $this->result = $this->stmt->fetchAll(PDO::FETCH_ASSOC);
                $this->currentIndex = 0;
                return true;
            } else {
                return false;
            }
        } catch (PDOException $e) {
            // opcional: logar o erro $e->getMessage()
            return false;
        }
    }

public function SqlQueryShow($campo) {
    // Logando o nome do campo acessado
    error_log("SqlQueryShow - Tentando acessar o campo: " . $campo);

    // Verifica se o índice existe no resultado
    if (isset($this->result[$this->currentIndex][$campo])) {
        // Logando o valor encontrado
        error_log("SqlQueryShow - Valor encontrado: " . print_r($this->result[$this->currentIndex][$campo], true));
        return $this->result[$this->currentIndex][$campo];
    }

    // Logando erro se o campo não existir
    error_log("SqlQueryShow - Campo '$campo' não encontrado no índice atual: " . $this->currentIndex);
    return null;
}


    public function SqlFetchNext() {
        $this->currentIndex++;
        return $this->currentIndex < count($this->result);
    }

    public function SqlNumRows() {
        return count($this->result);
    }

    public function SqlDisconnect() {
        $this->pdo = null;
        $this->stmt = null;
        $this->result = null;
        $this->currentIndex = 0;
    }

    public function getLastInsertId() {
        return $this->pdo->lastInsertId();
    }
    
    
    
}
