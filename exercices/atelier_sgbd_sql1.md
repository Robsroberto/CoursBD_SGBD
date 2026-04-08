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
paginate: true

---
<img src="../isi.png" alt="ISI" width="100px">

---
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 

## Par Robert DIASSÉ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 


# Atelier SQL & Algèbre Relationnelle — Gestion de Réservations de Voyages

## Contexte

Une agence de voyages souhaite gérer ses réservations de voyageurs, les voyages proposés, ainsi que l'hébergement dans des hôtels.

Le schéma relationnel suivant est utilisé :

- **Voyageurs**(id_voyageur, nom, prenom, date_naissance, adresse)
- **Voyages**(id_voyage, destination, date_depart, date_retour)
- **Reservations**(id_reservation, #id_voyageur, #id_voyage)
- **Hotels**(id_hotel, nom_hotel, adresse_hotel)
- **Chambres**(id_chambre, #id_hotel, type_chambre, prix_nuit)

---

## Objectifs de l’atelier

1. **Créer** la base de données en ligne de commande (MySQL).
2. **Créer** les tables avec les clés primaires et étrangères.
3. **Insérer** des données fictives dans les tables.
4. **Interroger** la base :
   - **En algèbre relationnelle** 
   - **En SQL** (requêtes à rédiger et exécuter pour vérification)

---

## Partie 1 — Création de la base et des tables

> 1. Créer une base de données nommée `agence_voyages`.
> 2. Créer les tables selon le schéma donné.
> 3. Respecter les contraintes d'intégrité (clés primaires, clés étrangères).

---

## Partie 2 — Insertion des données

**Exemple de données** :

### Table `Voyageurs`
| id_voyageur | nom      | prenom   | date_naissance | adresse       |
|-------------|----------|----------|----------------|---------------|
| 1           | Kane     | Abdou    | 1990-04-15      | Dakar         |
| 2           | Ndiaye   | Fatou    | 1985-09-22      | Thiès         |

### Table `Voyages`
| id_voyage | destination | date_depart | date_retour |
|-----------|-------------|-------------|-------------|
| 1         | Brésil      | 2024-07-10  | 2024-07-25  |
| 2         | Espagne     | 2024-08-01  | 2024-08-15  |

### Table `Reservations`
| id_reservation | id_voyageur | id_voyage |
|----------------|-------------|-----------|
| 1              | 1           | 1         |
| 2              | 2           | 2         |

### Table `Hotels`
| id_hotel | nom_hotel | adresse_hotel |
|----------|-----------|---------------|
| 1        | Radisson  | Dakar         |
| 2        | Saly Club | Mbour         |

### Table `Chambres`
| id_chambre | id_hotel | type_chambre | prix_nuit |
|------------|----------|--------------|-----------|
| 1          | 1        | Suite        | 150       |
| 2          | 2        | Standard     | 80        |

---

## Partie 3 — Questions en Algèbre Relationnelle

**Répondez en algèbre relationnelle aux questions suivantes :**

1. Quels sont les noms et prénoms des voyageurs ayant réservé un voyage ?
2. Quelles sont les destinations des voyages réservés par le voyageur numéro 1 ?
3. Quels sont les hôtels proposant des chambres à moins de 100$ par nuit ?
4. Quels voyageurs ont réservé un voyage vers la destination "Brésil" ?
5. Quelle est la date de départ du voyage réservé par le voyageur Abdou Kane ?
6. Quels sont les types de chambres disponibles dans l'hôtel "Radisson" ?
7. Quels sont les prix des chambres dans les hôtels situés à "Mbour" ?
8. Quels voyageurs ont réservé un voyage pour la période du 1er juillet au 15 août ?

---

## Partie 4 — Correction en SQL (à produire en ligne de commande)

**Pour chaque question précédente, écrivez et exécutez la requête SQL correspondante.**
