-- Clinique Santé Plus : la base complète (structure et données), point de départ du chapitre 4 et de l'atelier 4.
-- Fonctionne sur MySQL (ou MariaDB) et PostgreSQL. Rejouable : commence par supprimer les tables.

DROP TABLE IF EXISTS paiement;
DROP TABLE IF EXISTS sejour;
DROP TABLE IF EXISTS chambre;
DROP TABLE IF EXISTS prescription;
DROP TABLE IF EXISTS medicament;
DROP TABLE IF EXISTS consultation;
DROP TABLE IF EXISTS patient;
DROP TABLE IF EXISTS assurance;
DROP TABLE IF EXISTS medecin;
DROP TABLE IF EXISTS service;

CREATE TABLE service (
    code_service VARCHAR(5)  PRIMARY KEY,
    nom_service  VARCHAR(40) NOT NULL UNIQUE,
    etage        INT         NOT NULL CHECK (etage BETWEEN 0 AND 5)
);

CREATE TABLE medecin (
    num_medecin    INT         PRIMARY KEY,
    nom_medecin    VARCHAR(50) NOT NULL,
    prenom_medecin VARCHAR(50) NOT NULL,
    specialite     VARCHAR(40) NOT NULL,
    tel_medecin    VARCHAR(20),
    code_service   VARCHAR(5)  NOT NULL,
    CONSTRAINT fk_medecin_service FOREIGN KEY (code_service) REFERENCES service (code_service)
);

CREATE TABLE assurance (
    code_assurance       VARCHAR(10) PRIMARY KEY,
    nom_assureur         VARCHAR(60) NOT NULL,
    taux_prise_en_charge INT         NOT NULL,
    CONSTRAINT ck_taux CHECK (taux_prise_en_charge BETWEEN 0 AND 100)
);

CREATE TABLE patient (
    num_patient    INT         PRIMARY KEY,
    nom_patient    VARCHAR(50) NOT NULL,
    prenom_patient VARCHAR(50) NOT NULL,
    date_naissance DATE,
    sexe           CHAR(1),
    tel_patient    VARCHAR(20),
    ville          VARCHAR(40) DEFAULT 'Dakar',
    code_assurance VARCHAR(10),
    CONSTRAINT ck_sexe CHECK (sexe IN ('F', 'M')),
    CONSTRAINT fk_patient_assurance FOREIGN KEY (code_assurance)
        REFERENCES assurance (code_assurance) ON DELETE SET NULL
);

CREATE TABLE consultation (
    num_consultation  INT          PRIMARY KEY,
    date_consultation DATE         NOT NULL,
    motif             VARCHAR(100),
    tarif             INT          NOT NULL,
    num_patient       INT          NOT NULL,
    num_medecin       INT          NOT NULL,
    CONSTRAINT ck_tarif CHECK (tarif >= 0),
    CONSTRAINT fk_consultation_patient FOREIGN KEY (num_patient) REFERENCES patient (num_patient),
    CONSTRAINT fk_consultation_medecin FOREIGN KEY (num_medecin) REFERENCES medecin (num_medecin)
);

CREATE TABLE medicament (
    code_medicament VARCHAR(10) PRIMARY KEY,
    nom_medicament  VARCHAR(60) NOT NULL,
    forme           VARCHAR(20)
);

CREATE TABLE prescription (
    num_consultation INT          NOT NULL,
    code_medicament  VARCHAR(10)  NOT NULL,
    posologie        VARCHAR(100) NOT NULL,
    duree_jours      INT,
    CONSTRAINT pk_prescription PRIMARY KEY (num_consultation, code_medicament),
    CONSTRAINT ck_duree CHECK (duree_jours > 0),
    CONSTRAINT fk_prescription_consultation FOREIGN KEY (num_consultation)
        REFERENCES consultation (num_consultation) ON DELETE CASCADE,
    CONSTRAINT fk_prescription_medicament FOREIGN KEY (code_medicament) REFERENCES medicament (code_medicament)
);

CREATE TABLE chambre (
    num_chambre   VARCHAR(6)  PRIMARY KEY,
    type_chambre  VARCHAR(12) NOT NULL,
    prix_nuit     INT         NOT NULL,
    etage_chambre INT         NOT NULL,
    code_service  VARCHAR(5)  NOT NULL,
    CONSTRAINT ck_type_chambre CHECK (type_chambre IN ('individuelle', 'double')),
    CONSTRAINT ck_prix_nuit CHECK (prix_nuit > 0),
    CONSTRAINT fk_chambre_service FOREIGN KEY (code_service) REFERENCES service (code_service)
);

