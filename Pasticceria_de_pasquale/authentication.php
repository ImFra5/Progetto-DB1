<?php 
require_once("./database.php");
Class Authentication
{    
    private $db;
    public function __construct() 
    {
        $database = new Database();
        $this->db=$database->connect();
    }
    public function register($data)
    {
        
        $nome=$data["nome"];
        $email=$data["email"];
        $password=$data["password"];
        $cognome=$data["cognome"];
        $indirizzo=$data["indirizzo"];
        $cellulare=$data["cellulare"];
        
    
    
    try 
    {
        
        if (!filter_var($email, FILTER_VALIDATE_EMAIL))
        {
            return false;
            
        }
        $stmt = $this->db->prepare("SELECT * FROM utente WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        
        if ($stmt->get_result()->num_rows > 0) 
        {   
            $stmt->close();
            return false;
        }
        $stmt->close();
        
        $hashedPassword = password_hash($password, PASSWORD_BCRYPT);
        // Inserimento nuovo utente
        $stmt = $this->db->prepare("INSERT INTO utente (nome, cognome,cellulare,email, password) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("ssiss",  $nome, $cognome,$cellulare,$email, $hashedPassword);

         if (!$stmt->execute()) 
        {
            $stmt->close();
            return false;  
        }


        $idUtente = $this->db->insert_id;   
        $stmt->close();
        $stmt = $this->db->prepare("INSERT INTO cliente (indirizzo,id_utente) VALUES (?, ?)");
        $stmt->bind_param("si",  $indirizzo, $idUtente);

 
        
        if (!$stmt->execute()) 
        {
            $stmt->close();
            return false;  
        } 

            $stmt->close();
            return true;

        


    } 
    catch (\Throwable $th) 
    {
        return false;
    }
    }

    public function login($data)
    {
        try 
        {
            // Sanitizzazione input
            $email = filter_var($data['email'] ?? '', FILTER_SANITIZE_EMAIL);
            $password = $data['password'] ?? '';

            // Query per ottenere tutti i dati dell'Utente
            $stmt = $this->db->prepare("SELECT utente.id_utente, utente.nome, utente.cognome, utente.email, utente.password, cliente.id_cliente as 'id_cliente' FROM utente inner join cliente on utente.id_utente=cliente.id_utente WHERE utente.email = ?");
            $stmt->bind_param("s", $email);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows === 1) 
                {
                    $user = $result->fetch_assoc();

                    if (password_verify($password, $user['password'])) 
                        {
                            // Inizia sessione
                            if (session_status() === PHP_SESSION_NONE) 
                                {
                                    session_start();
                                }

                            // Salva i dati dell'utente nella sessione
                            $_SESSION['id'] = $user['id_utente'];
                            $_SESSION['nome'] = $user['nome'];
                            $_SESSION['cognome'] = $user['cognome'];
                            $_SESSION['email'] = $user['email'];
                            $_SESSION['id_cliente'] = $user['id_cliente'];

                            echo "Login effettuato con successo!";

                            return true;
                        
                        } 
                    else 
                        {
                            echo "Password errata.";
                            return false;
                        }
                }
            else 
                {
                    echo "Utente non trovato.";
                    return false;
                }

        } 
        catch (Exception $e)
            {
                echo "Errore durante il login: ";
                return false;
            }
    }
    
    public function new_card($data) {
        $n_carta = $data["n_carta"];
        $data_scadenza = $data["data_scadenza"];
        $intestatario = $data["intestatario"];
        $cvv = $data["cvv"];
        $id_cliente = $data["id_cliente"];
    
        try {
            // Controllo se la carta di credito esiste già
            $stmt = $this->db->prepare("SELECT * FROM carta_di_credito WHERE n_carta = ?");
            if (!$stmt) {
                throw new Exception("Errore nella preparazione della query: " . $this->db->error);
            }
            
            $stmt->bind_param("s", $n_carta);
            $stmt->execute();
            $result = $stmt->get_result();
            
            if ($result->num_rows > 0) {
                echo "Carta di credito già registrata.";
                $stmt->close();
                return false;
            }
            $stmt->close();
    
            // Inserimento nuova carta di credito
            $stmt = $this->db->prepare("INSERT INTO carta_di_credito (n_carta, data_scadenza, intestatario, cvv, id_cliente) VALUES (?, ?, ?, ?, ?)");
            if (!$stmt) {
                throw new Exception("Errore nella preparazione della query: " . $this->db->error);
            }
    
            $stmt->bind_param("issii", $n_carta, $data_scadenza, $intestatario, $cvv, $id_cliente);
    
            if ($stmt->execute()) {
                echo "Carta di credito registrata con successo!";
                $stmt->close();
                return true;
            } else {
                throw new Exception("Errore nell'inserimento: " . $stmt->error);
            }
    
        } catch (Exception $e) {
            echo "Errore: " . $e->getMessage();
            return false;
        }
    }

public function acquisto_dolci(int $id_cliente): bool
{
    try {
        $this->db->begin_transaction();

        // Carrello attivo del cliente
        $stmt = $this->db->prepare("
            SELECT id_carrello, totale
            FROM carrello
            WHERE id_cliente = ? AND stato = 'attivo'
            LIMIT 1
        ");
        $stmt->bind_param("i", $id_cliente);
        $stmt->execute();
        $res = $stmt->get_result();
        $stmt->close();

        if ($res->num_rows !== 1) {
            $this->db->rollback();
            return false;
        }

        $row = $res->fetch_assoc();
        $id_carrello = (int)$row["id_carrello"];
        $totale = (float)$row["totale"];

        if ($totale <= 0) {
            $this->db->rollback();
            return false;
        }

        // Chiudi carrello
        $stato = "chiuso";
        $stmt = $this->db->prepare("UPDATE carrello SET stato = ? WHERE id_carrello = ?");
        $stmt->bind_param("si", $stato, $id_carrello);
        $ok = $stmt->execute();
        $stmt->close();

        if (!$ok) {
            $this->db->rollback();
            return false;
        }

        $this->db->commit();
        return true;

    } catch (\Throwable $e) {
        $this->db->rollback();
        return false;
    }
}



}
