

# 🛠 Atelier : Gestion de Réservation de Voyages

## 📚 Partie 1 — Questions en Algèbre Relationnelle (À résoudre par les étudiants)

**Données de base** :  
Schéma relationnel :
- Voyageurs(id_voyageur, nom, prenom, date_naissance, adresse)
- Voyages(id_voyage, destination, date_depart, date_retour)
- Reservations(id_reservation, id_voyageur, id_voyage)
- Hotels(id_hotel, nom_hotel, adresse_hotel)
- Chambres(id_chambre, id_hotel, type_chambre, prix_nuit)

---

**Questions :**

1. Quels sont les noms et prénoms des voyageurs ayant réservé un voyage ?
2. Quelles sont les destinations des voyages réservés par le voyageur numéro 1 ?
3. Quels sont les hôtels proposant des chambres à moins de 100$ par nuit ?
4. Quels voyageurs ont réservé un voyage vers la destination "Brésil" ?
5. Quelle est la date de départ du voyage réservé par le voyageur Abdou Kane ?
6. Quels sont les types de chambres disponibles dans l'hôtel "Radisson" ?
7. Quels sont les prix des chambres dans tous les hôtels situés à "Mbour" ?
8. Quels voyageurs ont réservé un voyage pour la période du 1er juillet au 15 août ?

---

# 🛠 Partie 2 — Correction SQL complète avec explications

---

## **1. Noms et prénoms des voyageurs ayant réservé un voyage**

```sql
SELECT V.nom, V.prenom
FROM Voyageurs V
INNER JOIN Reservations R ON V.id_voyageur = R.id_voyageur;
```

**Explication** :  
On fait une jointure entre `Voyageurs` et `Reservations` sur `id_voyageur`, puis on sélectionne `nom` et `prenom`.

---

## **2. Destinations des voyages réservés par le voyageur numéro 1**

```sql
SELECT VOY.destination
FROM Voyages VOY
INNER JOIN Reservations R ON VOY.id_voyage = R.id_voyage
WHERE R.id_voyageur = 1;
```

**Explication** :  
On relie `Voyages` et `Reservations`, puis on filtre sur `id_voyageur = 1`.

---

## **3. Hôtels proposant des chambres à moins de 100$ par nuit**

```sql
SELECT DISTINCT H.nom_hotel
FROM Hotels H
INNER JOIN Chambres C ON H.id_hotel = C.id_hotel
WHERE C.prix_nuit < 100;
```

**Explication** :  
Jointure entre `Hotels` et `Chambres`, puis on filtre sur `prix_nuit < 100`.

---

## **4. Voyageurs ayant réservé un voyage vers le "Brésil"**

```sql
SELECT V.nom, V.prenom
FROM Voyageurs V
INNER JOIN Reservations R ON V.id_voyageur = R.id_voyageur
INNER JOIN Voyages VOY ON R.id_voyage = VOY.id_voyage
WHERE VOY.destination = 'Brésil';
```

**Explication** :  
Double jointure : `Voyageurs` ↔ `Reservations` ↔ `Voyages`, puis filtre sur destination.

---

## **5. Date de départ du voyage réservé par Abdou Kane**

```sql
SELECT VOY.date_depart
FROM Voyageurs V
INNER JOIN Reservations R ON V.id_voyageur = R.id_voyageur
INNER JOIN Voyages VOY ON R.id_voyage = VOY.id_voyage
WHERE V.nom = 'Kane' AND V.prenom = 'Abdou';
```

**Explication** :  
Double jointure + filtre sur le `nom` et le `prenom`.

---

## **6. Types de chambres disponibles dans l'hôtel "Radisson"**

```sql
SELECT C.type_chambre
FROM Chambres C
INNER JOIN Hotels H ON C.id_hotel = H.id_hotel
WHERE H.nom_hotel = 'Radisson';
```

**Explication** :  
Jointure `Chambres` ↔ `Hotels`, filtre sur le `nom_hotel`.

