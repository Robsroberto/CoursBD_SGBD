<div class="bandeau"><img src="../images/bandeau-sql.png" alt="SQL" /></div>

# Chapitre 2 : Modéliser les données, du besoin au modèle relationnel

<p class="auteur">Par <strong>Robert DIASSÉ</strong>, Ingénieur Logiciel et Data</p>

> **Cours** : Base de données 1, fondements, modélisation et SQL · **Fil rouge** : la clinique Santé Plus · **Version** : 2026-10-31

## Fiche du chapitre

| | |
|---|---|
| **Objectifs (OS2)** | A la fin du chapitre, l'apprenant sait : 1) expliquer pourquoi on conçoit une base avant de la créer (les anomalies d'une table mal conçue) ; 2) passer des règles de gestion au dictionnaire de données ; 3) construire un modèle conceptuel de données (MCD) Merise : entités, propriétés, identifiants, associations, cardinalités ; 4) identifier les dépendances fonctionnelles et vérifier les formes normales 1FN, 2FN, 3FN ; 5) transformer un MCD en modèle logique (MLD) relationnel, avec clés primaires et étrangères ; 6) lire et dessiner le même modèle en notation ERD ; 7) appliquer des conventions de nommage. |
| **Prérequis** | Chapitre 1 ; atelier 1 terminé |
| **Durée** | 🟢 Débutant : 12 h · 🔵 Standard : 9 h · 🟣 Expert : 6 h (atelier compris) |
| **Matériel** | Papier et crayon d'abord ; puis un outil de dessin : Looping (gratuit, Windows), draw.io (https://app.diagrams.net) ou Oracle SQL Developer Data Modeler (gratuit) |
| **Livrable** | L'atelier 2 : le dictionnaire de données, le MCD et le MLD de la clinique |

### Comment lire ce chapitre

- **Noyau** : obligatoire pour tous les niveaux.
- 🟢 **Débutant** : explications pas à pas. A sauter si le public est à l'aise.
- 🔵 **Standard** : le niveau de référence.
- 🟣 **Expert** : approfondissements.

Ce chapitre ne contient presque pas de SQL : on **réfléchit avant de créer**. C'est l'étape la plus importante : une base mal conçue reste mauvaise, quel que soit le SQL écrit ensuite. La méthode utilisée est **Merise**, la méthode française de conception ; la section 6 montre le même modèle dans la notation **ERD**, utilisée par Oracle et dans les documents en anglais.

---

## 1. Pourquoi concevoir ?

### 1.1 La tentation de la table unique

Le plus simple, semble-t-il, serait de tout mettre dans **une seule** table, comme dans un cahier :

| n° | date | patient | tél. patient | médecin | spécialité | service | tarif |
|---|---|---|---|---|---|---|---|
| 1 | 2026-10-05 | Awa Diop | 77 111 22 33 | Mamadou Ba | Médecine générale | Consultations | 10000 |
| 2 | 2026-10-05 | Moussa Ndiaye | 70 444 55 66 | Aminata Faye | Pédiatrie | Pédiatrie | 15000 |
| 3 | 2026-10-12 | Awa Diop | 77 111 22 33 | Aminata Faye | Pédiatrie | Pédiatrie | 15000 |
| 4 | 2026-10-14 | Fatou Sarr | 76 777 88 99 | Mamadou Ba | Médecine générale | Consultations | 10000 |

Elle fonctionne... jusqu'au premier changement. Elle souffre de trois **anomalies** :

| Anomalie | Ce qui se passe |
|---|---|
| **De mise à jour** | Awa Diop change de numéro : il faut le modifier sur **chaque** ligne où elle apparaît. Si l'on en oublie une, la base se contredit |
| **D'insertion** | Un nouveau médecin, le Dr Sow, arrive à la clinique. Impossible de l'enregistrer tant qu'il n'a fait **aucune** consultation (la ligne aurait un patient vide) |
| **De suppression** | On supprime la consultation n°2, la seule de Moussa Ndiaye : on **perd** aussi son téléphone, et le fait qu'il est patient de la clinique |

Ces anomalies viennent toutes du même défaut : **la table mélange plusieurs sujets** (des patients, des médecins, des consultations). Concevoir, c'est trouver les bons sujets, et ranger chaque information **une seule fois**, dans le bon.

### 1.2 Les trois étapes de la conception

