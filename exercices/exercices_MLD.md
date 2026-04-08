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

# SÉRIE D'EXERCICES — DÉPENDANCES FONCTIONNELLES, MCD ET MLD

<img src="sql.jpeg" alt="ISI" width="50px">


---

## Par Robert DIASSÉ

---

## **CONSIGNES GÉNÉRALES**

Pour chaque étude de cas présentée ci-dessous, vous devrez réaliser **dans l'ordre** les travaux suivants :

**Étape 1 :** Analyser le contexte et identifier toutes les **dépendances fonctionnelles** (DF) présentes dans le système.

**Étape 2 :** Construire le **graphe des dépendances fonctionnelles** et établir la **couverture minimale**.

**Étape 3 :** Concevoir le **Modèle Conceptuel de Données (MCD)** normalisé en respectant les 9 règles de normalisation MERISE.

**Étape 4 :** Transformer le MCD en **Modèle Logique de Données (MLD)** en appliquant les règles de transformation et en spécifiant toutes les **contraintes d'intégrité fonctionnelle**.

**Progression pédagogique :** Les exercices sont classés par niveau de difficulté croissante, du plus simple au plus complexe.

---

## **EXERCICE 1 — GESTION SIMPLE D'UNE BIBLIOTHÈQUE** *(Niveau Débutant)*

Une petite bibliothèque municipale souhaite informatiser la gestion de base de ses livres et emprunts.

Chaque **livre** possède un numéro ISBN unique qui l'identifie. Pour chaque livre, on conserve son titre, son année de publication et le nom de l'éditeur. Par simplification, chaque livre est écrit par un seul **auteur**. Chaque auteur est identifié par un code auteur unique et possède un nom et un prénom.

Les **adhérents** de la bibliothèque sont identifiés par un numéro de carte unique. On enregistre leur nom, prénom et ville de résidence.

