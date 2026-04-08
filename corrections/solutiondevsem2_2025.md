Voici la **résolution complète** des deux parties de ton exercice en base de données : **algèbre relationnelle + SQL**, puis les **réponses aux questions de cours sur les SGBD**.

---

#   Partie 1 — Algèbre relationnelle et SQL

---

### **1. Noms et prénoms des électeurs ayant voté pour un candidat du parti "Alliance Nationale"**

####   Algèbre relationnelle :

$$
\pi_{E.nom, E.prénom} \left( \sigma_{P.nom\_parti = 'Alliance Nationale'} \left( Électeurs\ ⨝\ Votes\ ⨝\ Candidats\ ⨝\ Partis \right) \right)
$$

####   SQL :

```sql
SELECT DISTINCT E.nom, E.prénom
FROM Électeurs E
JOIN Votes V ON E.id_electeur = V.id_electeur
JOIN Candidats C ON V.id_candidat = C.id_candidat
JOIN Partis P ON C.id_parti = P.id_parti
WHERE P.nom_parti = 'Alliance Nationale';
```

---

### **2. Candidats ayant obtenu des votes dans la zone "Dakar Plateau"**

####   Algèbre relationnelle :

$$
\pi_{C.nom, C.prénom} \left( \sigma_{Z.nom\_zone = 'Dakar Plateau'} \left( Candidats\ ⨝\ Votes\ ⨝\ Bureaux\_Vote\ ⨝\ Zones \right) \right)
$$

####   SQL :

```sql
SELECT DISTINCT C.nom, C.prénom
FROM Candidats C
JOIN Votes V ON C.id_candidat = V.id_candidat
JOIN Bureaux_Vote B ON V.id_bureau = B.id_bureau
JOIN Zones Z ON B.id_zone = Z.id_zone
WHERE Z.nom_zone = 'Dakar Plateau';
```

---

### **3. Électeurs ayant voté à l’élection "Présidentielle 2024"**

####   Algèbre relationnelle :

$$
\pi_{E.nom, E.prénom} \left( \sigma_{EL.nom\_election = 'Présidentielle 2024'} (Électeurs ⨝ Votes ⨝ Élections) \right)
$$

####   SQL :

```sql
SELECT DISTINCT E.nom, E.prénom
FROM Électeurs E
JOIN Votes V ON E.id_electeur = V.id_electeur
JOIN Élections EL ON V.id_election = EL.id_election
WHERE EL.nom_election = 'Présidentielle 2024';
```

---

### **4. Candidats affiliés à un parti d’orientation "Gauche"**

####   Algèbre relationnelle :

$$
\pi_{C.nom, C.prénom} \left( \sigma_{P.orientation = 'Gauche'} (Candidats ⨝ Partis) \right)
$$

####   SQL :

```sql
SELECT C.nom, C.prénom
FROM Candidats C
JOIN Partis P ON C.id_parti = P.id_parti
WHERE P.orientation = 'Gauche';
```

---

### **5. Noms des candidats n’ayant reçu aucun vote**

####   Algèbre relationnelle :

$$
\pi_{C.nom, C.prénom} (Candidats) - \pi_{C.nom, C.prénom} (Votes ⨝ Candidats)
$$

####   SQL :

```sql
SELECT C.nom, C.prénom
FROM Candidats C
WHERE C.id_candidat NOT IN (
  SELECT DISTINCT id_candidat FROM Votes
);
```

---

### **6. Électeurs résidant dans la région "Thiès" ayant participé à une élection**

####   Algèbre relationnelle :

$$
\pi_{E.nom, E.prénom} \left( \sigma_{Z.region = 'Thiès'} (Électeurs ⨝ Zones ⨝ Votes) \right)
$$

####   SQL :

```sql
SELECT DISTINCT E.nom, E.prénom
FROM Électeurs E
JOIN Zones Z ON E.id_zone = Z.id_zone
JOIN Votes V ON E.id_electeur = V.id_electeur
WHERE Z.region = 'Thiès';
```

---

### **7. Noms des partis ayant eu un candidat voté dans la zone "Kaolack"**

