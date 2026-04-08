---
marp: false
size: 4:3
style: |
  h2, h3, p {
    font-size: 20px;
  }
  li {'
    font-size:20px
  }
headingDivider: 1
header: 
paginate: 
footer: Licence 2 Informatique &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ISI (Institut Supérieur D'Informatique) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RD
---
<img src="../isi.png" alt="ISI" width="100px">


# Série d’exercices – Dépendances fonctionnelles et normalisation

## Par Robert DIASSÉ 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<img src="sql.jpeg" alt="ISI" width="50px">

---

# Différence entre graphe de dépendances fonctionnelles et graphe de couverture minimale

Lorsqu’on étudie les dépendances fonctionnelles d’un ensemble d’attributs, on peut les représenter sous forme de graphes.

## Graphe de dépendances fonctionnelles

Le **graphe de dépendances fonctionnelles** représente **toutes les dépendances fonctionnelles connues ou déduites** à partir des règles de gestion.

* Chaque attribut est représenté par un nœud.
* Chaque dépendance fonctionnelle est représentée par une flèche.
* Le graphe peut contenir :

  * des dépendances directes,
  * des dépendances indirectes (transitives),
  * des dépendances redondantes.

Ce graphe sert principalement à **analyser** et **comprendre** les relations entre les attributs.

---

## Graphe de couverture minimale

Le **graphe de couverture minimale** est une **version simplifiée** du graphe de dépendances fonctionnelles.

Il ne conserve que :

* les dépendances essentielles,
* non redondantes,
* non déductibles par transitivité.

Son objectif est de :

* simplifier l’analyse,
* préparer la normalisation,
* faciliter la construction d’un MCD correct.

> Le graphe de couverture minimale est donc **un sous-graphe** du graphe de dépendances fonctionnelles.

---


## Consignes générales (communes à tous les exercices)

Pour chaque exercice, on demande de :

1. Identifier les attributs et l’identifiant.
2. Déterminer les dépendances fonctionnelles élémentaires.
3. Construire le graphe des dépendances fonctionnelles.
4. En déduire le graphe de couverture minimale.
5. Proposer une structuration correcte des entités (MCD normalisé).

---

## Exercice 1 – Gestion des clients

On considère les informations suivantes concernant les **clients d’une entreprise** :

* chaque client possède un numéro unique ;
* un client est caractérisé par son nom, son prénom et son adresse ;
* deux clients ne peuvent pas avoir le même numéro.

### Travail à faire :

Appliquer les consignes générales.

---

## Exercice 2 – Gestion des commandes

On considère les informations suivantes concernant les **commandes de clients** :

Commande
(num_commande, date_commande, nom_client, adresse_client)

Règles de gestion :

* une commande est identifiée par un numéro unique ;
* un client peut passer plusieurs commandes ;
* un client possède une seule adresse.

### Travail à faire :

Appliquer les consignes générales.

---

## Exercice 3 – Gestion des produits commandés

On considère les informations suivantes concernant les **produits commandés** :

CommandeProduit
(num_commande, num_produit, designation_produit, prix_unitaire, quantite)

Règles de gestion :

* un produit est identifié par un numéro unique ;
* un produit a une désignation et un prix ;
* une commande peut contenir plusieurs produits.

### Travail à faire :

Appliquer les consignes générales.

---

## Exercice 4 – Gestion des étudiants et des cours

On considère les informations suivantes :

Inscription
(id_etudiant, nom_etudiant, date_naissance, id_cours, nom_cours, coefficient, note)

Règles de gestion :

* un étudiant est identifié par un identifiant unique ;
* un cours est identifié par un identifiant unique ;
* un étudiant peut être inscrit à plusieurs cours ;
* une note est attribuée à un étudiant pour un cours donné.

### Travail à faire :

Appliquer les consignes générales.

---

## Exercice 5 – Gestion des employés

On considère les informations suivantes concernant les **employés d’une entreprise** :

Employe
(matricule, nom_employe, fonction, service, salaire)

Règles de gestion :

* chaque employé possède un matricule unique ;
* une fonction correspond à un seul niveau de salaire ;
* un service regroupe plusieurs employés.

### Travail à faire :

Appliquer les consignes générales.

