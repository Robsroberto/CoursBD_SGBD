<div class="bandeau"><img src="../images/bandeau-sql.png" alt="SQL" /></div>

# Atelier 2 : le modèle de la clinique

<p class="auteur">Par <strong>Robert DIASSÉ</strong>, Ingénieur Logiciel et Data</p>

> **Cours** : Base de données 1, fondements, modélisation et SQL · **Chapitre** : 2, Modéliser les données · **Version** : 2026-10-31

## Avant de commencer

| | |
|---|---|
| **Ce que vous allez construire** | Le modèle complet de la clinique Santé Plus : le modèle du chapitre 2 (patients, médecins, services, consultations, prescriptions), complété par les **hospitalisations**, les **paiements** et les **assurances**. Livrables : dictionnaire de données, MCD, MLD, et une partie du modèle en notation ERD |
| **Durée** | 🟢 Débutant : 6 h · 🔵 Standard : 4 h 30 · 🟣 Expert : 3 h (sans les défis) |
| **Prérequis** | Avoir lu le chapitre 2 |
| **Fichiers fournis** | Aucun |
| **Rendu** | Un document (PDF) avec le dictionnaire, le MCD (dessiné avec un outil), la vérification 3FN, le MLD et le schéma ERD ; plus le fichier source de l'outil (Looping, draw.io ou Data Modeler) |

A la fin, votre MLD compte **dix tables** : les six du chapitre 2, et quatre nouvelles.

> 📍 **Point de départ : le modèle du chapitre 2** (sections 3.3 et 5.2), que vous complétez. Vous ne créez encore **aucune** table dans le SGBD.
>
> **La suite du fil rouge** : atelier 2 (ce travail) → atelier 3 (la base complète, créée en SQL à partir de **votre** MLD) → atelier 4 (les requêtes de la clinique).

### Comment travailler

L'atelier est découpé en **8 étapes** (0 à 7). Travaillez d'abord **sur papier** (au crayon : vous allez gommer), puis reportez le résultat dans l'outil à l'étape 7.

**Trois règles pour tout l'atelier**

1. **Chaque choix se justifie par une règle de gestion.** Notez à côté de chaque cardinalité le numéro de la règle qui la justifie.
2. **Une information à un seul endroit.** Si vous écrivez deux fois la même propriété, c'est qu'il manque une entité ou une association.
3. **Pas de SQL** dans cet atelier.

### Les nouvelles règles de gestion

La direction de la clinique complète les règles 1 à 6 du chapitre :

