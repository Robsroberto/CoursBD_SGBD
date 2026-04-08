---
marp: false
size: 4:3
style: |
  h2, h3, p {
    font-size: 20px;
  }
  li {
    font-size:20px
  }
headingDivider: 1
header: 
paginate: 
footer: Licence 2 Informatique &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ISI (Institut Supérieur D'Informatique) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RD
---
<img src="../isi.png" alt="ISI" width="100px">

# 📝 Atelier SQL & Algèbre Relationnelle — Gestion d’Étudiants

## Par Robert DIASSÉ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<img src="sql.jpeg" alt="ISI" width="50px">

## Contexte

L’université souhaite gérer ses étudiants, leurs inscriptions aux cours, les enseignants, les salles de cours et les notes obtenues par les étudiants.

---

## Schéma relationnel

* **Etudiants**(id\_etudiant, nom, prenom, date\_naissance, adresse)
* **Enseignants**(id\_enseignant, nom\_ens, prenom\_ens, specialite)
* **Cours**(id\_cours, nom\_cours, #id\_enseignant)
* **Inscriptions**(id\_inscription, #id\_etudiant, #id\_cours, date\_inscription)
* **Salles**(id\_salle, nom\_salle, capacite)
* **Notes**(id\_note, #id\_etudiant, #id\_cours, note)

---

## Objectifs de l’atelier

1. Créer la base de données en ligne de commande (MySQL).
2. Créer les tables avec les clés primaires et étrangères.
3. Insérer des données dans les tables.
4. Interroger la base :

   * En algèbre relationnelle 
   * En SQL 

---

## Partie 1 — Création de la base et des tables

> 1. Créer une base de données nommée `gestion_universite`.
> 2. Créer les 6 tables selon le schéma fourni.
> 3. Respecter les clés primaires et étrangères.

---

## Partie 2 — Insertion de données

### Table Etudiants (20 étudiants)

```sql
INSERT INTO Etudiants (id_etudiant, nom, prenom, date_naissance, adresse) VALUES
(1, 'Sow', 'Moussa', '2001-05-10', 'Dakar'),
(2, 'Fall', 'Amina', '2000-11-25', 'Saint-Louis'),
(3, 'Ba', 'Abdoulaye', '2002-03-01', 'Thiès'),
(4, 'Gueye', 'Mame Diarra', '2000-07-15', 'Kaolack'),
(5, 'Ndiaye', 'Ousmane', '2001-01-20', 'Ziguinchor'),
(6, 'Camara', 'Fatoumata', '2002-09-12', 'Tambacounda'),
(7, 'Diallo', 'Ibrahima', '2003-02-18', 'Louga'),
(8, 'Diop', 'Adama', '2000-04-30', 'Podor'),
(9, 'Thiam', 'Assane', '2001-06-22', 'Kolda'),
(10, 'Faye', 'Khady', '2001-03-05', 'Mbour'),
(11, 'Cissé', 'Babacar', '2002-11-11', 'Kaffrine'),
(12, 'Ly', 'Mariama', '2000-12-09', 'Fatick'),
(13, 'Mbaye', 'Cheikh', '2003-01-07', 'Dakar'),
(14, 'Seck', 'Ndeye', '2001-10-14', 'Thiès'),
(15, 'Ka', 'Souleymane', '2000-06-28', 'Saint-Louis'),
(16, 'Ndoye', 'Aissatou', '2002-08-25', 'Matam'),
(17, 'Lo', 'El Hadji', '2001-07-03', 'Dakar'),
(18, 'Barry', 'Awa', '2002-05-19', 'Kédougou'),
(19, 'Sagna', 'Omar', '2000-02-14', 'Ziguinchor'),
(20, 'Diop', 'Fatou', '2001-12-20', 'Bignona');

```

### Table Enseignants

```sql
INSERT INTO Enseignants VALUES
(1, 'Diallo', 'Mamadou', 'Mathématiques'),
(2, 'Ndoye', 'Mariama', 'Informatique'),
(3, 'Sy', 'Amadou', 'Économie');
```

### Table Cours

```sql
INSERT INTO Cours VALUES
(1, 'Analyse I', 1),
(2, 'Programmation', 2),
(3, 'Microéconomie', 3);
```

### Table Inscriptions (liens entre étudiants et cours)

```sql
INSERT INTO Inscriptions VALUES
(1, 1, 1, '2024-10-01'),
(2, 2, 1, '2024-10-01'),
-- ... rajouter les autres
(20, 15, 2, '2024-10-01');
```

### Table Salles

```sql
INSERT INTO Salles VALUES
(1, 'Salle A', 40),
(2, 'Salle B', 60),
(3, 'Amphi 1', 150);
```

### Table Notes

```sql
INSERT INTO Notes VALUES
(1, 1, 1, 15.5),
(2, 2, 1, 13.0),
-- ... rajouter les autres
(20, 15, 2, 17.0);
```

---

## Partie 3 — Questions en algèbre relationnelle (à résoudre seul)

1. Quels sont les noms et prénoms des étudiants inscrits au cours "Analyse I" ?
2. Quels cours sont assurés par l’enseignant "Mariama Ndoye" ?
3. Quels étudiants ont obtenu une note supérieure à 14 en Programmation ?
<!-- 4. Quels enseignants n’enseignent aucun cours ? -->
4. Quelles sont les salles pouvant accueillir plus de 100 étudiants ?
5. Quels étudiants sont inscrits à plusieurs cours ?
6. Quelles sont les notes obtenues par les étudiants du cours "Microéconomie" ?
7. Quels sont les étudiants nés avant 2001 ?
8. Quelles sont les spécialités enseignées par plus d’un enseignant ?
9. Quels sont les cours dispensés à des étudiants ayant une note inférieure à 10 ?

**Pour chaque question précédente, écrivez et exécutez la requête SQL en ligne de commande correspondante.**
--- 

<!-- ## Partie 4 — Correction SQL (exemples avec explication)

### 1. Étudiants inscrits au cours "Analyse I"

```sql
SELECT E.nom, E.prenom
FROM Etudiants E
JOIN Inscriptions I ON E.id_etudiant = I.id_etudiant
JOIN Cours C ON I.id_cours = C.id_cours
WHERE C.nom_cours = 'Analyse I';
```

### 2. Cours de "Mariama Ndoye"

```sql
SELECT C.nom_cours
FROM Cours C
JOIN Enseignants ENS ON C.id_enseignant = ENS.id_enseignant
WHERE ENS.nom_ens = 'Ndoye' AND ENS.prenom_ens = 'Mariama';
```

### 3. Étudiants avec note > 14 en Programmation

```sql
SELECT E.nom, E.prenom, N.note
FROM Notes N
JOIN Etudiants E ON N.id_etudiant = E.id_etudiant
JOIN Cours C ON N.id_cours = C.id_cours
WHERE C.nom_cours = 'Programmation' AND N.note > 14;
```
 -->
