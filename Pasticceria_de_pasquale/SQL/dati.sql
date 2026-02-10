START TRANSACTION;

-- Password bcrypt uguale per tutti (esempio): "Password123!"
-- (va bene per dati fake di popolamento)
SET @HASH = '$2y$10$wH4bKp3dO3C9v0u8yqGvIu9dXzVdHqj3b2o9Qm2Fv9sJvYJQb8W7K';

-- =========================
-- 1) UTENTI (30)
-- =========================
INSERT INTO utente (id_utente, nome, cognome, email, cellulare, password) VALUES
(1,  'Francesco', 'De Pasquale',   'francesco.depasquale48@pasticceria.it', 2123456789, @HASH),  -- proprietario
(2,  'Marco',     'Rossi',     'marco.rossi@pasticceria.it',        2123456701, @HASH),
(3,  'Luca',      'Bianchi',   'luca.bianchi@pasticceria.it',       2123456702, @HASH),
(4,  'Giulia',    'Romano',    'giulia.romano@pasticceria.it',      2123456703, @HASH),
(5,  'Chiara',    'Greco',     'chiara.greco@pasticceria.it',       2123456704, @HASH),
(6,  'Davide',    'Ferrari',   'davide.ferrari@pasticceria.it',     2123456705, @HASH),
(7,  'Sara',      'Conti',     'sara.conti@pasticceria.it',         2123456706, @HASH),
(8,  'Alessio',   'Marino',    'alessio.marino@pasticceria.it',     2123456707, @HASH),
(9,  'Martina',   'Gallo',     'martina.gallo@pasticceria.it',      2123456708, @HASH),
(10, 'Antonio',   'Costa',     'antonio.costa@pasticceria.it',      2123456709, @HASH),
(11, 'Elena',     'Rizzo',     'elena.rizzo@pasticceria.it',        2123456710, @HASH),

(12, 'Giuseppe',  'Caruso',    'giuseppe.caruso@gmail.com',         2123456601, @HASH),
(13, 'Federica',  'Lombardo',  'federica.lombardo@gmail.com',       2123456602, @HASH),
(14, 'Salvatore', 'Russo',     'salvatore.russo@gmail.com',         2123456603, @HASH),
(15, 'Alessandra','Messina',   'alessandra.messina@gmail.com',      2123456604, @HASH),
(16, 'Simone',    'Ricci',     'simone.ricci@gmail.com',            2123456605, @HASH),
(17, 'Roberta',   'Moretti',   'roberta.moretti@gmail.com',         2123456606, @HASH),
(18, 'Andrea',    'Barone',    'andrea.barone@gmail.com',           2123456607, @HASH),
(19, 'Noemi',     'DeLuca',    'noemi.deluca@gmail.com',            2123456608, @HASH),
(20, 'Michele',   'Vitale',    'michele.vitale@gmail.com',          2123456609, @HASH),
(21, 'Claudia',   'Parisi',    'claudia.parisi@gmail.com',          2123456610, @HASH),
(22, 'Francesca', 'Fiore',     'francesca.fiore@gmail.com',         2123456611, @HASH),
(23, 'Pietro',    'Bruno',     'pietro.bruno@gmail.com',            2123456612, @HASH),
(24, 'Stefania',  'Sorrentino','stefania.sorrentino@gmail.com',     2123456613, @HASH),
(25, 'Giorgio',   'Amato',     'giorgio.amato@gmail.com',           2123456614, @HASH),
(26, 'Valeria',   'Pace',      'valeria.pace@gmail.com',            2123456615, @HASH),
(27, 'Matteo',    'Puglisi',   'matteo.puglisi@gmail.com',          2123456616, @HASH),
(28, 'Irene',     'Fazio',     'irene.fazio@gmail.com',             2123456617, @HASH),
(29, 'Nicola',    'Orlando',   'nicola.orlando@gmail.com',          2123456618, @HASH),
(30, 'Laura',     'Mancuso',   'laura.mancuso@gmail.com',           2123456619, @HASH);

-- =========================
-- 2) PROPRIETARIO (1)
-- =========================
INSERT INTO proprietario (c_fiscale, id_utente) VALUES
('DPSFNC48L26G377G', 1);

-- =========================
-- 3) CLIENTI (20) -> utente 1 + utenti 12..30
-- =========================
INSERT INTO cliente (id_cliente, indirizzo, id_utente) VALUES
(1,  'Patti (ME), Largo Jan Palach 8', 1),