```text
 Le besoin          MCD                 MLD                 Script SQL
 (règles de  ──►  modèle         ──►  modèle         ──►  (chapitre 3)
  gestion)        conceptuel          logique
                  « quoi ? »          « en tables »       « dans le SGBD »

                  indépendant de      relationnel, mais   propre à MySQL,
                  toute technique     sans SGBD précis    PostgreSQL ou Oracle
```

On retrouve les niveaux du chapitre 1 : le MCD et le MLD décrivent le **niveau conceptuel** ; le script SQL le crée dans le SGBD.

## 2. Des règles de gestion au dictionnaire de données

### 2.1 Les règles de gestion

Tout commence par une **interview** des futurs utilisateurs. La direction de la clinique Santé Plus explique :

1. Un **patient** est connu par son nom, son prénom, sa date de naissance, son sexe, son téléphone et sa ville. La clinique lui attribue un numéro.
2. Un **médecin** a un numéro, un nom, un prénom, une spécialité et un téléphone.
3. Chaque médecin est rattaché à **un seul service** (Pédiatrie, Cardiologie, Consultations générales...). Un service a un code, un nom et un étage ; il compte un ou plusieurs médecins.
4. Lors d'une **consultation**, **un** patient est reçu par **un** médecin, à une date, pour un motif ; la consultation a un tarif.
5. Un patient peut avoir consulté plusieurs fois, ou jamais (il vient d'être enregistré). Un médecin peut n'avoir encore fait aucune consultation.
6. Au cours d'une consultation, le médecin peut **prescrire** des médicaments ; pour chacun, il indique la posologie (par exemple « 1 comprimé matin et soir ») et la durée en jours. Un médicament a un code, un nom et une forme (comprimé, sirop...).

### 2.2 Le dictionnaire de données

On relève **toutes** les informations citées, une par ligne, sans doublon :

| Code | Signification | Type | Taille | Remarque |
|---|---|---|---|---|
| `num_patient` | Numéro du patient | Numérique | | Attribué par la clinique |
| `nom_patient` | Nom du patient | Texte | 50 | |
| `prenom_patient` | Prénom du patient | Texte | 50 | |
| `date_naissance` | Date de naissance | Date | | |
| `sexe` | Sexe | Texte | 1 | `F` ou `M` |
| `tel_patient` | Téléphone du patient | Texte | 20 | |
| `ville` | Ville du patient | Texte | 40 | |
| `num_medecin` | Numéro du médecin | Numérique | | |
| `nom_medecin`, `prenom_medecin` | Nom et prénom du médecin | Texte | 50 | |
| `specialite` | Spécialité | Texte | 40 | |
| `tel_medecin` | Téléphone du médecin | Texte | 20 | |
| `code_service` | Code du service | Texte | 5 | `PED`, `CAR`... |
| `nom_service` | Nom du service | Texte | 40 | |
| `etage` | Étage du service | Numérique | | |
| `num_consultation` | Numéro de la consultation | Numérique | | |
| `date_consultation` | Date de la consultation | Date | | |
| `motif` | Motif | Texte | 100 | |
| `tarif` | Tarif en FCFA | Numérique | | Entier, sans décimales |
| `code_medicament` | Code du médicament | Texte | 10 | |
| `nom_medicament` | Nom du médicament | Texte | 60 | |
| `forme` | Forme | Texte | 20 | |
| `posologie` | Posologie | Texte | 100 | Dépend de la consultation **et** du médicament |
| `duree_jours` | Durée du traitement | Numérique | | Idem |

> 🟢 **Débutant : pas de données calculées**
> On n'enregistre pas l'**âge** du patient : il se calcule à partir de la date de naissance, et il changerait chaque année. De même, on ne stocke pas le « nombre de consultations d'un médecin » : on le **compte** quand on en a besoin (chapitre 4). Une donnée calculable stockée finit toujours par être fausse.

## 3. Le modèle conceptuel de données (MCD)

### 3.1 Entité, propriété, identifiant

| Mot | Définition | Exemple |
|---|---|---|
| **Entité** | Un objet du monde réel, concret ou abstrait, que la clinique veut décrire. On l'écrit en **majuscules**, au singulier | `PATIENT`, `MEDECIN`, `SERVICE` |
| **Propriété** (ou attribut) | Une information élémentaire sur l'entité | `nom_patient`, `date_naissance` |
| **Identifiant** | La propriété (ou les propriétés) dont la valeur est **unique** pour chaque occurrence. On la **souligne**, et on la place en premier | <u>`num_patient`</u> |
| **Occurrence** | Un exemplaire précis de l'entité | La patiente Awa Diop, n°1 |

```text
 ┌────────────────────┐   ┌────────────────────┐   ┌────────────────────┐
 │      PATIENT       │   │      MEDECIN       │   │      SERVICE       │
 ├────────────────────┤   ├────────────────────┤   ├────────────────────┤
 │ num_patient   (id) │   │ num_medecin   (id) │   │ code_service  (id) │
 │ nom_patient        │   │ nom_medecin        │   │ nom_service        │
 │ prenom_patient     │   │ prenom_medecin     │   │ etage              │
 │ date_naissance     │   │ specialite         │   └────────────────────┘
 │ sexe               │   │ tel_medecin        │
 │ tel_patient        │   └────────────────────┘
 │ ville              │
 └────────────────────┘
```

Dans les schémas de ce cours (écrits en texte), l'identifiant est marqué `(id)` ; dans vos dessins, **soulignez-le**.

> 🟢 **Débutant : pourquoi un numéro ?**
> Le nom ne suffit pas à identifier un patient : deux Awa Diop peuvent venir à la clinique. Le téléphone non plus (il change, et une mère peut donner le sien pour ses trois enfants). On crée donc un **numéro**, qui ne change jamais et ne se répète jamais.

### 3.2 Association et cardinalités

Une **association** relie des entités ; on la nomme par un **verbe** (à l'infinitif) et on la dessine dans un ovale. Ses **cardinalités** disent, pour **une** occurrence de l'entité, combien de fois **au minimum** et **au maximum** elle participe à l'association.

```text
 ┌──────────┐                                     ┌──────────┐
 │ MEDECIN  │ 1,1 ────── ( APPARTENIR ) ────── 1,n │ SERVICE  │
 └──────────┘                                     └──────────┘
```

On lit **depuis l'entité, vers l'autre** :

- côté `MEDECIN`, `1,1` : **un** médecin appartient à **au moins 1** et **au plus 1** service (règle 3) ;
- côté `SERVICE`, `1,n` : **un** service compte **au moins 1** et **au plus plusieurs** médecins (règle 3).

| Cardinalité | Se lit | Exemple |
|---|---|---|
| `0,1` | zéro ou un | Un patient a, au plus, un médecin traitant (et peut n'en avoir aucun) |
| `1,1` | exactement un | Un médecin appartient à un seul service |
| `0,n` | zéro, un ou plusieurs | Un patient a fait aucune, une ou plusieurs consultations |
| `1,n` | un ou plusieurs | Un service compte au moins un médecin |

Le **minimum** répond à la question « peut-il ne pas participer ? » (0 = oui, 1 = non). Le **maximum** répond à « peut-il participer plusieurs fois ? » (1 = non, n = oui).

### 3.3 Le MCD de la clinique

Une consultation a ses propres informations (date, motif, tarif) et elle est reliée à **un** patient et **un** médecin : on en fait une **entité**. La prescription, elle, n'existe que pour **un couple** (une consultation, un médicament) : c'est une **association porteuse de propriétés**.

```text
   ┌──────────────────┐                      ┌──────────────────┐
   │     PATIENT      │                      │     MEDECIN      │
   ├──────────────────┤                      ├──────────────────┤
   │ num_patient (id) │                      │ num_medecin (id) │
   │ nom_patient      │                      │ nom_medecin      │
   │ ...              │                      │ ...              │
   └────────┬─────────┘                      └──┬────────────┬──┘
            │ 0,n                           0,n │            │ 1,1
       ( PASSER )                       ( EFFECTUER )  ( APPARTENIR )
            │ 1,1                           1,1 │            │ 1,n
            │     ┌──────────────────────┐      │   ┌────────┴──────────┐
            └─────┤     CONSULTATION     ├──────┘   │      SERVICE      │
                  ├──────────────────────┤          ├───────────────────┤
                  │ num_consultation(id) │          │ code_service (id) │
                  │ date_consultation    │          │ nom_service       │
                  │ motif                │          │ etage             │
                  │ tarif                │          └───────────────────┘
                  └──────────┬───────────┘
                             │ 0,n
            ( PRESCRIRE : posologie, duree_jours )
                             │ 0,n
                  ┌──────────┴───────────┐
                  │      MEDICAMENT      │
                  ├──────────────────────┤
                  │ code_medicament (id) │
                  │ nom_medicament       │
                  │ forme                │
                  └──────────────────────┘
```

| Association | Cardinalités | Justification (règle de gestion) |
|---|---|---|
| PASSER | PATIENT `0,n` / CONSULTATION `1,1` | Un patient a fait 0 à plusieurs consultations (règle 5) ; une consultation concerne exactement un patient (règle 4) |
| EFFECTUER | MEDECIN `0,n` / CONSULTATION `1,1` | Un médecin peut n'en avoir fait aucune (règle 5) ; une consultation est faite par exactement un médecin (règle 4) |
| APPARTENIR | MEDECIN `1,1` / SERVICE `1,n` | Règle 3 |
| PRESCRIRE | CONSULTATION `0,n` / MEDICAMENT `0,n` | Une consultation peut ne donner aucune prescription, ou plusieurs ; un médicament peut n'avoir jamais été prescrit, ou souvent (règle 6) |

`posologie` et `duree_jours` ne dépendent ni de la consultation seule, ni du médicament seul, mais **des deux ensemble** : ce sont les propriétés de l'association `PRESCRIRE`.

> ✏️ **Essayez** : placez `posologie` dans l'entité `MEDICAMENT`. Que se passe-t-il si le même médicament est prescrit « 1 comprimé par jour » à un enfant et « 2 comprimés par jour » à un adulte ? Puis placez-la dans `CONSULTATION` : que se passe-t-il si la consultation donne trois médicaments ? Dans les deux cas, une seule case ne suffit pas : la propriété doit aller dans l'association.

> 🔵 **Standard : association réflexive**
> Une association peut relier une entité **à elle-même**. Exemple : un médecin peut être le **référent** (le tuteur) d'autres médecins, plus jeunes. On dessine `MEDECIN` relié deux fois à l'association `ENCADRER`, avec un **rôle** sur chaque patte : « encadre » (`0,n`) et « est encadré par » (`0,1`).

> 🟣 **Expert : association ternaire**
> Une association peut relier **trois** entités, quand une information dépend des trois à la fois. Exemple : une `GARDE` relie `MEDECIN`, `SERVICE` et `JOUR` (le Dr Ba est de garde en Pédiatrie le samedi). Avant d'en dessiner une, vérifiez qu'on ne peut pas la remplacer par une entité et des associations binaires : c'est souvent plus simple.

## 4. Dépendances fonctionnelles et formes normales

### 4.1 La dépendance fonctionnelle

On dit que **B dépend fonctionnellement de A**, et on écrit **A → B**, si **une valeur de A détermine une seule valeur de B**.

| Dépendance | Se lit | Vraie ? |
|---|---|---|
| `num_patient → nom_patient` | un numéro de patient donne un seul nom | Oui |
| `nom_patient → num_patient` | un nom donne un seul numéro | **Non** : deux patients peuvent avoir le même nom |
| `num_medecin → code_service` | un médecin est dans un seul service (règle 3) | Oui |
| `code_service → num_medecin` | un service a un seul médecin | **Non** (règle 3 : un ou plusieurs) |
| `(num_consultation, code_medicament) → posologie` | la posologie dépend du couple | Oui |

Les dépendances fonctionnelles traduisent les **règles de gestion**. Elles servent à vérifier que chaque information est rangée au bon endroit : c'est la **normalisation**.

### 4.2 Les trois premières formes normales

Reprenons la table unique de la section 1, avec une colonne de plus, les médicaments prescrits :

`registre(num_consultation, date, num_patient, nom_patient, tel_patient, num_medecin, nom_medecin, code_service, nom_service, tarif, medicaments)`

où `medicaments` contient par exemple `"Paracétamol 1cp x3 5j, Amoxicilline 1cp x2 7j"`.

**Première forme normale (1FN)** : chaque case contient **une seule valeur**, atomique, et la table a un identifiant.

- `medicaments` contient une **liste** : la table n'est pas en 1FN. On sort les médicaments dans une table à part, une ligne par médicament prescrit : `prescription(num_consultation, code_medicament, posologie, duree_jours)`, identifiée par le couple.

**Deuxième forme normale (2FN)** : 1FN, **et** chaque propriété non identifiante dépend de **tout** l'identifiant (pas seulement d'une partie).

- Dans `prescription`, si l'on avait ajouté `nom_medicament`, il dépendrait de `code_medicament` **seul** : pas en 2FN. On le sort dans `medicament(code_medicament, nom_medicament, forme)`.
- (Une table dont l'identifiant tient en **une** colonne est automatiquement en 2FN dès qu'elle est en 1FN.)

**Troisième forme normale (3FN)** : 2FN, **et** aucune propriété non identifiante ne dépend d'une **autre** propriété non identifiante (pas de dépendance **transitive**).

- Dans `registre`, `num_patient → nom_patient` et `num_patient → tel_patient` : le nom et le téléphone dépendent du patient, pas de la consultation. On sort `patient(num_patient, nom_patient, tel_patient)`.
- De même `num_medecin → nom_medecin, code_service` et `code_service → nom_service` : on sort `medecin(...)` et `service(...)`.

Le résultat, en 3FN :

| Table | Contenu |
|---|---|
| `consultation` | num_consultation, date, tarif, num_patient, num_medecin |
| `patient` | num_patient, nom_patient, tel_patient |
| `medecin` | num_medecin, nom_medecin, code_service |
| `service` | code_service, nom_service |
| `prescription` | num_consultation, code_medicament, posologie, duree_jours |
| `medicament` | code_medicament, nom_medicament, forme |

On retrouve **exactement** le MCD de la section 3 : un MCD bien construit (une information à un seul endroit, les propriétés d'association dans l'association) donne des tables **déjà normalisées**. La normalisation sert alors à **vérifier**.

> 🟢 **Débutant : la phrase à retenir**
> En 3FN, chaque propriété dépend « **de la clé, de toute la clé, et de rien d'autre que la clé** ». La 1FN, c'est « une valeur par case » ; la 2FN, « toute la clé » ; la 3FN, « rien que la clé ».

> 🔵 **Standard : et les anomalies ?**
> Vérifiez sur les tables en 3FN : changer le téléphone d'Awa se fait sur **une** ligne de `patient` (plus d'anomalie de mise à jour) ; le Dr Sow s'enregistre dans `medecin` sans consultation (plus d'anomalie d'insertion) ; supprimer une consultation ne supprime pas le patient (plus d'anomalie de suppression).

