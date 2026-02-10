<?php
Class Database{
    private $hostname = 'localhost';
    private $username = 'root';
    private $password = '';
    private $database = 'pasticceria_db';
    private $conn;

    public function connect()
    {
        // Verifico se NON sono connesso al db
        if (!$this->conn) {
            $this->conn = new mysqli($this->hostname, $this->username, $this->password, $this->database);

            // Se la connessione fallisce (check con connect_error)
            if ($this->conn->connect_error) {
                die("Connessione fallita: " . $this->conn->connect_error . "<br>");
            }

            // Aggiungo un controllo per verificare che $this->conn sia effettivamente un'istanza di \mysqli
            if (!$this->conn instanceof \mysqli) {
                die("Errore: la connessione non è un'istanza valida di \mysqli. <br>");
            }
        }

        return $this->conn;
    }

    public function close()
    {
        // Verifico se sono connesso al db
        if ($this->conn) {
            // Chiudo la connessione al db
            $this->conn->close();
            $this->conn = null;
        }
    }
    public function query($query){
        return $this->conn->query($query);
    }
}