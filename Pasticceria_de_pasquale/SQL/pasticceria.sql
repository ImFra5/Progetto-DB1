-- Struttura della tabella UTENTE

CREATE TABLE utente
(
    id_utente int(11) NOT NULL AUTO_INCREMENT,
    nome varchar(20) NOT NULL,
    cognome varchar(20) NOT NULL,
    email varchar(60) NOT NULL,
    cellulare int (12) NOT NULL,
    password varchar(256) NOT NULL,

    PRIMARY KEY(id_utente)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella PROPRIETARIO 

CREATE TABLE proprietario
(
    c_fiscale varchar(16) NOT NULL,
    id_utente int(11) NOT NULL,
    

    PRIMARY KEY(c_fiscale),
    CONSTRAINT proprietario_ibfk_1 FOREIGN KEY (id_utente) REFERENCES utente(id_utente)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella CLIENTE

CREATE TABLE cliente
(
    id_cliente int(11) NOT NULL AUTO_INCREMENT,
    indirizzo varchar(60) NOT NULL,
    id_utente int(11) NOT NULL,

    PRIMARY KEY(id_cliente),
    CONSTRAINT cliente_ibfk_1 FOREIGN KEY (id_utente) REFERENCES utente(id_utente)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella DIPENDENTE

CREATE TABLE dipendente 
(
    id_dipendente int(11) NOT NULL AUTO_INCREMENT,
    contratto varchar(20) NOT NULL,
    turno_lavoro time NOT NULL,
    id_utente int(11) NOT NULL,

    PRIMARY KEY(id_dipendente),
    CONSTRAINT dipendente_ibfk_1 FOREIGN KEY (id_utente) REFERENCES utente(id_utente)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella COMMESSO

CREATE TABLE commesso 
(
    id_commesso int(11) NOT NULL AUTO_INCREMENT,
    id_dipendente int(11) NOT NULL,

    PRIMARY KEY(id_commesso),
    CONSTRAINT commesso_ibfk_1 FOREIGN KEY (id_dipendente) REFERENCES dipendente(id_dipendente)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella PASTICCERE

CREATE TABLE pasticcere 
(
    id_pasticcere int(11) NOT NULL AUTO_INCREMENT,
    id_dipendente int(11) NOT NULL,

    PRIMARY KEY(id_pasticcere),
    CONSTRAINT pasticcere_ibfk_1 FOREIGN KEY (id_dipendente) REFERENCES dipendente(id_dipendente)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella FORMAZIONE

CREATE TABLE formazione 
(
    categoria_formazione varchar(60) NOT NULL,
    data_rilascio date NOT NULL,
    livello varchar(20) NOT NULL,
    id_pasticcere int(11) NOT NULL,

    PRIMARY KEY(categoria_formazione),
    CONSTRAINT formazione_ibfk_1 FOREIGN KEY(id_pasticcere) REFERENCES pasticcere(id_pasticcere)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--Struttura della tabella CARTA DI CREDITO

CREATE TABLE carta_di_credito
(
    n_carta int(16) NOT NULL,
    data_scadenza varchar(10) NOT NULL,
    cvv int(3) NOT NULL,
    id_cliente int(11) NOT NULL,
    intestatario varchar(40) NOT NULL,

    PRIMARY KEY(n_carta),
    CONSTRAINT carta_di_credito_ibfk_1 FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella AZIENDA

CREATE TABLE azienda 
(
    p_iva varchar(11) NOT NULL,
    nome_azienda varchar(20) NOT NULL,
    indirizzo_sede varchar(20) NOT NULL,
    numero_dipendenti int(20) NOT NULL,
    pec varchar(60) NOT NULL,
    anno_fondazione int(4) NOT NULL,
    c_fiscale_proprietario varchar(16) NOT NULL,

    PRIMARY KEY(p_iva),
    CONSTRAINT azienda_ibfk_1 FOREIGN KEY(c_fiscale_proprietario) REFERENCES proprietario (c_fiscale)
    
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella PUNTO VENDITA

CREATE TABLE punto_vendita 
(
    id_punto_vendita int(11) NOT NULL AUTO_INCREMENT,
    citta varchar(20) NOT NULL,
    orari_apertura time NOT NULL,
    telefono int(12) NOT NULL,
    indirizzo varchar(60) NOT NULL,
    giorno_chiusura varchar(10) NOT NULL,
    id_azienda varchar(11) NOT NULL,
    
    PRIMARY KEY(id_punto_vendita),
    CONSTRAINT punto_vendita_ibfk_1 FOREIGN KEY(id_azienda) REFERENCES azienda(p_iva)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella GRUPPO FORNITORI

CREATE TABLE gruppo_fornitori 
(
    id_fornitore int(11) NOT NULL AUTO_INCREMENT,
    nome varchar(20) NOT NULL,
    indirizzo varchar(60) NOT NULL,
    tipo_fornitura varchar(60) NOT NULL,

    PRIMARY KEY(id_fornitore)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella TABELLA_FORNITURA

CREATE TABLE fornitura 
(
    id_fornitura int(11) NOT NULL AUTO_INCREMENT,
    id_fornitore int(11) NOT NULL,
    periodicita_fornitura varchar(60) NOT NULL,
    giorno_incontro_rappresentante date NOT NULL,

    PRIMARY KEY(id_fornitura),
    CONSTRAINT tab_fornitura_ibfk_1 FOREIGN KEY(id_fornitore) REFERENCES gruppo_fornitori(id_fornitore)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella CARRELLO

CREATE TABLE carrello 
(
    id_carrello int(11) NOT NULL AUTO_INCREMENT,
    id_cliente int(11) NOT NULL,
    stato varchar(20) NOT NULL,
    totale float(5) NOT NULL,

    PRIMARY KEY(id_carrello),
    CONSTRAINT carrello_ibfk_1 FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella PRODOTTO

CREATE TABLE prodotto
(
    id_prodotto int(11) NOT NULL AUTO_INCREMENT,
    disponibilita varchar(20) NOT NULL,
    prezzo_corrente float(5) NOT NULL,
    nome varchar(20) NOT NULL,
    descrizione varchar(256) NOT NULL,

    PRIMARY KEY(id_prodotto)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella ponte CARRELLO_PRODOTTO

CREATE TABLE carrello_prodotto
(
    id_carrello int(11) NOT NULL,
    id_prodotto int(11) NOT NULL,
    quantita int(11) NOT NULL,
    prezzo_c_uno float(3) NOT NULL,

    PRIMARY KEY (id_carrello, id_prodotto),
    CONSTRAINT carrello_prodotto_ibkf1 FOREIGN KEY (id_carrello) REFERENCES carrello(id_carrello),
    CONSTRAINT carrello_prodotto_ibkf2 FOREIGN KEY (id_prodotto) REFERENCES prodotto(id_prodotto)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella FATTURA

CREATE TABLE fattura 
(
    id_fattura int(11) NOT NULL AUTO_INCREMENT,
    importo_totale float(5) NOT NULL,
    data_fatturazione date NOT NULL,
    id_punto_vendita int(11) NOT NULL,
    indirizzo_spedizione varchar(60) NOT NULL,

    PRIMARY KEY(id_fattura),
    CONSTRAINT fattura_ibfk_1 FOREIGN KEY(id_punto_vendita) REFERENCES punto_vendita(id_punto_vendita)

)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella ORDINE

CREATE TABLE ordine 
(
    id_ordine int(11) NOT NULL AUTO_INCREMENT,
    data_consegna_prevista date NOT NULL,
    id_cliente int(11) NOT NULL,
    id_fattura int(11) NOT NULL,
    indirizzo_spedizione varchar(60) NOT NULL,
    id_carrello int(11) NOT NULL,


    PRIMARY KEY(id_ordine),
    CONSTRAINT ordine_ibfk_1 FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT ordine_ibfk_2 FOREIGN KEY(id_carrello) REFERENCES carrello(id_carrello),
    CONSTRAINT ordine_ibfk_3 FOREIGN KEY(id_fattura) REFERENCES fattura(id_fattura)
    
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--Struttura della tabella PACCO

CREATE TABLE pacco
(
    codice_tracciamento varchar(15) NOT NULL,
    dimensione varchar(50) NOT NULL,
    confezione varchar(10) NOT NULL,
    peso varchar(5),
    corriere varchar(20),
    data_partenza_pacco date NOT NULL,
    id_ordine int(11) NOT NULL,

    PRIMARY KEY(codice_tracciamento),
    CONSTRAINT pacco_ibfk_1 FOREIGN KEY(id_ordine) REFERENCES ordine(id_ordine)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

