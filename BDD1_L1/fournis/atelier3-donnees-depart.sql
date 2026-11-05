-- Clinique Santé Plus : données de départ de l'atelier 3
-- A exécuter APRÈS avoir créé vos dix tables (étapes 2 et 3).
-- Les patients sont insérés sans leur assurance : vous la renseignerez à l'étape 4.

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
INSERT INTO patient (num_patient, nom_patient, prenom_patient, date_naissance, sexe, tel_patient, ville) VALUES (1, 'Diop', 'Awa', DATE '1998-04-12', 'F', '77 111 22 33', 'Dakar');
INSERT INTO patient (num_patient, nom_patient, prenom_patient, date_naissance, sexe, tel_patient, ville) VALUES (2, 'Ndiaye', 'Moussa', DATE '1975-11-03', 'M', '70 444 55 66', 'Thiès');
INSERT INTO patient (num_patient, nom_patient, prenom_patient, date_naissance, sexe, tel_patient, ville) VALUES (3, 'Sarr', 'Fatou', DATE '2019-06-25', 'F', '76 777 88 99', 'Dakar');
INSERT INTO patient (num_patient, nom_patient, prenom_patient, date_naissance, sexe, tel_patient, ville) VALUES (4, 'Fall', 'Ibrahima', DATE '1988-02-14', 'M', '77 222 33 44', 'Rufisque');
INSERT INTO patient (num_patient, nom_patient, prenom_patient, date_naissance, sexe, tel_patient, ville) VALUES (5, 'Sy', 'Mariama', DATE '1993-09-30', 'F', '78 333 44 55', 'Dakar');
INSERT INTO patient (num_patient, nom_patient, prenom_patient, date_naissance, sexe, tel_patient, ville) VALUES (6, 'Diallo', 'Ousmane', DATE '2021-12-01', 'M', NULL, 'Pikine');
INSERT INTO patient (num_patient, nom_patient, prenom_patient, date_naissance, sexe, tel_patient, ville) VALUES (7, 'Thiam', 'Khady', DATE '1960-07-19', 'F', '76 444 55 66', 'Thiès');
INSERT INTO patient (num_patient, nom_patient, prenom_patient, date_naissance, sexe, tel_patient, ville) VALUES (8, 'Ndiaye', 'Aliou', DATE '2001-05-05', 'M', '70 555 66 77', 'Dakar');
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