####   Algèbre relationnelle :

$$
\pi_{P.nom\_parti} \left( \sigma_{Z.nom\_zone = 'Kaolack'} (Votes ⨝ Candidats ⨝ Partis ⨝ Bureaux\_Vote ⨝ Zones) \right)
$$

####   SQL :

```sql
SELECT DISTINCT P.nom_parti
FROM Partis P
JOIN Candidats C ON P.id_parti = C.id_parti
JOIN Votes V ON C.id_candidat = V.id_candidat
JOIN Bureaux_Vote B ON V.id_bureau = B.id_bureau
JOIN Zones Z ON B.id_zone = Z.id_zone
WHERE Z.nom_zone = 'Kaolack';
```

---

#   Partie 2 — Questions de cours sur le SGBD

---

### **1. Quelle est la différence entre une clé primaire et une clé étrangère ?**

* **Clé primaire** : identifie **de manière unique** chaque enregistrement d’une table.
  *Exemple* : `id_electeur` dans la table `Électeurs`
* **Clé étrangère** : référence une clé primaire dans **une autre table** pour créer un lien logique.
  *Exemple* : `id_zone` dans `Électeurs` est une clé étrangère vers `Zones(id_zone)`

---

### **2. Quelles sont les principales fonctions d’un SGBD moderne ?**

* Stockage et accès structuré aux données
* Manipulation des données (via SQL)
* Sécurité et contrôle d'accès
* Intégrité et validation des données
* Gestion des transactions
* Sauvegarde et restauration
* Performance (indexation, optimisation des requêtes)

---

### **3. Qu’est-ce qu’un SGBD ? Donnez 3 exemples.**

Un **Système de Gestion de Base de Données (SGBD)** est un logiciel permettant de **créer, stocker, gérer et interroger** des données organisées.

**Exemples de SGBD relationnels :**

* MySQL
* PostgreSQL
* Oracle

---

Souhaites-tu que je te génère ce contenu en **version PDF propre**, ou que je t’aide à créer un **atelier en classe à partir de cet exercice** ?
Voici la **résolution complète** des deux parties de ton exercice en base de données : **algèbre relationnelle + SQL**, puis les **réponses aux questions de cours sur les SGBD**.

---

#   Partie 1 — Algèbre relationnelle et SQL

---

### **1. Noms et prénoms des électeurs ayant voté pour un candidat du parti "Alliance Nationale"**

####   Algèbre relationnelle :

$$
\pi_{E.nom, E.prénom} \left( \sigma_{P.nom\_parti = 'Alliance Nationale'} \left( Électeurs\ ⨝\ Votes\ ⨝\ Candidats\ ⨝\ Partis \right) \right)
$$

####   SQL :

```sql
SELECT DISTINCT E.nom, E.prénom
FROM Électeurs E
JOIN Votes V ON E.id_electeur = V.id_electeur
JOIN Candidats C ON V.id_candidat = C.id_candidat
JOIN Partis P ON C.id_parti = P.id_parti
WHERE P.nom_parti = 'Alliance Nationale';
```

---

### **2. Candidats ayant obtenu des votes dans la zone "Dakar Plateau"**

####   Algèbre relationnelle :

$$
\pi_{C.nom, C.prénom} \left( \sigma_{Z.nom\_zone = 'Dakar Plateau'} \left( Candidats\ ⨝\ Votes\ ⨝\ Bureaux\_Vote\ ⨝\ Zones \right) \right)
$$

####   SQL :

```sql
SELECT DISTINCT C.nom, C.prénom
FROM Candidats C
JOIN Votes V ON C.id_candidat = V.id_candidat
JOIN Bureaux_Vote B ON V.id_bureau = B.id_bureau
JOIN Zones Z ON B.id_zone = Z.id_zone
WHERE Z.nom_zone = 'Dakar Plateau';
```

---

### **3. Électeurs ayant voté à l’élection "Présidentielle 2024"**

####   Algèbre relationnelle :