(2,  'Messina (ME), Via Garibaldi 12', 12),
(3,  'Palermo (PA), Via Libertà 101',  13),
(4,  'Catania (CT), Via Etnea 55',     14),
(5,  'Siracusa (SR), Via Roma 9',      15),
(6,  'Trapani (TP), Via Fardella 22',  16),
(7,  'Ragusa (RG), Corso Italia 18',   17),
(8,  'Enna (EN), Via Pergusa 3',       18),
(9,  'Agrigento (AG), Via Atenea 77',  19),
(10, 'Caltanissetta (CL), Via Leone 5',20),
(11, 'Taormina (ME), Corso Umberto 1', 21),
(12, 'Milazzo (ME), Via Marina 40',    22),
(13, 'Barcellona (ME), Via Longano 10',23),
(14, 'Capo d''Orlando (ME), Via Piave 6',24),
(15, 'Cefalù (PA), Via Vittorio Emanuele 15',25),
(16, 'Bagheria (PA), Via Mattarella 2',26),
(17, 'Gela (CL), Via Venezia 19',      27),
(18, 'Noto (SR), Via Nicolaci 8',      28),
(19, 'Mazara del Vallo (TP), Via Castelvetrano 31',29),
(20, 'Modica (RG), Corso San Giorgio 4',30);

-- =========================
-- 4) DIPENDENTI (10) -> utenti 2..11
-- =========================
INSERT INTO dipendente (id_dipendente, contratto, turno_lavoro, id_utente) VALUES
(1,  'Indeterminato', '08:00:00', 2),
(2,  'Indeterminato', '08:00:00', 3),
(3,  'Determinato',   '08:00:00', 4),
(4,  'Indeterminato', '06:00:00', 5),
(5,  'Determinato',   '06:00:00', 6),
(6,  'Indeterminato', '07:00:00', 7),
(7,  'Determinato',   '07:00:00', 8),
(8,  'Indeterminato', '09:00:00', 9),
(9,  'Determinato',   '09:00:00', 10),
(10, 'Indeterminato', '10:00:00', 11);

-- 7 pasticceri = dipendenti 1..7
INSERT INTO pasticcere (id_pasticcere, id_dipendente) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7);

-- 3 commessi = dipendenti 8..10
INSERT INTO commesso (id_commesso, id_dipendente) VALUES
(1,8),(2,9),(3,10);

-- =========================
-- 5) FORMAZIONE 
-- =========================
INSERT INTO formazione (categoria_formazione, data_rilascio, livello, id_pasticcere) VALUES
('HACCP',            '2024-03-10', 'Base',      1),
('HACCP-Avanzato',   '2024-05-15', 'Avanzato',  2),
('Pasticceria Classica','2023-11-20','Intermedio',3),
('Decorazione Torte','2024-01-25', 'Intermedio',4),
('Cioccolateria',    '2024-02-12', 'Avanzato',  5),
('Lievitati',        '2023-10-08', 'Intermedio',6),
('Sicurezza Lavoro', '2024-04-01', 'Base',      7);

-- =========================
-- 6) AZIENDA + PUNTI VENDITA 
-- =========================
INSERT INTO azienda (p_iva, nome_azienda, indirizzo_sede, numero_dipendenti, pec, anno_fondazione, c_fiscale_proprietario) VALUES
('01234567890', 'Pasticceria De Pasquale', 'Patti (ME)', 10, 'pasticceriadepasquale@pec.it', 2018, 'DPSFNC48L26G377G');

INSERT INTO punto_vendita (id_punto_vendita, citta, orari_apertura, telefono, indirizzo, giorno_chiusura, id_azienda) VALUES
(1, 'Patti',   '08:00:00', 2123000001, 'Largo Jan Palach 8, Patti (ME)', 'Lunedì',  '01234567890'),
(2, 'Palermo', '08:30:00', 2123000002, 'Via Libertà 101, Palermo (PA)',  'Martedì', '01234567890');

-- =========================
-- 7) FORNITORI + TAB_FORNITURA (3)
-- =========================
INSERT INTO gruppo_fornitori (id_fornitore, nome, indirizzo, tipo_fornitura) VALUES
(1, 'Molini Sicilia',    'Catania (CT), Zona Industriale', 'Farina'),
(2, 'Latticini Etnei',   'Catania (CT), Via del Latte 3',  'Latte e Burro'),
(3, 'Cacao Import',      'Palermo (PA), Via Porto 14',     'Cacao e Cioccolato');

