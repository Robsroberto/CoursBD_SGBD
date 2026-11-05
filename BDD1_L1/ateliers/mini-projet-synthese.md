<div class="bandeau"><img src="../images/bandeau-sql.png" alt="SQL" /></div>

# Mini-projet de synthèse : de la demande à la base de données

<p class="auteur">Par <strong>Robert DIASSÉ</strong>, Ingénieur Logiciel et Data</p>

> **Cours** : Base de données 1, fondements, modélisation et SQL · **Chapitres** : 1 à 4 · **Version** : 2026-10-31

## Avant de commencer

| | |
|---|---|
| **Ce que vous allez construire** | Une base de données complète pour une petite organisation : de l'interview du « client » jusqu'aux requêtes qui répondent à ses questions |
| **Travail** | En **binôme** (les deux membres doivent pouvoir expliquer tout le projet) |
| **Durée** | 🟢 Débutant : 15 h · 🔵 Standard : 12 h · 🟣 Expert : 10 h |
| **Prérequis** | Les quatre chapitres et les quatre ateliers |
| **Rendu** | Un dossier (ou un dépôt GitHub) contenant les cinq livrables ci-dessous, puis une **soutenance** de 10 minutes |

C'est exactement ce que vous avez fait pour la clinique Santé Plus, cette fois **seuls**, sur un sujet nouveau.

## Les sujets

Choisissez un sujet dans la liste (deux binômes d'un même groupe ne prennent pas le même), ou proposez le vôtre à l'enseignant avant de commencer.

| Sujet | Le « client » | Ce qu'il veut suivre |
|---|---|---|
| **1. La pharmacie de quartier** | Une pharmacie de Grand-Yoff | Médicaments, fournisseurs, lots et dates de péremption, ventes, ordonnances |
| **2. L'auto-école** | Une auto-école de Saint-Louis | Élèves, moniteurs, véhicules, leçons, examens du code et de la conduite, paiements par tranches |
| **3. Les cars interurbains** | Une compagnie de transport Dakar-régions | Lignes, arrêts, cars, chauffeurs, voyages, billets |
| **4. Le centre de formation** | Un centre de formation en informatique | Formations, sessions, formateurs, salles, inscriptions, présences, attestations |
| **5. La boutique de pièces détachées** | Un vendeur de pièces auto à Colobane | Pièces, modèles de véhicules compatibles, stock, clients, commandes, livraisons |
| **6. Le tournoi de quartier** | Un comité de navétanes | Équipes, joueurs, matchs, buts, cartons, classement |

Votre sujet doit aboutir à **au moins 6 tables**, dont **au moins une** issue d'une association `n,n`.

## Les cinq livrables

| N° | Livrable | Chapitre |
|---|---|---|
| 1 | **Le cahier des règles** : au moins 10 règles de gestion numérotées, écrites comme si le client vous les avait dites, et le **dictionnaire de données** | 2 |
| 2 | **Le MCD** dessiné avec un outil (Looping, draw.io ou Data Modeler), cardinalités justifiées par les règles ; la vérification **3FN** de deux tables ; le **MLD** en texte (clés primaires soulignées, clés étrangères marquées #) | 2 |
| 3 | **Le script de création** `creation.sql` : rejouable (`DROP` en tête), toutes les contraintes **nommées**, au moins 3 `CHECK`, un `ON DELETE` choisi et justifié | 3 |
| 4 | **Le script de données** `donnees.sql` : au moins 8 lignes dans chaque table principale, des données réalistes (noms, villes, montants en FCFA), avec des cas particuliers (une ligne sans correspondance, un `NULL` utile) ; et une **transaction** commentée | 3 |
| 5 | **Le script de requêtes** `requetes.sql` : au moins **12 questions du client**, écrites en français, avec leurs requêtes et le nombre de lignes obtenues ; au moins une vue et un index justifié | 4 |

**Les 12 requêtes** doivent couvrir : 2 sélections avec conditions et tri, 2 fonctions (dont un `CASE`), 3 regroupements (dont un `HAVING`), 3 jointures (dont une de 3 tables et un `LEFT JOIN`), 2 sous-requêtes (dont un `NOT EXISTS`), et un opérateur ensembliste.

## Les étapes conseillées

| Semaine | Ce qu'il faut avoir fini |
|---|---|
| 1 | Sujet choisi ; règles de gestion ; dictionnaire ; premier MCD **montré à l'enseignant** |
| 2 | MCD corrigé ; MLD ; `creation.sql` qui s'exécute |
| 3 | `donnees.sql` ; les 12 requêtes ; la vue et l'index |
| 4 | Relecture croisée (chaque membre relit le travail de l'autre) ; préparation de la soutenance |

> 💡 Montrez votre MCD **avant** d'écrire le SQL : une erreur de cardinalité découverte à la semaine 3 oblige à tout refaire.

## La soutenance (10 minutes + questions)

1. Le besoin du client, en 1 minute.
2. Le MCD, et **une** décision de modélisation difficile (pourquoi telle association est porteuse, pourquoi telle cardinalité).
3. Une démonstration en direct : exécution de `creation.sql` et `donnees.sql` sur une base vide, puis de **trois** requêtes choisies par l'enseignant.
4. Une contrainte qui refuse une donnée fausse, montrée en direct.

L'enseignant interroge **chaque** membre du binôme, sur n'importe quelle partie.

## Grille de notation (sur 20)

| Critère | Points |
|---|---|
| Règles de gestion claires et complètes ; dictionnaire sans donnée calculable | 2 |
| MCD juste (entités, identifiants, associations, cardinalités justifiées) ; vérification 3FN | 4 |
| MLD et script de création : tables, types, clés, contraintes nommées, script rejouable | 4 |
| Données réalistes et transaction | 2 |
| Requêtes : les 12 catégories couvertes, résultats justes, vue et index | 5 |
| Soutenance : démonstration qui fonctionne, réponses de **chaque** membre | 3 |

## Ce qui est interdit

- Rendre un sujet déjà traité en atelier (la clinique), ou recopier le projet d'un autre binôme.
- Faire générer le projet par une IA sans le comprendre : la soutenance le révèle immédiatement. Vous pouvez demander de l'aide à une IA pour **comprendre** une erreur ; dites-le dans le rapport, et expliquez ce que vous avez appris.
