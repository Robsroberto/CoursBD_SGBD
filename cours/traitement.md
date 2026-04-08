Excellent objectif ! Pour pratiquer efficacement le SQL en ligne avec des jeux de données concrets, voici :

---

## ✅ **1. Plateformes pour exécuter du SQL en ligne avec ou sans inscription**

### 🔹 [DB Fiddle](https://www.db-fiddle.com/)

* ✅ **Gratuit**, **rapide**, pas d’inscription obligatoire.
* Supporte **MySQL**, **PostgreSQL**, **SQLite**, etc.
* Sauvegarde de sessions et partage de lien.

### 🔹 [SQL Fiddle](http://sqlfiddle.com/)

* Similaire à DB Fiddle, un peu moins stable mais utile pour tester du code.
* Support de plusieurs moteurs.

### 🔹 [Mode SQL](https://mode.com/sql/)

* Interface pro, gratuite avec compte.
* Très bon pour les requêtes avancées + visualisation.

### 🔹 [LeetCode SQL Playground](https://leetcode.com/problemset/database/)

* Propose des **problèmes classés par niveau**.
* Chaque exercice est accompagné de son schéma et ses données.

### 🔹 [W3Schools Try SQL](https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all)

* Base de données de démonstration prête à l’emploi (table `Customers`, `Orders`, etc.).
* Interface simple, idéale pour débutants.

---

## ✅ **2. Jeux de données prêts à l’emploi (avec plateformes compatibles)**

### 🔸 A. **Base de données « École »**

> Structure : `Etudiants`, `Cours`, `Inscriptions`, `Notes`