---

## **7. Prix des chambres dans les hôtels situés à "Mbour"**

```sql
SELECT C.prix_nuit
FROM Chambres C
INNER JOIN Hotels H ON C.id_hotel = H.id_hotel
WHERE H.adresse_hotel = 'Mbour';
```

**Explication** :  
Même type de jointure, mais filtre sur `adresse_hotel`.

---

## **8. Voyageurs ayant réservé un voyage entre le 1er juillet et le 15 août**

```sql
SELECT V.nom, V.prenom
FROM Voyageurs V
INNER JOIN Reservations R ON V.id_voyageur = R.id_voyageur
INNER JOIN Voyages VOY ON R.id_voyage = VOY.id_voyage
WHERE VOY.date_depart BETWEEN '2024-07-01' AND '2024-08-15';
```

**Explication** :  
Double jointure + condition `BETWEEN` pour la plage de dates.

---

# 📌 Résumé rapide

- **Algèbre relationnelle** → laisser les étudiants réfléchir.
- **SQL** → fournir une correction propre + commentée.
- **Travail concret** → création de la base, remplissage, interrogation.

---

Veux-tu aussi que je prépare **un modèle d'énoncé prêt à imprimer** (genre feuille d'examen/exercice pour distribuer) ?  
Cela te fera gagner encore plus de temps si tu veux faire un vrai atelier ! 🚀


Parfait, tu veux mettre en place **un vrai atelier pratique** — très bien pensé pour progresser sur **la création de bases de données** et l’application en **algèbre relationnelle + SQL**.

Voici l’**atelier structuré étape par étape**, totalement basé sur ton schéma relationnel :

---

# 🛠 Atelier : Création d’une Base de Données de Gestion de Voyages

## **Contexte**
On veut créer un système simple de réservation de voyages avec gestion des voyageurs, des voyages, des hôtels et des chambres.

---

## **Phase 1 : Création de la base de données**

### 1.1. Créer la base de données
```sql
CREATE DATABASE gestion_voyages;
USE gestion_voyages;
```

---

### 1.2. Création des tables

**Table Voyageurs**
```sql
CREATE TABLE Voyageurs (
  id_voyageur INT PRIMARY KEY,
  nom VARCHAR(50),
  prenom VARCHAR(50),
  date_naissance DATE,
  adresse VARCHAR(100)
);
```

**Table Voyages**
```sql
CREATE TABLE Voyages (
  id_voyage INT PRIMARY KEY,
  destination VARCHAR(50),
  date_depart DATE,
  date_retour DATE
);
```

**Table Reservations**
```sql
CREATE TABLE Reservations (
  id_reservation INT PRIMARY KEY,
  id_voyageur INT,
  id_voyage INT,
  FOREIGN KEY (id_voyageur) REFERENCES Voyageurs(id_voyageur),
  FOREIGN KEY (id_voyage) REFERENCES Voyages(id_voyage)
);
```

**Table Hotels**
```sql
CREATE TABLE Hotels (
  id_hotel INT PRIMARY KEY,
  nom_hotel VARCHAR(50),
  adresse_hotel VARCHAR(100)
);
```

**Table Chambres**
```sql
CREATE TABLE Chambres (
  id_chambre INT PRIMARY KEY,
  id_hotel INT,
  type_chambre VARCHAR(30),
  prix_nuit DECIMAL(10,2),
  FOREIGN KEY (id_hotel) REFERENCES Hotels(id_hotel)
);
```

---

## **Phase 2 : Insertion de données fictives**

### 2.1. Insertion dans Voyageurs
```sql
INSERT INTO Voyageurs VALUES
(1, 'Kane', 'Abdou', '1990-06-15', 'Dakar'),
(2, 'Diallo', 'Fatou', '1985-02-20', 'Thiès'),
(3, 'Sow', 'Moussa', '1993-08-10', 'Saint-Louis');
```

