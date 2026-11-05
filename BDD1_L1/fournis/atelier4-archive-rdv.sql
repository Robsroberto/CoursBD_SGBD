-- Clinique Santé Plus : archive des rendez-vous (100 000 lignes), pour l'étape sur les index.
-- A exécuter dans la base clinique, après clinique-complete.sql. Fonctionne sur MySQL et PostgreSQL.
-- Les lignes sont fabriquées à partir d'une petite table de chiffres (0 à 9) croisée cinq fois avec elle-même.

DROP TABLE IF EXISTS rdv_archive;
DROP TABLE IF EXISTS chiffre;

CREATE TABLE chiffre (c INT PRIMARY KEY);
INSERT INTO chiffre VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

CREATE TABLE rdv_archive (
    num_rdv     INT PRIMARY KEY,
    num_patient INT NOT NULL,
    tarif       INT NOT NULL
);

INSERT INTO rdv_archive
SELECT a.c * 10000 + b.c * 1000 + c.c * 100 + d.c * 10 + e.c + 1,
       (a.c * 10000 + b.c * 1000 + c.c * 100 + d.c * 10 + e.c) % 5000,
       10000
FROM chiffre a CROSS JOIN chiffre b CROSS JOIN chiffre c CROSS JOIN chiffre d CROSS JOIN chiffre e;

SELECT COUNT(*) AS lignes FROM rdv_archive;