INSERT INTO tab_fornitura (id_fornitura, id_fornitore, periodicita_fornitura, giorno_incontro_rappresentante) VALUES
(1, 1, 'Settimanale', '2026-01-23'),
(2, 2, 'Bisettimanale','2026-01-24'),
(3, 3, 'Mensile',     '2026-02-01');

-- =========================
-- 8) PRODOTTI (4)
-- =========================
INSERT INTO prodotto (id_prodotto, disponibilita, prezzo_corrente, nome, descrizione) VALUES
(1, 'Disponibile', 2.50, 'Cannolo',     'Cannolo siciliano con ricotta e granella.'),
(2, 'Disponibile', 3.00, 'Cassata',     'Fetta di cassata siciliana tradizionale.'),
(3, 'Disponibile', 1.80, 'Bignè',       'Bignè salato con ripieno dolce di un qualsiasi gusto a scelta.Specialità aziendale'),
(4, 'Disponibile', 2.20, 'Brioche',     'Brioche col tuppo, perfetta con granita.');

-- =========================
-- 9) CARTE DI CREDITO (6 clienti)
-- (numeri entro range INT)
-- =========================
INSERT INTO carta_di_credito (n_carta, data_scadenza, cvv, id_cliente, intestatario) VALUES
(2000000001, '10/28', 123,  2, 'Giuseppe Caruso'),
(2000000002, '11/28', 456,  3, 'Federica Lombardo'),
(2000000003, '12/27', 789,  4, 'Salvatore Russo'),
(2000000004, '09/29', 321,  5, 'Alessandra Messina'),
(2000000005, '08/28', 654,  6, 'Simone Ricci'),
(2000000006, '07/27', 987,  7, 'Roberta Moretti');

-- =========================
-- 10) CARRELLI + CARRELLO_PRODOTTO (6 clienti)
-- =========================
INSERT INTO carrello (id_carrello, id_cliente, stato, totale) VALUES
(1, 2, 'attivo',  0.00),
(2, 3, 'attivo',  0.00),
(3, 4, 'chiuso',  0.00),
(4, 5, 'chiuso',  0.00),
(5, 6, 'attivo',  0.00),
(6, 7, 'chiuso',  0.00);

INSERT INTO carrello_prodotto (id_carrello, id_prodotto, quantita, prezzo_c_uno) VALUES
(1, 1, 2, 2.50),
(1, 4, 1, 2.20),

(2, 2, 1, 3.00),
(2, 1, 1, 2.50),

(3, 3, 3, 1.80),

(4, 2, 2, 3.00),
(4, 4, 2, 2.20),

(5, 1, 4, 2.50),

(6, 4, 3, 2.20),
(6, 1, 1, 2.50);

-- aggiorno i totali in base ai dettagli
UPDATE carrello c
SET c.totale = (
    SELECT IFNULL(SUM(cp.quantita * cp.prezzo_c_uno), 0)
    FROM carrello_prodotto cp
    WHERE cp.id_carrello = c.id_carrello
);

-- =========================
-- 11) FATTURA + ORDINE + PACCO (2 esempi)
-- =========================
INSERT INTO fattura (id_fattura, importo_totale, data_fatturazione, id_punto_vendita, indirizzo_spedizione) VALUES
(1, (SELECT totale FROM carrello WHERE id_carrello=3), '2026-01-20', 1, (SELECT indirizzo FROM cliente WHERE id_cliente=4)),
(2, (SELECT totale FROM carrello WHERE id_carrello=4), '2026-01-20', 2, (SELECT indirizzo FROM cliente WHERE id_cliente=5));

INSERT INTO ordine (id_ordine, data_consegna_prevista, id_cliente, id_fattura, indirizzo_spedizione, id_carrello) VALUES
(1, '2026-01-23', 4, 1, (SELECT indirizzo FROM cliente WHERE id_cliente=4), 3),
(2, '2026-01-24', 5, 2, (SELECT indirizzo FROM cliente WHERE id_cliente=5), 4);

INSERT INTO pacco (codice_tracciamento, dimensione, confezione, peso, corriere, data_partenza_pacco, id_ordine) VALUES
('TRKPAST000001', 'Piccolo', 'Box', '1kg', 'SDA',  '2026-01-21', 1),
('TRKPAST000002', 'Medio',   'Box', '2kg', 'GLS',  '2026-01-21', 2);

COMMIT;
