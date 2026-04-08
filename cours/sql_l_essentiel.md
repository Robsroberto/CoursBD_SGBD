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

# SQL – L’Essentiel à Retenir
## Par Robert DIASSÉ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<img src="sql.jpeg" alt="ISI" width="50px">

## 1. STRUCTURE DE BASE D’UNE BASE RELATIONNELLE

### Notions fondamentales :
- **Base de données** : ensemble structuré de tables liées entre elles.
- **Table (relation)** : structure avec lignes (enregistrements) et colonnes (attributs).
- **Clé primaire (PRIMARY KEY)** : identifie chaque ligne de manière unique.
- **Clé étrangère (FOREIGN KEY)** : crée un lien logique entre deux tables.

### Exemple de table :
```sql
CREATE TABLE Etudiants (
  id INT PRIMARY KEY,
  nom VARCHAR(50),
  age INT
);
```
---

## 2. CATÉGORIES DE COMMANDES SQL

### Langage de Définition de Données (LDD – DDL)

Utilisé pour créer ou modifier la structure des bases.

```sql
CREATE DATABASE nom_bdd;
USE nom_bdd;
CREATE TABLE ...;
ALTER TABLE ...;
DROP TABLE ...;
```

### Langage de Manipulation de Données (LMD – DML)

Utilisé pour ajouter, modifier ou supprimer les données.

```sql
INSERT INTO table VALUES (...);
UPDATE table SET colonne = valeur WHERE ...;
DELETE FROM table WHERE ...;
```

### Langage de Requête de Données (SELECT – LMD aussi)

Utilisé pour interroger les données.

```sql
SELECT * FROM table;
SELECT colonne1, colonne2 FROM table WHERE condition;
```

---

## 3. STRUCTURE D’UNE REQUÊTE SELECT

### Syntaxe générale :

```sql
SELECT colonnes
FROM table
WHERE condition
GROUP BY colonne
HAVING condition_sur_groupe
ORDER BY colonne ASC|DESC
LIMIT n;
```

### Principales clauses :

* `SELECT` : permet de choisir les colonnes à afficher.
* `FROM` : indique de quelle table on lit les données.
* `WHERE` : filtre les lignes selon une condition.
* `ORDER BY` : trie les résultats selon une ou plusieurs colonnes.
* `LIMIT` : limite le nombre de résultats retournés.

---

## 4. FONCTIONS COURANTES

### Fonctions d’agrégation (utilisées avec GROUP BY)

```sql
COUNT(*)      -- Nombre de lignes
SUM(colonne)  -- Somme des valeurs
AVG(colonne)  -- Moyenne des valeurs
MAX(colonne)  -- Valeur maximale
MIN(colonne)  -- Valeur minimale
```

### Fonctions de texte

```sql
LENGTH(texte)      -- Renvoie la longueur d’une chaîne
UPPER(texte)       -- Convertit en majuscules
LOWER(texte)       -- Convertit en minuscules
CONCAT(t1, t2)     -- Concatène deux textes
```

---

## 5. FILTRAGE DES DONNÉES (WHERE)

Le mot-clé `WHERE` est utilisé pour filtrer les lignes selon une condition :

```sql
WHERE age > 20
WHERE nom = 'Ali'
WHERE age BETWEEN 20 AND 30
WHERE nom LIKE 'A%'           -- commence par A
WHERE age IN (18, 20, 22)
WHERE adresse IS NULL         -- valeur manquante
```

---

## 6. JOINTURES ENTRE TABLES

### Jointure interne (INNER JOIN)

Permet de combiner les lignes de plusieurs tables quand une correspondance est trouvée.

```sql
SELECT E.nom, C.nom_cours
FROM Etudiants E
JOIN Inscriptions I ON E.id = I.id_etudiant
JOIN Cours C ON I.id_cours = C.id_cours;
```

### Jointure externe (LEFT JOIN)

Permet d'afficher toutes les lignes d'une table, même s’il n’y a pas de correspondance dans l’autre.

```sql
SELECT E.nom, N.note
FROM Etudiants E
LEFT JOIN Notes N ON E.id = N.id_etudiant;
```

---

## 7. GROUPEMENT ET AGGRÉGATION (GROUP BY / HAVING)

Utilisé pour regrouper les résultats et effectuer des calculs par groupe (ex : moyenne par cours).

```sql
SELECT id_cours, AVG(note)
FROM Notes
GROUP BY id_cours
HAVING AVG(note) > 12;
```

* `GROUP BY` : regroupe les résultats selon une ou plusieurs colonnes.
* `HAVING` : filtre les groupes (comme WHERE filtre les lignes).

---

## 8. REQUÊTES IMBRIQUÉES (NESTED QUERIES)

Une requête peut être utilisée à l’intérieur d’une autre.

```sql
SELECT nom, prenom
FROM Etudiants
WHERE id IN (
  SELECT id_etudiant
  FROM Notes
  WHERE note < 10
);
```

---

## 9. CONTRAINTES IMPORTANTES À LA CRÉATION

```sql
PRIMARY KEY(id)                                   -- clé unique obligatoire
FOREIGN KEY(id_cours) REFERENCES Cours(id_cours)  -- clé étrangère
NOT NULL                                          -- champ obligatoire
UNIQUE                                            -- valeur non dupliquée
CHECK (note >= 0 AND note <= 20)                  -- contrainte logique
```

---

## 10. BONNES PRATIQUES POUR APPRENDRE

* Créer un petit projet de base (étudiants, notes, cours…).
* Tester chaque commande dans un environnement simple (MySQL, SQLite…).
* Nommer les colonnes et les tables de manière claire.
* Ajouter petit à petit des conditions ou jointures.
* Lire les messages d’erreur : ils sont vos alliés.
* Utiliser `SELECT * FROM table` pour vérifier le contenu à tout moment.

---