📌 Lien pratique : [https://sqliteonline.com/](https://sqliteonline.com/)
Colle-y ce SQL de création :

```sql
CREATE TABLE Etudiants (
  id_etudiant INTEGER PRIMARY KEY,
  nom TEXT,
  prenom TEXT,
  date_naissance DATE
);

CREATE TABLE Cours (
  id_cours INTEGER PRIMARY KEY,
  nom_cours TEXT,
  enseignant TEXT
);

CREATE TABLE Inscriptions (
  id_inscription INTEGER PRIMARY KEY,
  id_etudiant INTEGER,
  id_cours INTEGER,
  FOREIGN KEY (id_etudiant) REFERENCES Etudiants(id_etudiant),
  FOREIGN KEY (id_cours) REFERENCES Cours(id_cours)
);

CREATE TABLE Notes (
  id_note INTEGER PRIMARY KEY,
  id_etudiant INTEGER,
  id_cours INTEGER,
  note REAL
);

-- Données
INSERT INTO Etudiants VALUES (1, 'Sow', 'Moussa', '2001-05-10'), (2, 'Fall', 'Amina', '2000-11-25');
INSERT INTO Cours VALUES (1, 'Maths', 'Mr Sy'), (2, 'Physique', 'Mme Ndiaye');
INSERT INTO Inscriptions VALUES (1, 1, 1), (2, 1, 2), (3, 2, 1);
INSERT INTO Notes VALUES (1, 1, 1, 14), (2, 1, 2, 16), (3, 2, 1, 10);
```

📘 **Questions à poser en SQL** :

1. Liste des étudiants inscrits en « Maths »
2. Moyenne des notes par étudiant
3. Étudiants ayant une note > 12
4. Nombre d’étudiants par cours
5. Qui n’a pas encore de note ?

---

### 🔸 B. **Base « Ventes / Clients / Produits »**

📌 Lien prêt : [W3Schools SQL TryIt](https://www.w3schools.com/sql/trysql.asp)

Tables disponibles :

* `Customers`, `Orders`, `Products`, `Employees`, `Shippers`

📘 **Questions d’exercices :**

1. Quels sont les clients en Allemagne ?
2. Combien de commandes ont été passées par `ALFKI` ?
3. Quel est le prix moyen des produits vendus par `SupplierID = 1` ?
4. Quels produits coûtent plus que la moyenne ?
5. Combien d’employés travaillent à `London` ?

---

### 🔸 C. **Base de données « Mondiale / Pays / Villes »**

📌 [https://github.com/datasets](https://github.com/datasets/population)
Télécharge les CSV (population, pays, régions) et utilise-les dans [https://sqliteonline.com](https://sqliteonline.com) ou [https://mode.com/sql](https://mode.com/sql)

📘 **Questions intéressantes :**

1. Liste des pays avec plus de 100M d’habitants
2. Pays d’Afrique classés par population
3. Évolution de la population d’un pays donné
4. Quelle région regroupe le plus de population ?
5. Moyenne de population par continent

---

## 🔁 Pour chaque plateforme :

| Plateforme   | SQL exécutables | Peut créer tables ? | Jeux fournis ? | Export ? |
| ------------ | --------------- | ------------------- | -------------- | -------- |
| DB Fiddle    | ✅ Oui           | ✅ Oui               | ❌ Non          | ✅ Oui    |
| W3Schools    | ✅ Oui           | ❌ Non (fixe)        | ✅ Oui          | ❌ Non    |
| SQLiteOnline | ✅ Oui           | ✅ Oui               | ❌              | ✅        |
| Mode SQL     | ✅ Oui           | ✅ (via import)      | ❌              | ✅        |
| LeetCode SQL | ✅ Oui           | ❌ (exos imposés)    | ✅ (beaucoup)   | ❌        |

---

Souhaites-tu que je t’organise tout cela dans :

* Un **PDF ou document** prêt à imprimer ?
* Un **template markdown** ou html pour ton site ?
* Ou bien que je te prépare un **atelier multi-niveaux avec exercices interactifs** à copier sur une plateforme comme DB Fiddle ou SQLiteOnline ?


Voici les **solutions SQL** pour les 5 questions basées sur un jeu de données de population (typiquement trouvé dans des jeux comme [UN population dataset](https://github.com/datasets/population)) contenant une table comme :

```sql
population(country_name, country_code, year, value)
```

Et éventuellement une table `countries` ou `regions` :

```sql
countries(country_code, name, continent, region)
```

---

### **1. Liste des pays avec plus de 100M d’habitants**

On suppose qu’on veut la population la plus récente (par exemple 2022).

```sql
SELECT country_name, value AS population
FROM population
WHERE year = 2022 AND value > 100000000
ORDER BY value DESC;
```

---

### **2. Pays d’Afrique classés par population**

```sql
SELECT c.name AS country, p.value AS population
FROM population p
JOIN countries c ON p.country_code = c.country_code
WHERE p.year = 2022 AND c.continent = 'Africa'
ORDER BY p.value DESC;
```

---

### **3. Évolution de la population d’un pays donné (ex : Sénégal)**

```sql
SELECT year, value AS population
FROM population
WHERE country_name = 'Senegal'
ORDER BY year ASC;
```

---

### **4. Quelle région regroupe le plus de population ?**

```sql
SELECT c.region, SUM(p.value) AS total_population
FROM population p
JOIN countries c ON p.country_code = c.country_code
WHERE p.year = 2022
GROUP BY c.region
ORDER BY total_population DESC
LIMIT 1;
```

---

### **5. Moyenne de population par continent**

```sql
SELECT c.continent, AVG(p.value) AS avg_population
FROM population p
JOIN countries c ON p.country_code = c.country_code
WHERE p.year = 2022
GROUP BY c.continent
ORDER BY avg_population DESC;
```

---

💡 **Remarques :**

* Remplace `2022` par une autre année selon ton jeu de données.
* Les noms de colonnes (`country_name`, `value`, etc.) peuvent varier selon la source. Vérifie le schéma réel.

Souhaites-tu aussi que je te fournisse un jeu d’exercices à faire sur ce dataset avec corrigés progressifs ?