## 5. Du MCD au modèle logique (MLD)

### 5.1 Les règles de passage

| Règle | Dans le MCD | Dans le MLD |
|---|---|---|
| **1. Entité** | Chaque entité | devient une **table**. Son identifiant devient la **clé primaire**, ses propriétés deviennent des colonnes |
| **2. Association à patte `x,1`** (une cardinalité maximale 1 d'un côté, n de l'autre) | `MEDECIN 1,1 ── APPARTENIR ── 1,n SERVICE` | **pas de table** : la clé primaire du côté `n` (`code_service`) est **recopiée** dans la table du côté `1` (`medecin`), où elle devient une **clé étrangère** |
| **3. Association `x,n` des deux côtés** | `CONSULTATION 0,n ── PRESCRIRE ── 0,n MEDICAMENT` | **une nouvelle table**, dont la clé primaire est **composée** des clés primaires des entités reliées (chacune est aussi clé étrangère) ; les propriétés de l'association deviennent ses colonnes |
| **4. Association `x,1` des deux côtés** | `PERSONNE 0,1 ── POSSEDER ── 1,1 PASSEPORT` | une clé étrangère dans **l'une** des deux tables (en général, celle du côté `1,1`) ; ou une fusion des deux tables si elles décrivent le même objet |

> 🟢 **Débutant : la règle 2 en une phrase**
> « La clé **descend** vers le côté où il y a **1** au maximum. » Un médecin a **un** service : on note **le** code de **son** service sur la ligne du médecin. On ne pourrait pas faire l'inverse : un service a **plusieurs** médecins, et une case ne contient qu'une valeur (1FN).