$$
\pi_{E.nom, E.prénom} \left( \sigma_{EL.nom\_election = 'Présidentielle 2024'} (Électeurs ⨝ Votes ⨝ Élections) \right)
$$

####   SQL :

```sql
SELECT DISTINCT E.nom, E.prénom
FROM Électeurs E
JOIN Votes V ON E.id_electeur = V.id_electeur
JOIN Élections EL ON V.id_election = EL.id_election
WHERE EL.nom_election = 'Présidentielle 2024';
```

---

### **4. Candidats affiliés à un parti d’orientation "Gauche"**

####   Algèbre relationnelle :

$$
\pi_{C.nom, C.prénom} \left( \sigma_{P.orientation = 'Gauche'} (Candidats ⨝ Partis) \right)
$$

####   SQL :

```sql
SELECT C.nom, C.prénom
FROM Candidats C
JOIN Partis P ON C.id_parti = P.id_parti
WHERE P.orientation = 'Gauche';
```

---

### **5. Noms des candidats n’ayant reçu aucun vote**

####   Algèbre relationnelle :

$$
\pi_{C.nom, C.prénom} (Candidats) - \pi_{C.nom, C.prénom} (Votes ⨝ Candidats)
$$

####   SQL :

```sql
SELECT C.nom, C.prénom
FROM Candidats C
WHERE C.id_candidat NOT IN (
  SELECT DISTINCT id_candidat FROM Votes
);
```

---

### **6. Électeurs résidant dans la région "Thiès" ayant participé à une élection**

####   Algèbre relationnelle :

$$
\pi_{E.nom, E.prénom} \left( \sigma_{Z.region = 'Thiès'} (Électeurs ⨝ Zones ⨝ Votes) \right)
$$

####   SQL :

```sql
SELECT DISTINCT E.nom, E.prénom
FROM Électeurs E
JOIN Zones Z ON E.id_zone = Z.id_zone
JOIN Votes V ON E.id_electeur = V.id_electeur
WHERE Z.region = 'Thiès';
```

---

### **7. Noms des partis ayant eu un candidat voté dans la zone "Kaolack"**

####   Algèbre relationnelle :

$$
\pi_{P.nom\_parti} \left( \sigma_{Z.nom\_zone = 'Kaolack'} (Votes ⨝ Candidats ⨝ Partis ⨝ Bureaux\_Vote ⨝ Zones) \right)
$$

####   SQL :

```sql
SELECT DISTINCT P.nom_parti
FROM Partis P
JOIN Candidats C ON P.id_parti = C.id_parti
JOIN Votes V ON C.id_candidat = V.id_candidat
JOIN Bureaux_Vote B ON V.id_bureau = B.id_bureau
JOIN Zones Z ON B.id_zone = Z.id_zone
WHERE Z.nom_zone = 'Kaolack';
```

---

#   Partie 2 — Questions de cours sur le SGBD

---

### **1. Quelle est la différence entre une clé primaire et une clé étrangère ?**

* **Clé primaire** : identifie **de manière unique** chaque enregistrement d’une table.
  *Exemple* : `id_electeur` dans la table `Électeurs`
* **Clé étrangère** : référence une clé primaire dans **une autre table** pour créer un lien logique.
  *Exemple* : `id_zone` dans `Électeurs` est une clé étrangère vers `Zones(id_zone)`

---

### **2. Quelles sont les principales fonctions d’un SGBD moderne ?**

* Stockage et accès structuré aux données
* Manipulation des données (via SQL)
* Sécurité et contrôle d'accès
* Intégrité et validation des données
* Gestion des transactions
* Sauvegarde et restauration
* Performance (indexation, optimisation des requêtes)

---

### **3. Qu’est-ce qu’un SGBD ? Donnez 3 exemples.**

Un **Système de Gestion de Base de Données (SGBD)** est un logiciel permettant de **créer, stocker, gérer et interroger** des données organisées.

**Exemples de SGBD relationnels :**

* MySQL
* PostgreSQL
* Oracle

---

Souhaites-tu que je te génère ce contenu en **version PDF propre**, ou que je t’aide à créer un **atelier en classe à partir de cet exercice** ?