CREATE TABLE sejour (
    num_sejour  INT        PRIMARY KEY,
    date_entree DATE       NOT NULL,
    date_sortie DATE,
    num_patient INT        NOT NULL,
    num_chambre VARCHAR(6) NOT NULL,
    num_medecin INT        NOT NULL,
    CONSTRAINT ck_dates_sejour CHECK (date_sortie IS NULL OR date_sortie >= date_entree),
    CONSTRAINT fk_sejour_patient FOREIGN KEY (num_patient) REFERENCES patient (num_patient),
    CONSTRAINT fk_sejour_chambre FOREIGN KEY (num_chambre) REFERENCES chambre (num_chambre),
    CONSTRAINT fk_sejour_medecin FOREIGN KEY (num_medecin) REFERENCES medecin (num_medecin)
);

CREATE TABLE paiement (
    num_paiement     INT         PRIMARY KEY,
    date_paiement    DATE        NOT NULL,
    montant          INT         NOT NULL,
    mode_paiement    VARCHAR(15) NOT NULL,
    num_consultation INT         NOT NULL,
    CONSTRAINT ck_montant CHECK (montant > 0),
    CONSTRAINT ck_mode CHECK (mode_paiement IN ('especes', 'mobile money', 'carte', 'assurance')),
    CONSTRAINT fk_paiement_consultation FOREIGN KEY (num_consultation) REFERENCES consultation (num_consultation)
);

-- Données
INSERT INTO service (code_service, nom_service, etage) VALUES ('GEN', 'Consultations générales', 0);
INSERT INTO service (code_service, nom_service, etage) VALUES ('PED', 'Pédiatrie', 1);
INSERT INTO service (code_service, nom_service, etage) VALUES ('CAR', 'Cardiologie', 2);
INSERT INTO service (code_service, nom_service, etage) VALUES ('MAT', 'Maternité', 1);

INSERT INTO medecin VALUES (1, 'Ba', 'Mamadou', 'Médecine générale', '77 100 20 30', 'GEN');
INSERT INTO medecin VALUES (2, 'Faye', 'Aminata', 'Pédiatrie', '78 200 30 40', 'PED');
INSERT INTO medecin VALUES (3, 'Sow', 'Ibrahima', 'Cardiologie', NULL, 'CAR');
INSERT INTO medecin VALUES (4, 'Kane', 'Ndeye', 'Pédiatrie', '76 300 40 50', 'PED');
INSERT INTO medecin VALUES (5, 'Mbaye', 'Rokhaya', 'Gynécologie', '77 500 60 70', 'MAT');
INSERT INTO medecin VALUES (6, 'Gueye', 'Cheikh', 'Médecine générale', '70 600 70 80', 'GEN');

INSERT INTO assurance VALUES ('IPM-SONA', 'IPM Sonatel', 80);
INSERT INTO assurance VALUES ('MUT-ENS', 'Mutuelle des enseignants', 70);
INSERT INTO assurance VALUES ('ASS-PRIV', 'Assurance privée Teranga', 100);

INSERT INTO patient VALUES (1, 'Diop', 'Awa', DATE '1998-04-12', 'F', '77 111 22 33', 'Dakar', 'IPM-SONA');
INSERT INTO patient VALUES (2, 'Ndiaye', 'Moussa', DATE '1975-11-03', 'M', '70 444 55 66', 'Thiès', 'MUT-ENS');
INSERT INTO patient VALUES (3, 'Sarr', 'Fatou', DATE '2019-06-25', 'F', '76 777 88 99', 'Dakar', NULL);
INSERT INTO patient VALUES (4, 'Fall', 'Ibrahima', DATE '1988-02-14', 'M', '77 222 33 44', 'Rufisque', NULL);
INSERT INTO patient VALUES (5, 'Sy', 'Mariama', DATE '1993-09-30', 'F', '78 333 44 55', 'Dakar', 'IPM-SONA');
INSERT INTO patient VALUES (6, 'Diallo', 'Ousmane', DATE '2021-12-01', 'M', NULL, 'Pikine', NULL);
INSERT INTO patient VALUES (7, 'Thiam', 'Khady', DATE '1960-07-19', 'F', '76 444 55 66', 'Thiès', 'ASS-PRIV');
INSERT INTO patient VALUES (8, 'Ndiaye', 'Aliou', DATE '2001-05-05', 'M', '70 555 66 77', 'Dakar', NULL);