7. La clinique possède des **chambres**. Une chambre a un numéro (par exemple `P-12`), un type (individuelle ou double), un prix par nuit en FCFA et un étage. Chaque chambre dépend d'**un** service ; un service peut ne pas avoir de chambres (les Consultations générales, par exemple).
8. Un patient peut être **hospitalisé**. Chaque **séjour** a un numéro, une date d'entrée, une date de sortie (vide tant que le patient est encore là) ; il se déroule dans **une** chambre et il est suivi par **un** médecin responsable. Un patient peut avoir fait plusieurs séjours, ou aucun. Une chambre accueille, au fil du temps, de nombreux séjours.
9. Une consultation se paie en **un ou plusieurs paiements** (par exemple une avance, puis le reste). Chaque paiement a un numéro, une date, un montant et un mode (espèces, *mobile money*, carte, assurance). Une consultation peut ne pas encore être payée.
10. Un patient peut avoir **une assurance** (une mutuelle ou l'IPM de son entreprise), et une seule. Une assurance a un code, le nom de l'organisme et un taux de prise en charge (par exemple 80 %). Plusieurs patients peuvent avoir la même assurance.

---

## Étape 0 : relire le modèle du chapitre (15 min)

🎯 **Objectif** : partir d'une base solide.

🛠️ **A faire**

1. Recopiez sur une feuille le MCD de la section 3.3 du chapitre 2 et le MLD de la section 5.2.
2. Pour chacune des quatre associations (`PASSER`, `EFFECTUER`, `APPARTENIR`, `PRESCRIRE`), écrivez les deux phrases de lecture des cardinalités.

✅ **Vérification** : vous savez expliquer, sans regarder le chapitre, pourquoi `PRESCRIRE` est devenue une table et pas `APPARTENIR`.

---

## Étape 1 : compléter le dictionnaire de données (30 min)

🎯 **Objectif** : relever toutes les nouvelles informations des règles 7 à 10.

🛠️ **A faire**

1. Ajoutez au dictionnaire du chapitre (section 2.2) une ligne par nouvelle information : code, signification, type, taille, remarque.
2. Repérez les **identifiants** : quelles informations servent à distinguer une chambre, un séjour, un paiement, une assurance ?

🔎 **A chercher** : chapitre 2, section 2.

💡 **A comprendre**

- Faut-il ajouter une colonne « nombre de nuits » au séjour ? Et « reste à payer » à la consultation ? (Encadré 🟢 de la section 2.2.)
- Le taux de prise en charge est-il un texte ou un nombre ? Pourquoi ?

✅ **Vérification** : vous avez **14 nouvelles informations** dans le dictionnaire, identifiants compris (4 pour la chambre, 3 pour le séjour, 4 pour le paiement, 3 pour l'assurance). Aucune n'est calculable.

<details><summary>Indice : la liste</summary>

Chambre : `num_chambre`, `type_chambre`, `prix_nuit`, `etage_chambre`. Séjour : `num_sejour`, `date_entree`, `date_sortie`. Paiement : `num_paiement`, `date_paiement`, `montant`, `mode_paiement`. Assurance : `code_assurance`, `nom_assureur`, `taux_prise_en_charge`. Total : 4 + 3 + 4 + 3 = 14, avec la remarque « vide tant que le patient est là » sur `date_sortie`. Si vous en trouvez davantage, vérifiez que vous n'avez pas ajouté une donnée calculable (nombre de nuits, reste à payer).

</details>

---

## Étape 2 : les hospitalisations dans le MCD (45 min)

🎯 **Objectif** : ajouter les chambres et les séjours au MCD.

🛠️ **A faire**

1. Ajoutez les entités `CHAMBRE` et `SEJOUR` avec leurs propriétés et leur identifiant souligné.
2. Reliez-les au reste du modèle avec les associations nécessaires (règles 7 et 8) : une chambre et son service ; un séjour et son patient ; un séjour et sa chambre ; un séjour et son médecin responsable.
3. Placez toutes les cardinalités, en notant à côté le numéro de la règle.

🔎 **A chercher** : chapitre 2, sections 3.2 et 3.3 (la consultation, qui ressemble beaucoup au séjour).

💡 **A comprendre**

- Pourquoi le séjour est-il une **entité**, et pas une association entre `PATIENT` et `CHAMBRE` ? (Pensez à un patient qui revient dans la même chambre six mois plus tard.)
- Quelle est la cardinalité côté `SERVICE` dans l'association avec `CHAMBRE` ? Quelle règle dit qu'elle commence par 0 ?

✅ **Vérification** : quatre nouvelles associations, toutes avec une patte `1,1` côté `CHAMBRE` ou `SEJOUR`.

---

## Étape 3 : les paiements et les assurances (35 min)

🎯 **Objectif** : terminer le MCD.

🛠️ **A faire**

1. Ajoutez l'entité `PAIEMENT`, reliée à `CONSULTATION` (règle 9).
2. Ajoutez l'entité `ASSURANCE`, reliée à `PATIENT` (règle 10).
3. Placez les cardinalités et leurs justifications.

💡 **A comprendre**

- Côté `CONSULTATION`, la cardinalité de l'association avec `PAIEMENT` commence-t-elle par 0 ou par 1 ? Quelle phrase de la règle 9 le dit ?
- Côté `PATIENT`, la cardinalité de l'association avec `ASSURANCE` est `0,1`. Qu'est-ce que cela va changer dans le MLD (chapitre 2, section 5.3) ?

✅ **Vérification** : le MCD compte **9 entités** et **10 associations** (les 4 du chapitre et vos 6 nouvelles).

<details><summary>Indice : les cardinalités de l'assurance</summary>

« Un patient peut avoir une assurance, et une seule » : `PATIENT 0,1`. « Plusieurs patients peuvent avoir la même assurance » ; une assurance enregistrée peut ne couvrir encore personne : `ASSURANCE 0,n`.

</details>

---

## Étape 4 : vérifier les formes normales (35 min)

🎯 **Objectif** : prouver que le modèle ne cache pas de redondance.

🛠️ **A faire**

1. L'ancienne secrétaire tenait cette fiche de séjour, sur une seule table :
   `fiche_sejour(num_sejour, date_entree, date_sortie, num_patient, nom_patient, code_assurance, nom_assureur, taux, num_chambre, type_chambre, prix_nuit, code_service, nom_service)`
2. Écrivez toutes ses dépendances fonctionnelles.
3. Dites en quelle forme normale elle est, et pourquoi.
4. Décomposez-la en tables 3FN. Retrouvez-vous des tables de votre MCD ?

🔎 **A chercher** : chapitre 2, section 4 (le « registre »).

💡 **A comprendre**

- Quelles **anomalies** (mise à jour, insertion, suppression) cette fiche provoque-t-elle ? Donnez un exemple de chaque, avec la clinique.

✅ **Vérification** : la fiche est en 2FN mais **pas en 3FN** (dépendances transitives, par exemple `num_sejour → num_chambre → prix_nuit`) ; la décomposition donne `sejour`, `patient`, `assurance`, `chambre`, `service`.

---

## Étape 5 : le MLD (40 min)

🎯 **Objectif** : transformer le MCD complet en modèle logique.

🛠️ **A faire**

1. Appliquez les règles de passage (chapitre 2, section 5.1) à **tout** le MCD.
2. Écrivez le MLD en texte : clé primaire soulignée, clés étrangères précédées de `#`.
3. Pour chaque clé étrangère, indiquez si elle est **obligatoire** ou **facultative** (section 5.3).
4. Listez les contraintes de **domaine** que vous voyez (valeurs possibles d'un type de chambre, d'un mode de paiement, montant positif, taux entre 0 et 100...).

💡 **A comprendre**

- Combien de tables obtenez-vous ? Lesquelles viennent d'une entité, lesquelles d'une association ?
- `sejour.date_sortie` peut être vide : est-ce une clé étrangère ? Quelle différence avec `patient.code_assurance`, qui peut aussi être vide ?

✅ **Vérification** : **dix** tables (`service`, `medecin`, `patient`, `assurance`, `consultation`, `medicament`, `prescription`, `chambre`, `sejour`, `paiement`) ; les nouvelles sont `chambre` (avec `#code_service`), `sejour` (avec `#num_patient`, `#num_chambre`, `#num_medecin`), `paiement` (avec `#num_consultation`) et `assurance` ; et `patient` gagne `#code_assurance`, **facultative**.

---

## Étape 6 : une partie du modèle en ERD (30 min)

🎯 **Objectif** : montrer que vous savez passer d'une notation à l'autre.

🛠️ **A faire**

1. Dessinez `PATIENT`, `SEJOUR`, `CHAMBRE` et `SERVICE` en notation ERD (pattes de corbeau), avec les attributs et l'identifiant marqué `#`.
2. Sous chaque relation, écrivez les deux phrases à la façon d'Oracle : « Chaque ... doit / peut ... un et un seul / un ou plusieurs ... ».

🔎 **A chercher** : chapitre 2, section 6.

💡 **A comprendre**

- Du côté de quelle entité dessinez-vous la patte de corbeau entre `PATIENT` et `SEJOUR` ? Comparez avec la place de `0,n` dans votre MCD.

✅ **Vérification** : entre `PATIENT` et `SEJOUR`, le symbole « zéro ou plusieurs » (`○<`) est près de `SEJOUR`, et « exactement un » (`┼┼`) près de `PATIENT`.

---

## Étape 7 : dessiner avec un outil, et rendre (45 min)

🎯 **Objectif** : un modèle propre, lisible, prêt pour le chapitre 3.

🛠️ **A faire**

1. Reportez votre MCD dans **Looping** (qui génère aussi le MLD : comparez avec le vôtre), ou dans **draw.io**, ou dans **Oracle SQL Developer Data Modeler** (modèle logique, puis *Engineer to Relational Model*).
2. Rassemblez dans un seul PDF : le dictionnaire, le MCD, la vérification de l'étape 4, le MLD, le schéma ERD.
3. Écrivez, à la fin du document, **trois** questions que vous poseriez à la direction de la clinique pour lever une ambiguïté des règles (par exemple : « une chambre double peut-elle accueillir deux patients en même temps ? »).

✅ **Vérification** : si vous utilisez Looping ou Data Modeler, le MLD généré a les mêmes tables et les mêmes clés étrangères que le vôtre ; sinon, cherchez l'erreur (chez vous ou dans le dessin).

---

## 🏆 Défis (facultatifs)

1. **Les chambres doubles.** Une chambre double accueille deux patients en même temps. Le modèle le permet-il ? Que faudrait-il ajouter pour **empêcher** un troisième patient ? (Indice : ce n'est pas une affaire de cardinalité ; c'est une règle qu'on vérifiera en SQL.)
2. **Le médecin référent.** Ajoutez l'association réflexive `ENCADRER` (chapitre 2, encadré 🔵 de la section 3.3) et sa traduction dans le MLD.
3. **Les spécialités.** Aujourd'hui, `specialite` est un texte libre dans `MEDECIN`. Proposez une entité `SPECIALITE`, et dites ce que cela change (avantages, inconvénients).
4. **Historique des tarifs.** Le tarif d'une consultation change chaque année. Comment garder le tarif **payé** par chaque patient, même après un changement de prix ?

---

## Grille d'autoévaluation

| Je sais... | Oui | Pas encore |
|---|---|---|
| relever les informations d'un besoin dans un dictionnaire de données, sans donnée calculable | ☐ | ☐ |
| dessiner des entités avec leur identifiant, et les relier par des associations nommées par un verbe | ☐ | ☐ |
| placer et justifier les cardinalités par une règle de gestion | ☐ | ☐ |
| décider si une information va dans une entité ou dans une association | ☐ | ☐ |
| écrire les dépendances fonctionnelles d'une table et dire si elle est en 1FN, 2FN, 3FN | ☐ | ☐ |
| transformer un MCD en MLD, avec les clés primaires et étrangères, obligatoires ou facultatives | ☐ | ☐ |
| lire et dessiner une relation en notation ERD | ☐ | ☐ |
