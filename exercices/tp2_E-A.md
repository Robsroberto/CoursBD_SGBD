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

# **SÉRIE D’EXERCICES — MODÈLE ENTITÉ–ASSOCIATION (EA / MCD)**

## Par Robert DIASSÉ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<img src="sql.jpeg" alt="ISI" width="50px">



---

 **EXERCICE 1 — Inscription à une bibliothèque**

Une bibliothèque municipale gère l’inscription de ses usagers.
Chaque usager possède un numéro, un nom, un prénom et une adresse.
La bibliothèque référence également des livres avec un code, un titre et un auteur.
Un usager peut emprunter plusieurs livres, et un livre peut être emprunté à différentes dates.

### Travail demandé

1. Identifier les entités et leurs attributs.
2. Identifier les associations.
3. Dessiner le diagramme EA.

---

**EXERCICE 2 — Gestion d’un garage automobile**

Un garage entretient les véhicules de ses clients.
Un véhicule appartient à un seul client.
Le garage réalise des interventions (réparations, vidanges…) identifiées par un numéro, une date et une description.
Une intervention peut utiliser plusieurs pièces de rechange, et une pièce peut être utilisée dans plusieurs interventions.

### Travail demandé

1. Lister les entités et mettre les attributs.
2. Définir les associations et leurs cardinalités.
3. Produire le MCD.

---

**EXERCICE 3 — Gestion des réservations d’hôtel**

Un hôtel comporte plusieurs chambres, chacune identifiée par un numéro, un type et un prix.
Un client peut réserver plusieurs chambres.
Chaque réservation possède une date de début, une date de fin et un numéro de réservation.
Une chambre peut être réservée plusieurs fois dans l’année.

### Travail demandé

1. Identifier les entités et leurs attributs.
2. Identifier les associations.
3. Dessiner le MCD.

---

**EXERCICE 4 — Gestion d’un restaurant et des commandes**

Un restaurant enregistre les commandes passées par les clients.
Une commande est composée de plusieurs plats.
Chaque plat a un prix, un nom et un code.
Chaque commande possède un numéro et une date.
Un serveur prend plusieurs commandes, mais chaque commande est prise par un seul serveur.

### Travail demandé

1. Identifier les entités et attributs.
2. Identifier les associations.
3. Construire le MCD.

---

**EXERCICE 5 — Cours et enseignants**

Une école dispense plusieurs cours.
Un cours possède un code, un nom et un volume horaire.
Chaque enseignant enseigne plusieurs cours.
Un cours est enseigné par un seul enseignant.
Chaque cours est suivi par plusieurs apprenants, et chaque apprenant suit plusieurs cours.

### Travail demandé

1. Identifier les entités et les attributs.
3. Identifier les associations.
5. Représenter le MCD complet.

---

**EXERCICE 6 — Société de transport**

Une société gère des véhicules et des chauffeurs.
Un chauffeur peut conduire plusieurs véhicules.
Chaque véhicule peut être conduit par plusieurs chauffeurs.
La société enregistre aussi les trajets effectués avec un véhicule, indiquant :

* la date,
* la distance parcourue,
* le chauffeur responsable.

### Travail demandé

1. Identifier les entités.
2. Déterminer les associations.
3. Produire le MCD.

---

**EXERCICE 7 — Système de prêt bancaire**

Une banque gère des clients, des prêts et des paiements.
Un client peut avoir plusieurs prêts.
Chaque prêt possède un numéro, une somme, un taux et une durée.
Chaque prêt donne lieu à plusieurs paiements : date, montant payé.
Les paiements sont enregistrés par un employé.
Un employé peut enregistrer plusieurs paiements.

### Travail demandé

1. Lister les entités et attributs.
2. Identifier les associations.
3. Produire le modèle EA.

---

**EXERCICE 8 — Plateforme de streaming**

Une plateforme propose des films et des séries.
Chaque film possède un titre, une durée et une année.
Chaque série comporte plusieurs saisons, composées d'épisodes.
Les utilisateurs peuvent regarder des films ou des épisodes, et une date de visionnage est enregistrée.

### Travail demandé

1. Identifier toutes les entités 
2. Définir les associations.
3. Construire un MCD lisible.

---

**EXERCICE 9 — Agence immobilière**

Une agence gère des biens immobiliers à louer ou à vendre.
Chaque bien possède un code, une adresse, un type et un prix.
Un agent est responsable de plusieurs biens.
Un client peut visiter plusieurs biens et un bien peut être visité par plusieurs clients.
Chaque visite possède une date et un commentaire.

### Travail demandé

1. Identifier les entités, attributs.
2. Définir les associations.
3. Déduire les cardinalités.
4. Construire le MCD final.

---

**EXERCICE 10 — Réseau social**

On souhaite modéliser un mini réseau social où :

* chaque utilisateur a un profil,
* les utilisateurs peuvent être amis (relation symétrique),
* un utilisateur peut publier des posts,
* les posts peuvent recevoir des commentaires,
* un utilisateur peut « aimer » des posts (like).

### Travail demandé

1. Identifier les entités et Lister leurs attributs.
2. Identifier toutes les associations.
3. Dessiner un MCD cohérent.