INSERT INTO consultation VALUES (1, DATE '2026-10-05', 'Fièvre', 10000, 1, 1);
INSERT INTO consultation VALUES (2, DATE '2026-10-05', 'Toux persistante', 15000, 3, 2);
INSERT INTO consultation VALUES (3, DATE '2026-10-12', 'Contrôle tension', 20000, 2, 3);
INSERT INTO consultation VALUES (4, DATE '2026-10-14', 'Suivi de grossesse', 15000, 5, 5);
INSERT INTO consultation VALUES (5, DATE '2026-10-15', 'Fièvre', 15000, 6, 4);
INSERT INTO consultation VALUES (6, DATE '2026-10-19', 'Douleurs thoraciques', 20000, 7, 3);
INSERT INTO consultation VALUES (7, DATE '2026-10-20', 'Paludisme', 10000, 4, 6);
INSERT INTO consultation VALUES (8, DATE '2026-10-21', 'Contrôle', 10000, 1, 1);
INSERT INTO consultation VALUES (9, DATE '2026-10-22', 'Vaccination', 15000, 3, 2);
INSERT INTO consultation VALUES (10, DATE '2026-10-26', 'Paludisme', 10000, 8, 1);

INSERT INTO medicament VALUES ('PARA500', 'Paracétamol 500 mg', 'comprimé');
INSERT INTO medicament VALUES ('AMOX250', 'Amoxicilline 250 mg', 'sirop');
INSERT INTO medicament VALUES ('ARTE20', 'Artéméther-luméfantrine 20/120', 'comprimé');
INSERT INTO medicament VALUES ('AMLO5', 'Amlodipine 5 mg', 'comprimé');
INSERT INTO medicament VALUES ('FER', 'Fer et acide folique', 'comprimé');
INSERT INTO medicament VALUES ('SRO', 'Sels de réhydratation orale', 'sachet');

INSERT INTO prescription VALUES (1, 'PARA500', '1 comprimé 3 fois par jour', 5);
INSERT INTO prescription VALUES (2, 'AMOX250', '1 cuillère matin et soir', 7);
INSERT INTO prescription VALUES (2, 'PARA500', '1/2 comprimé si fièvre', 3);
INSERT INTO prescription VALUES (3, 'AMLO5', '1 comprimé le matin', 30);
INSERT INTO prescription VALUES (4, 'FER', '1 comprimé par jour', 90);
INSERT INTO prescription VALUES (5, 'PARA500', '1/2 comprimé si fièvre', 3);
INSERT INTO prescription VALUES (5, 'SRO', '1 sachet après chaque selle', 3);
INSERT INTO prescription VALUES (7, 'ARTE20', '4 comprimés 2 fois par jour', 3);
INSERT INTO prescription VALUES (7, 'PARA500', '1 comprimé 3 fois par jour', 3);
INSERT INTO prescription VALUES (10, 'ARTE20', '4 comprimés 2 fois par jour', 3);

INSERT INTO chambre VALUES ('P-11', 'individuelle', 25000, 1, 'PED');
INSERT INTO chambre VALUES ('P-12', 'double', 15000, 1, 'PED');
INSERT INTO chambre VALUES ('C-21', 'individuelle', 35000, 2, 'CAR');
INSERT INTO chambre VALUES ('M-13', 'double', 20000, 1, 'MAT');
INSERT INTO chambre VALUES ('G-01', 'individuelle', 20000, 0, 'GEN');

INSERT INTO sejour VALUES (1, DATE '2026-10-15', DATE '2026-10-18', 6, 'P-12', 4);
INSERT INTO sejour VALUES (2, DATE '2026-10-19', DATE '2026-10-24', 7, 'C-21', 3);
INSERT INTO sejour VALUES (3, DATE '2026-10-27', NULL, 5, 'M-13', 5);

INSERT INTO paiement VALUES (1, DATE '2026-10-05', 10000, 'especes', 1);
INSERT INTO paiement VALUES (2, DATE '2026-10-05', 15000, 'mobile money', 2);
INSERT INTO paiement VALUES (3, DATE '2026-10-12', 14000, 'assurance', 3);
INSERT INTO paiement VALUES (4, DATE '2026-10-12', 6000, 'especes', 3);
INSERT INTO paiement VALUES (5, DATE '2026-10-14', 12000, 'assurance', 4);
INSERT INTO paiement VALUES (6, DATE '2026-10-15', 15000, 'mobile money', 5);
INSERT INTO paiement VALUES (7, DATE '2026-10-19', 20000, 'assurance', 6);
INSERT INTO paiement VALUES (8, DATE '2026-10-20', 5000, 'especes', 7);
INSERT INTO paiement VALUES (9, DATE '2026-10-21', 8000, 'assurance', 8);

-- Ajouts du chapitre 4 : une patiente qui vient de s'inscrire (aucune consultation)
-- et un médicament que la pharmacie vient de recevoir (jamais prescrit).
INSERT INTO patient VALUES (9, 'Cissé', 'Bineta', DATE '2005-03-08', 'F', '78 999 00 11', 'Saint-Louis', NULL);
INSERT INTO medicament VALUES ('IBU400', 'Ibuprofène 400 mg', 'comprimé');
