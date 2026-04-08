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

# **CHAPITRE 2 — INTRODUCTION AUX SYSTÈMES DE GESTION DE BASES DE DONNÉES (SGBD)**

## Par Robert DIASSÉ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<img src="sql.jpeg" alt="ISI" width="50px">

---

## **1. Base de données et SGBD : définitions essentielles**

### **1.1. Base de données**

Une **base de données** est un ensemble structuré d’informations organisées de manière à permettre leur :

* stockage durable,
* accès rapide,
* mise à jour fiable,
* exploitation cohérente.

Elle regroupe différents ensembles logiques appelés **tables** (ou fichiers logiques), chacune décrivant un type d’objets.
Une table est constituée de **colonnes** (attributs) et de **lignes** (occurrences).

### **1.2. Système de Gestion de Base de Données**

Un **SGBD** est un logiciel destiné à :

* créer une base,
* organiser les données,
* assurer leur cohérence,
* contrôler l’accès,
* permettre les recherches,
* garantir la sécurité et la conservation des informations.

Il sert d’intermédiaire entre les utilisateurs/applications et les données.

Exemples : MySQL, PostgreSQL, SQL Server, Oracle, SQLite.

---

## **2. Données, informations et organisation**

### **2.1. Donnée**

Une **donnée** est un élément brut : un nom, une date, un identifiant, un nombre.

### **2.2. Information**

Une **information** est une donnée interprétée dans un contexte :
une date utilisée pour calculer un âge, un identifiant utilisé pour retrouver un dossier.

L’objectif d’un SGBD est d’organiser les données pour produire de l’information fiable.

---

## **3. Structure interne d’un SGBD**

Un SGBD repose classiquement sur une architecture à trois niveaux, permettant l’indépendance des données :

<img src="sgbd_couche.png" width="300px">
<img src="Image1.png" width="300px">

### **3.1. Niveau Externe**

Correspond à l’ensemble des **vues** particulières que différents utilisateurs peuvent avoir de la base.
Chaque utilisateur accède uniquement aux données pertinentes pour ses besoins.

### **3.2. Niveau Conceptuel**

Décrit la **structure logique globale** des données : types d’objets manipulés, associations entre eux, contraintes d’intégrité, règles générales d’organisation.

C’est dans ce niveau que se situent les travaux de **modélisation conceptuelle**.

### **3.3. Niveau Interne**

Correspond à la représentation **physique** des données :
organisation des fichiers, index, modes de stockage, gestion des blocs, optimisation.

Ce niveau est invisible pour les utilisateurs et transparent lors de la conception.

---

## **4. Fonctions fondamentales d’un SGBD**

Un SGBD remplit plusieurs fonctions essentielles :

### **4.1. Gestion du stockage**

Organisation structurée des données, indépendance entre les programmes et les fichiers physiques.

### **4.2. Gestion de l’accès**

Mise à disposition de mécanismes standardisés pour consulter, insérer, modifier ou supprimer des informations.

### **4.3. Gestion de l’intégrité**

Application automatique de règles garantissant la cohérence des données :
unicité, validité, dépendances, contraintes métier.

### **4.4. Gestion de la concurrence**

Contrôle des accès simultanés afin d’éviter les conflits et assurer la fiabilité lors des opérations effectuées en parallèle.

### **4.5. Gestion de la sécurité**

Définition de privilèges, autorisations et mécanismes de protection contre les accès non autorisés.

### **4.6. Sauvegarde et restauration**

Préservation de l’information et possibilité de récupérer l’état antérieur en cas d’incident ou de perte.

---

## **5. Introduction à la modélisation des données**

Avant toute création de base, il est nécessaire de comprendre et d’organiser les objets manipulés ainsi que leurs relations.
La modélisation conceptuelle constitue la première étape de cette démarche.

### **5.1. Entité**

Une **entité** est un objet ou un concept distinct dans le domaine étudié.
Elle représente une catégorie d’éléments partageant les mêmes caractéristiques.

Exemples :
Personne, Chambre, Produit, Employé, Projet.
- l’**employé** Martin <br>
- le **projet** TERA

### **5.2. Propriété/Attribut**

Un **attribut** est une propriété décrivant une entité.

Exemple pour l’entité Employé :
nom, prénom, fonction, date_embauche.

### **5.3. Occurrence**

Une **occurrence** est une instance concrète d’une entité.
Dans une table, chaque ligne correspond à une occurrence.

Exemple :
Deux produits différents constituent deux occurrences de l’entité Produit.


### **5.4. Identifiant**

Un **identifiant** (clé) est un attribut permettant de distinguer de manière unique chaque occurrence d’une entité.

Exemples :
matricule d’un employé, numéro de facture, référence produit.


<img src="Image3.png" width="100px">

### **5.5. Association**

Une **association** relie deux ou plusieurs entités lorsque des liens existent entre leurs occurrences.

Exemples :

* un employé travaille dans un département,
* un client passe une commande,
* une chambre appartient à un hôtel.

<img src="Image2.png">

### **5.6. Cardinalités**

Les cardinalités précisent le **nombre minimal et maximal** d’occurrences d’une entité pouvant participer à une association.

Notation générale :
(min, max)

Exemples :
(1,1) : une seule occurrence obligatoire
(0,1) : facultative, au plus une
(1,n) : au moins une, plusieurs possibles
(0,n) : aucune ou plusieurs occurrences

---

## **6. Exemple illustratif**

Considérons un système simple :

Entités :

* Hôtel(id, nom, adresse)
* Chambre(id_chambre, type, prix)
* Client(id_client, nom, téléphone)

Associations :

* un hôtel possède plusieurs chambres ;
* un client réserve une chambre.

Cardinalités possibles :

* un hôtel possède (1,n) chambres ;
* une chambre appartient à (1,1) hôtel ;
* un client peut effectuer (0,n) réservations ;
* une chambre peut être réservée (0,n) fois dans le temps.
