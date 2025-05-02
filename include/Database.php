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
        if (isset($this->result[$this->currentIndex][$campo])) {
            return $this->result[$this->currentIndex][$campo];
        }
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