### 5.2 Le MLD de la clinique

On écrit le MLD **en texte** : le nom de la table, puis ses colonnes entre parenthèses ; la **clé primaire est soulignée**, les **clés étrangères sont précédées de #**.

- **service** (<u>code_service</u>, nom_service, etage)
- **medecin** (<u>num_medecin</u>, nom_medecin, prenom_medecin, specialite, tel_medecin, #code_service)
- **patient** (<u>num_patient</u>, nom_patient, prenom_patient, date_naissance, sexe, tel_patient, ville)
- **consultation** (<u>num_consultation</u>, date_consultation, motif, tarif, #num_patient, #num_medecin)
- **medicament** (<u>code_medicament</u>, nom_medicament, forme)
- **prescription** (<u>#num_consultation, #code_medicament</u>, posologie, duree_jours)

| Morceau | D'où il vient |
|---|---|
| Six tables | Cinq entités (règle 1) + l'association `PRESCRIRE` (règle 3) |
| `#code_service` dans `medecin` | `APPARTENIR` : `MEDECIN 1,1` / `SERVICE 1,n` (règle 2) |
| `#num_patient` et `#num_medecin` dans `consultation` | `PASSER` et `EFFECTUER` : côté `CONSULTATION 1,1` (règle 2) |
| Clé primaire **composée** de `prescription` | Le couple (consultation, médicament) : un même médicament ne peut pas être prescrit deux fois dans la même consultation |
| Aucune table `passer`, `effectuer`, `appartenir` | Les associations à patte `x,1` disparaissent, remplacées par une clé étrangère |

### 5.3 Clé étrangère obligatoire ou facultative ?

La cardinalité **minimale** du côté de la table qui **reçoit** la clé étrangère décide si celle-ci peut être vide (`NULL`) :

| Côté qui reçoit la clé | La clé étrangère est | Exemple |
|---|---|---|
| `1,1` | **obligatoire** (`NOT NULL`) | `consultation.num_patient` : une consultation a toujours un patient |
| `0,1` | **facultative** (peut être `NULL`) | `patient.num_medecin_traitant`, si un patient peut ne pas avoir de médecin traitant |

### 5.4 Les contraintes d'intégrité

Le MLD s'accompagne des **contraintes** que le SGBD fera respecter (chapitre 3) :

| Contrainte | Ce qu'elle garantit | Exemple |
|---|---|---|
| **D'entité** | La clé primaire est unique et jamais vide | Deux patients n'ont pas le même numéro |
| **Référentielle** | Une clé étrangère désigne une ligne **qui existe** | Pas de consultation pour le patient n°999 s'il n'existe pas |
| **De domaine** | Une valeur respecte son type et ses règles | `sexe` vaut `F` ou `M` ; `tarif` est positif ; `etage` est entre 0 et 5 |

> ✏️ **Essayez** : un étudiant propose de mettre `#num_consultation` dans la table `patient` « pour savoir quelles consultations il a faites ». Montrez, avec Awa Diop (deux consultations), pourquoi c'est impossible sans violer la 1FN.

## 6. La passerelle vers la notation ERD

Dans les documents en anglais et dans les outils d'Oracle, le modèle conceptuel s'appelle un **ERD** (*Entity Relationship Diagram*, diagramme entité-relation). Les idées sont les mêmes ; seuls les mots et les dessins changent.

| Merise (France) | ERD (anglais, Oracle) |
|---|---|
| Entité | *Entity* |
| Propriété | *Attribute* |
| Identifiant | *Unique identifier* (UID) ; en Oracle, marqué `#` |
| Association | *Relationship* (souvent sans nom de verbe dans l'ovale : on écrit une phrase sur chaque patte) |
| Cardinalité minimale `0` / `1` | *Optionality* : optionnelle (*may be*) / obligatoire (*must be*) |
| Cardinalité maximale `1` / `n` | *Cardinality* : *one* / *many* |
| Association porteuse de propriétés (`PRESCRIRE`) | Une **entité d'intersection** (*intersection entity*) `PRESCRIPTION` |
| MCD | *Logical model* (dans Oracle Data Modeler) |
| MLD | *Relational model* |

**Attention au sens de lecture.** En Merise, la cardinalité est écrite **à côté de l'entité qu'elle décrit**. En ERD (comme en UML), le symbole « plusieurs » est dessiné **à l'autre bout**, du côté de l'entité qui est en plusieurs exemplaires :

```text
 Merise :   PATIENT  0,n ──── PASSER ──── 1,1  CONSULTATION
                     « un patient passe 0 à n consultations »

 ERD    :   PATIENT  ┼┼──────────────────○<  CONSULTATION
            (pattes de corbeau)
            ┼┼ près de PATIENT : chaque consultation concerne exactement UN patient
            ○< près de CONSULTATION : un patient a ZÉRO ou PLUSIEURS consultations
```

| Symbole ERD (pattes de corbeau) | Sens | Merise correspondant, **de l'autre côté** |
|---|---|---|
| `┼┼` | exactement un | `1,1` |
| `○┼` | zéro ou un | `0,1` |
| `┼<` | un ou plusieurs | `1,n` |
| `○<` | zéro ou plusieurs | `0,n` |

Dans Oracle SQL Developer Data Modeler (notation *Barker*, celle des supports Oracle Academy), le trait est **plein** quand la participation est obligatoire, **en pointillés** quand elle est optionnelle, et une patte de corbeau indique « plusieurs ». Chaque relation se lit par deux phrases : « **Chaque** patient **peut** passer **une ou plusieurs** consultations » ; « **Chaque** consultation **doit** concerner **un et un seul** patient ».

> 🔵 **Standard : de l'ERD au script SQL avec Oracle Data Modeler**
> Oracle SQL Developer Data Modeler (gratuit) transforme le modèle logique (ERD) en modèle relationnel, puis génère le script `CREATE TABLE` (*DDL*). C'est l'atelier prévu par le syllabus. Même si vous travaillez sur MySQL ou PostgreSQL, vous pouvez y dessiner votre modèle ; le script généré est écrit pour Oracle et demande quelques retouches pour les autres SGBD (chapitre 3).

## 7. Bonnes pratiques et conventions de nommage

| Règle | Exemple | A éviter |
|---|---|---|
| Noms en minuscules, mots séparés par `_` (dans le MLD et en SQL) | `date_consultation` | `DateConsultation`, `date consultation` |
| Pas d'accents ni d'espaces dans les noms | `prenom`, `etage` | `prénom`, `étage` |
| Table au **singulier** | `patient`, `consultation` | `patients` |
| Clé primaire nommée de façon reconnaissable | `num_patient` ou `id_patient` (choisir une forme et s'y tenir) | `id` partout, `numero` |
| Clé étrangère : **même nom** que la clé primaire qu'elle désigne | `consultation.num_patient` | `consultation.patient`, `consultation.client_id` |
| Pas de mot réservé du SQL comme nom | `date_consultation` | `date`, `order`, `user` |
| Une information = une colonne | `nom`, `prenom` | `nom_complet` |

**Vérifications avant de passer au SQL**

1. Chaque règle de gestion se retrouve dans le MCD (une cardinalité, une propriété, une association).
2. Chaque propriété du dictionnaire est à **un seul** endroit.
3. Pas de donnée calculable, pas de liste dans une case.
4. Chaque table du MLD a une clé primaire ; chaque clé étrangère désigne une clé primaire existante.
5. Les tables sont en 3FN.

## Exercices

- ★ **Exercice 1 : lire des cardinalités.** Pour chaque association, écrivez les deux phrases de lecture, puis dites si les cardinalités vous semblent justes (et corrigez si besoin) : a) `ETUDIANT 1,1 ── APPARTENIR ── 1,n CLASSE` ; b) `CLIENT 0,n ── PASSER ── 1,1 COMMANDE` ; c) `AUTEUR 1,n ── ECRIRE ── 1,n LIVRE` ; d) `CHAUFFEUR 0,1 ── CONDUIRE ── 0,1 BUS` (pour une seule journée) ; e) `PAYS 1,1 ── AVOIR ── 1,1 CAPITALE`. (Section 3.2.)
- ★ **Exercice 2 : dépendances fonctionnelles.** Pour une boutique de quartier à Pikine, dites si chaque dépendance est vraie ou fausse, et justifiez : a) `code_produit → prix` ; b) `prix → code_produit` ; c) `num_vente → date_vente` ; d) `(num_vente, code_produit) → quantite` ; e) `num_vente → quantite` ; f) `telephone_client → nom_client`. (Section 4.1.)
- ★★ **Exercice 3 : normaliser.** Une école de conduite tient la table `lecon(num_lecon, date, num_eleve, nom_eleve, tel_eleve, num_moniteur, nom_moniteur, immatriculation, marque_voiture, duree_minutes)`. Une voiture est toujours conduite par le même moniteur. Donnez les dépendances fonctionnelles, dites en quelle forme normale est la table, puis décomposez-la en tables 3FN (écrivez le MLD avec clés primaires soulignées et clés étrangères marquées #). (Sections 4 et 5.)
- ★★ **Exercice 4 : la bibliothèque universitaire.** Règles : un étudiant (numéro de carte, nom, prénom, filière) peut emprunter des livres ; un livre (cote, titre, année) est écrit par un ou plusieurs auteurs (numéro, nom, nationalité) ; un livre existe en un ou plusieurs exemplaires (numéro d'exemplaire, état) ; un emprunt concerne un exemplaire, un étudiant, une date d'emprunt et une date de retour (vide tant que le livre n'est pas rendu). Construisez le dictionnaire de données, le MCD, puis le MLD. (Sections 2 à 5.)
- ★★★ **Exercice 5 : les cars de transport interurbain.** Une compagnie relie Dakar aux régions. Une **ligne** (numéro, ville de départ, ville d'arrivée) dessert plusieurs **arrêts** dans un **ordre** donné (un même arrêt, comme Thiès, sert à plusieurs lignes) ; un **voyage** est une ligne à une date et une heure, assuré par un **car** (immatriculation, nombre de places) et un **chauffeur** ; un passager achète un **billet** pour un voyage, de l'arrêt où il monte à l'arrêt où il descend. Construisez le MCD et le MLD, puis dessinez la relation entre `VOYAGE` et `CAR` en notation ERD (pattes de corbeau) et en Merise, et expliquez la différence de placement des symboles. (Toutes les sections.)

## Atelier 2 : le modèle de la clinique

Vous complétez le modèle de la clinique Santé Plus avec les **hospitalisations** (chambres, séjours) et le **paiement** des consultations : dictionnaire de données, MCD, vérification des formes normales, MLD, et le dessin d'une partie en notation ERD. L'énoncé de l'atelier vous est fourni séparément.

## A retenir

- Une table qui mélange plusieurs sujets provoque des **anomalies** de mise à jour, d'insertion et de suppression : on **conçoit** avant de créer.
- Démarche : **règles de gestion → dictionnaire de données → MCD → MLD → SQL**.
- MCD : **entités** (avec un **identifiant** souligné), **propriétés**, **associations** (un verbe) et **cardinalités** `min,max` lues depuis l'entité. Une propriété qui dépend de plusieurs entités va dans l'association.
- **A → B** : une valeur de A donne une seule valeur de B. **1FN** : une valeur par case ; **2FN** : dépend de toute la clé ; **3FN** : ne dépend que de la clé.
- Passage au MLD : entité → table ; association `x,1`/`x,n` → **clé étrangère** du côté `1` ; association `x,n`/`x,n` → **table** à clé primaire **composée**.
- Clé étrangère obligatoire si le côté qui la reçoit est `1,1`, facultative s'il est `0,1`.
- ERD : *entity*, *attribute*, *relationship*, *optionality* et *cardinality* ; les pattes de corbeau sont dessinées **à l'autre bout** par rapport aux cardinalités Merise.

## Erreurs fréquentes

| Erreur | Ce que ça provoque | Solution |
|---|---|---|
| Une table « fourre-tout » (registre) | Anomalies de mise à jour, d'insertion, de suppression | Une entité par sujet ; vérifier la 3FN |
| Une liste dans une case (`"Paracétamol, Amoxicilline"`) | Pas en 1FN ; impossible de chercher ou de compter | Une ligne par valeur, dans une table à part |
| Stocker une donnée calculable (âge, total) | Elle devient fausse avec le temps | La calculer dans la requête |
| Identifiant non unique (le nom) | Deux occurrences confondues | Un numéro ou un code |
| Cardinalités lues à l'envers | Clé étrangère dans la mauvaise table | Lire depuis l'entité : « **un** médecin appartient à ... » |
| Clé étrangère du côté `n` | Plusieurs valeurs dans une case | La clé descend vers le côté `1` |
| Oublier la table d'une association `n,n` | On ne peut pas enregistrer plusieurs prescriptions | Règle 3 : une table, clé primaire composée |
| Propriété d'association mise dans une entité (`posologie` dans `MEDICAMENT`) | Une seule valeur possible là où il en faut plusieurs | La placer dans l'association |
| Pattes de corbeau placées comme les cardinalités Merise | Modèle ERD inversé | Le symbole « plusieurs » va du côté de l'entité en plusieurs exemplaires |

## Pour aller plus loin

- Looping, outil gratuit de modélisation Merise (MCD vers MLD et SQL) : https://www.looping-mcd.fr
- draw.io (dessin libre de diagrammes) : https://app.diagrams.net
- Oracle SQL Developer Data Modeler : https://www.oracle.com/database/sqldeveloper/technologies/sql-data-modeler/
- Oracle Academy, *Applied Database Systems*, section 3 (support du syllabus, fourni par l'enseignant si l'école y a accès).
- Livre de référence : R. Elmasri et S. Navathe, *Fundamentals of Database Systems*, Pearson (chapitres sur le modèle entité-association et la normalisation).