### 2.2. Insertion dans Voyages
```sql
INSERT INTO Voyages VALUES
(1, 'Brésil', '2024-07-05', '2024-07-20'),
(2, 'France', '2024-08-01', '2024-08-15'),
(3, 'Maroc', '2024-09-10', '2024-09-20');
```

### 2.3. Insertion dans Reservations
```sql
INSERT INTO Reservations VALUES
(1, 1, 1),
(2, 2, 2),
(3, 1, 3),
(4, 3, 1);
```

### 2.4. Insertion dans Hotels
```sql
INSERT INTO Hotels VALUES
(1, 'Radisson', 'Dakar'),
(2, 'Royal Horizon', 'Mbour'),
(3, 'Savana', 'Cap Skirring');
```

### 2.5. Insertion dans Chambres
```sql
INSERT INTO Chambres VALUES
(1, 1, 'Suite', 150.00),
(2, 1, 'Simple', 90.00),
(3, 2, 'Double', 80.00),
(4, 3, 'Simple', 70.00);
```
<!-- 
---

# ✍️ Phase 3 : Exercices d'application

## Partie 1 — Répondre en **Algèbre Relationnelle**

À partir du schéma :

---
**Exercice 1**  
*Quels sont les noms et prénoms des voyageurs ayant réservé un voyage ?*

Algèbre relationnelle :  
\[
\Pi_{nom, prenom} (Voyageurs \bowtie_{id\_voyageur} Reservations)
\]

---
**Exercice 2**  
*Quelles sont les destinations des voyages réservés par le voyageur numéro 1 ?*

Algèbre relationnelle :  
\[
\Pi_{destination} (Reservations \bowtie_{id\_voyage = id\_voyage} Voyages) \sigma_{id\_voyageur = 1}
\]

---
**Exercice 3**  
*Quels sont les hôtels proposant des chambres à moins de 100$ par nuit ?*

Algèbre relationnelle :  
\[
\Pi_{nom\_hotel} (Hotels \bowtie_{id\_hotel} Chambres) \sigma_{prix\_nuit < 100}
\]

---
**Exercice 4**  
*Quels voyageurs ont réservé un voyage vers le Brésil ?*

Algèbre relationnelle :  
\[
\Pi_{nom, prenom} ((Reservations \bowtie Voyages) \bowtie Voyageurs) \sigma_{destination = "Brésil"}
\]

---
**Exercice 5**  
*Quelle est la date de départ du voyage réservé par le voyageur Abdou Kane ?*

Algèbre relationnelle :  
\[
\Pi_{date\_depart} ((Voyageurs \bowtie Reservations) \bowtie Voyages) \sigma_{nom = "Kane" \land prenom = "Abdou"}
\]

---
**Exercice 6**  
*Quels sont les types de chambres disponibles dans l'hôtel Radisson ?*

Algèbre relationnelle :  
\[
\Pi_{type\_chambre} (Hotels \bowtie Chambres) \sigma_{nom\_hotel = "Radisson"}
\]

---
**Exercice 7**  
*Quels sont les prix des chambres dans les hôtels situés à Mbour ?*

Algèbre relationnelle :  
\[
\Pi_{prix\_nuit} (Hotels \bowtie Chambres) \sigma_{adresse\_hotel = "Mbour"}
\]

---
**Exercice 8**  
*Quels voyageurs ont réservé un voyage pour la période du 1er juillet au 15 août ?*

Algèbre relationnelle :  
\[
\Pi_{nom, prenom} ((Voyageurs \bowtie Reservations \bowtie Voyages) \sigma_{date\_depart \geq '2024-07-01' \land date\_retour \leq '2024-08-15'})
\]

---

# 🧠 Partie 2 — Refaire les requêtes en SQL

Quand tu voudras, on passera **à la traduction de toutes ces requêtes** en **pur SQL**, pour lier la théorie (algèbre relationnelle) et la pratique (requêtes SQL réelles) ! -->