Lorsqu'un adhérent emprunte un livre, on crée un **emprunt** avec la date d'emprunt et la date de retour prévue (calculée automatiquement : 15 jours après l'emprunt). Un adhérent peut emprunter plusieurs livres, et un livre peut être emprunté plusieurs fois par différents adhérents (mais pas simultanément).

**Règles de gestion :**
- Un livre est écrit par un seul auteur
- Un emprunt concerne un adhérent et un livre à une date donnée
- La date de retour prévue est calculable (attribut dérivé)

---

## **EXERCICE 2 — SYSTÈME DE COMMANDES CLIENT** *(Niveau Débutant)*

Une entreprise de vente par correspondance veut gérer ses commandes clients de manière informatisée.

Les **clients** sont identifiés par un code client unique. Pour chaque client, on stocke son nom, prénom, adresse complète et numéro de téléphone.

Chaque **commande** possède un numéro de commande unique et une date de commande. Une commande est passée par un seul client, mais un client peut passer plusieurs commandes.

Le catalogue contient des **articles** identifiés par une référence unique. Chaque article possède une désignation, un prix unitaire et une catégorie.

Une commande peut contenir plusieurs articles, et un article peut apparaître dans plusieurs commandes. Pour chaque article commandé, on doit conserver la **quantité** demandée et le **prix unitaire appliqué** (qui peut différer du prix catalogue en cas de promotion).

**Règles de gestion :**
- Une commande appartient à un seul client
- Une ligne de commande est identifiée par (numéro_commande, référence_article)
- Le prix unitaire appliqué peut différer du prix catalogue

---

## **EXERCICE 3 — CLUB SPORTIF MULTIDISCIPLINAIRE** *(Niveau Intermédiaire)*

Un club multisports souhaite gérer ses adhérents, ses activités et son encadrement.

Les **adhérents** sont identifiés par un numéro de licence unique. Pour chaque adhérent, on conserve son nom, prénom, date de naissance et adresse.

Le club propose plusieurs **disciplines sportives** (code sport, libellé du sport, tarif annuel). Chaque discipline est encadrée par des **entraîneurs** identifiés par un matricule unique. Chaque entraîneur possède un nom, prénom, téléphone et une spécialité principale. Un entraîneur peut encadrer plusieurs sports, et un sport peut avoir plusieurs entraîneurs.

Les adhérents s'inscrivent aux disciplines qui les intéressent. Pour chaque inscription, on note le **niveau** de l'adhérent dans cette discipline (débutant, intermédiaire, confirmé) et la **date d'inscription**.

Chaque entraîneur est rattaché à un **lieu d'entraînement** principal (identifiant lieu, nom du gymnase, adresse, capacité). Un lieu peut accueillir plusieurs entraîneurs.

**Règles de gestion :**
- Un adhérent peut pratiquer plusieurs sports
- Un entraîneur peut encadrer plusieurs sports
- Une inscription est caractérisée par (adhérent, sport, niveau, date)

---

## **EXERCICE 4 — GESTION DE PROJETS D'ENTREPRISE** *(Niveau Intermédiaire)*

Une société de services informatiques veut organiser la gestion de ses employés et de ses projets.

Les **employés** sont identifiés par un matricule unique. Pour chaque employé, on stocke son nom, prénom, fonction, salaire mensuel et date d'embauche. Chaque employé appartient à un **département** (code département, nom du département, budget annuel). Un employé ne peut appartenir qu'à un seul département.

L'entreprise gère plusieurs **projets** simultanément. Chaque projet est identifié par un code projet unique et possède un titre, une date de début, une date de fin prévue et un budget alloué.

Un employé peut travailler sur plusieurs projets, et un projet mobilise plusieurs employés. Pour chaque affectation d'un employé sur un projet, on doit connaître le **nombre d'heures** travaillées et son **rôle** dans le projet (développeur, analyste, testeur, etc.).

De plus, chaque projet est dirigé par un seul employé désigné comme "chef de projet". Un employé peut diriger plusieurs projets ou aucun.

**Règles de gestion :**
- Un employé appartient à un seul département
- Un projet a un seul chef de projet
- Une affectation est caractérisée par (employé, projet, nb_heures, rôle)

---

## **EXERCICE 5 — AGENCE IMMOBILIÈRE** *(Niveau Intermédiaire)*

Une agence immobilière gère un portefeuille de biens en location et les visites de clients potentiels.

Les **propriétaires** confient leurs biens à l'agence. Chaque propriétaire est identifié par un code unique et possède un nom, prénom, adresse et numéro de téléphone.

Les **biens immobiliers** sont identifiés par une référence unique. Pour chaque bien, on conserve l'adresse complète, la superficie, le nombre de pièces, le type (appartement, maison, local commercial) et le montant du loyer mensuel. Un bien appartient à un seul propriétaire.

Les **locataires potentiels** sont identifiés par un numéro de dossier unique. On enregistre leur nom, prénom, téléphone, budget maximum et le type de bien recherché.

L'agence organise des **visites** pour faire découvrir les biens aux candidats locataires. Chaque visite concerne un locataire, un bien et se déroule à une date et heure précises. L'agent immobilier note ses **observations** après chaque visite (intéressé, pas intéressé, à recontacter, etc.).

**Règles de gestion :**
- Un bien appartient à un seul propriétaire
- Une visite concerne un locataire et un bien à une date donnée
- Un locataire peut visiter plusieurs biens

---

## **EXERCICE 6 — COMPAGNIE AÉRIENNE RÉGIONALE** *(Niveau Avancé)*

Une compagnie aérienne régionale veut gérer ses vols et ses aéroports de manière informatisée.

Les **aéroports** sont identifiés par leur code IATA unique (3 lettres). Pour chaque aéroport, on conserve son nom complet, la ville et le pays où il se situe.

Chaque **vol** est identifié par un numéro de vol unique (ex: AF123). Un vol relie toujours deux aéroports : un aéroport de **départ** et un aéroport d'**arrivée**. Pour chaque vol, on mémorise l'heure de départ prévue, l'heure d'arrivée prévue et les jours de la semaine où il est opéré.

La compagnie possède plusieurs **avions** identifiés par leur immatriculation unique. Chaque avion possède un type (Boeing 737, Airbus A320, etc.), une capacité en nombre de passagers et une date de mise en service.

Chaque vol est assuré par un seul avion, mais un avion peut assurer plusieurs vols (à des moments différents). Il faut conserver l'**affectation** de chaque avion aux vols.

**Règles de gestion :**
- Un vol relie un aéroport de départ à un aéroport d'arrivée (association réflexive)
- Un vol est assuré par un seul avion
- Un avion peut assurer plusieurs vols

---

## **EXERCICE 7 — CABINET MÉDICAL PLURIDISCIPLINAIRE** *(Niveau Avancé)*

Un cabinet médical regroupant plusieurs praticiens souhaite informatiser la gestion des consultations et prescriptions.

Les **médecins** sont identifiés par leur numéro RPPS unique. Pour chaque médecin, on conserve son nom, prénom, spécialité médicale et numéro de téléphone professionnel.

Les **patients** sont identifiés par leur numéro de sécurité sociale. On enregistre leur nom, prénom, date de naissance, adresse et numéro de téléphone.

Une **consultation** a lieu lorsqu'un patient rencontre un médecin. Chaque consultation est identifiée par un numéro unique et comporte une date, une heure, le motif de consultation, le diagnostic posé et le montant facturé.

Lors d'une consultation, le médecin peut prescrire des **médicaments**. Chaque médicament est identifié par son code CIP unique et possède un nom commercial, un principe actif et un prix unitaire.

Pour chaque médicament prescrit lors d'une consultation, on doit conserver la **posologie** (ex: "2 comprimés 3 fois par jour"), la **durée du traitement** et des **instructions particulières** éventuelles.

**Règles de gestion :**
- Une consultation concerne un patient et un médecin
- Une prescription est identifiée par (consultation, médicament)
- Une consultation peut donner lieu à plusieurs prescriptions

---

## **EXERCICE 8 — GESTION DE STOCK ET APPROVISIONNEMENT** *(Niveau Avancé)*

Une entreprise de distribution veut optimiser la gestion de son stock et de ses relations fournisseurs.

Les **produits** en stock sont identifiés par une référence unique. Pour chaque produit, on conserve sa désignation, sa quantité en stock actuelle et son prix de vente public. Chaque produit appartient à une **catégorie** (code catégorie, libellé de la catégorie).

L'entreprise travaille avec plusieurs **fournisseurs** identifiés par un code fournisseur unique. Pour chaque fournisseur, on stocke sa raison sociale, son adresse complète et son numéro de téléphone.

Un produit peut être fourni by plusieurs fournisseurs, et un fournisseur propose plusieurs produits. Pour chaque couple (produit, fournisseur), il existe un **prix d'achat négocié** et un **délai de livraison** spécifiques.

L'entreprise passe des **commandes d'approvisionnement** auprès de ses fournisseurs. Chaque commande est identifiée par un numéro unique, possède une date de commande et concerne un seul fournisseur.

Une commande contient plusieurs **lignes de commande**, chacune spécifiant un produit et la **quantité commandée** auprès du fournisseur.

**Règles de gestion :**
- Un produit appartient à une seule catégorie
- Un couple (produit, fournisseur) a un prix et délai négociés
- Une commande concerne un seul fournisseur
- Une ligne de commande est identifiée par (commande, produit)

---

## **EXERCICE 9 — FESTIVAL DE CINÉMA INTERNATIONAL** *(Niveau Expert)*

Un festival de cinéma international organise des projections et gère un système de notation par jury.

Le festival présente des **films** identifiés par un code unique. Pour chaque film, on conserve le titre, la durée en minutes, l'année de production et le pays d'origine. Chaque film est réalisé par un **réalisateur** (identifiant unique, nom, prénom, nationalité) et appartient à un **genre cinématographique** (code genre, libellé comme "Drame", "Comédie", etc.).

Le festival dispose de plusieurs **salles de projection** (numéro de salle, nom de la salle, capacité en nombre de places, équipement technique).

Une **projection** est définie par un film projeté dans une salle à une date et heure précises. Chaque projection est identifiée par un numéro unique.

Les **spectateurs** du festival possèdent un badge d'accès (numéro de badge, nom, prénom, catégorie : professionnel/grand public). Ils peuvent assister à plusieurs projections. Pour chaque participation, on note la **date de réservation**.

Le festival dispose d'un **jury** composé de plusieurs **membres** (identifiant membre, nom, prénom, profession dans le cinéma). Chaque membre du jury attribue une **note** (de 1 à 10) à chaque film qu'il a visionné, accompagnée d'un **commentaire** optionnel.

**Règles de gestion :**
- Un film est réalisé par un seul réalisateur et appartient à un genre
- Une projection concerne un film, une salle et un créneau horaire
- Un spectateur peut assister à plusieurs projections
- Chaque membre du jury note individuellement chaque film

---

## **EXERCICE 10 — PARC INFORMATIQUE AVEC HISTORISATION** *(Niveau Expert)*

La Direction des Systèmes d'Information d'une grande entreprise veut gérer son parc informatique avec un suivi historique des affectations.

Le parc comprend des **postes informatiques** identifiés par leur numéro de série unique. Pour chaque poste, on conserve la marque, le modèle, la date d'achat et la configuration technique.

Ces postes sont installés dans des **bureaux** (numéro de bureau, étage, bâtiment, superficie). Un poste est installé dans un seul bureau à un moment donné, mais peut changer de bureau au cours de sa vie.

Les **utilisateurs** sont identifiés par leur matricule d'entreprise. On conserve leur nom, prénom, fonction et service de rattachement.

Les **logiciels** sont identifiés par une référence de licence unique. Pour chaque logiciel, on stocke le nom, la version, le type de licence (mono-poste, réseau, site) et la date d'expiration de la licence.

**Contraintes d'historisation :**
- Un poste peut être affecté à différents utilisateurs au cours du temps
- Un poste peut changer de bureau
- Un logiciel peut être installé et désinstallé sur différents postes

Pour chaque affectation poste-utilisateur, on doit conserver la **date de début** et la **date de fin** d'affectation.

Pour chaque installation logiciel-poste, on doit conserver la **date d'installation** et éventuellement la **date de désinstallation**.

**Règles de gestion complexes :**
- Un poste est affecté à un seul utilisateur à un moment donné
- Un utilisateur peut avoir plusieurs postes (principal + portable par exemple)
- Une licence logicielle peut être installée sur plusieurs postes selon son type
- Il faut pouvoir reconstituer l'historique complet des affectations

---
