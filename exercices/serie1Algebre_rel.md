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
footer: Licence 1 Informatique &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ISI (Institut Supérieur D'Informatique) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RD
---
<img src="../isi.png" alt="ISI" width="100px">

# SÉRIE D'EXERCICES — ALGÈBRE RELATIONNELLE

## Par Robert DIASSÉ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

---

## CONSIGNES GÉNÉRALES

Cette série porte sur l'**algèbre relationnelle**. Elle réutilise les schémas que vous connaissez déjà depuis la série MLD.

Les exercices sont classés en **quatre niveaux de difficulté croissante** :

- **Niveau 1** — Opérations unaires (sélection, projection)
- **Niveau 2** — Composition d'opérations unaires
- **Niveau 3** — Opérations ensemblistes et jointures simples
- **Niveau 4** — Jointures multiples, compositions avancées et division

Pour chaque question, vous devez écrire l'**expression en algèbre relationnelle** en utilisant les notations du cours : σ (sélection), π (projection), ρ (renommage), ∪ (union), ∩ (intersection), − (différence), × (produit cartésien), ▷◁ (jointure), ÷ (division).

---

## SCHEMAS ET DONNEES DE TRAVAIL

Tous les exercices reposent sur les deux bases suivantes.

---

### Base A — Gestion de bibliothèque

```
AUTEUR(id_auteur, nom_auteur, prenom_auteur)
LIVRE(isbn, titre, annee_pub, editeur, id_auteur)
ADHERENT(num_carte, nom, prenom, ville)
EMPRUNT(id_emprunt, num_carte, isbn, date_emprunt)
```

#### Relation AUTEUR

| id_auteur | nom_auteur | prenom_auteur |
|-----------|-----------|--------------|
| A1 | Kane | Cheikh Hamidou |
| A2 | Ba | Mariama |
| A3 | Orwell | George |
| A4 | Asimov | Isaac |

#### Relation LIVRE

| isbn | titre | annee_pub | editeur | id_auteur |
|------|-------|-----------|---------|-----------|
| L1 | L'Aventure ambigue | 1961 | Julliard | A1 |
| L2 | Une si longue lettre | 1979 | NEA | A2 |
| L3 | 1984 | 1949 | Secker | A3 |
| L4 | Fondation | 1951 | Gnome | A4 |
| L5 | Les robots | 1950 | Gnome | A4 |

#### Relation ADHERENT

| num_carte | nom | prenom | ville |
|-----------|-----|--------|-------|
| C1 | Sow | Fatou | Dakar |
| C2 | Diop | Ousmane | Thies |
| C3 | Fall | Ibrahima | Dakar |
| C4 | Ndiaye | Aissatou | Louga |

#### Relation EMPRUNT

| id_emprunt | num_carte | isbn | date_emprunt |
|------------|-----------|------|--------------|
| E1 | C1 | L1 | 2025-01-10 |
| E2 | C1 | L3 | 2025-01-15 |
| E3 | C2 | L4 | 2025-01-12 |
| E4 | C3 | L2 | 2025-01-20 |
| E5 | C3 | L5 | 2025-01-20 |
| E6 | C4 | L1 | 2025-02-05 |

---

### Base B — Gestion de commandes

```
CLIENT(code_client, nom, prenom, ville)
COMMANDE(num_commande, date_commande, code_client)
ARTICLE(ref_article, designation, prix_unitaire, categorie)
LIGNE_CMD(num_commande, ref_article, quantite)
```

#### Relation CLIENT

| code_client | nom | prenom | ville |
|-------------|-----|--------|-------|
| CL1 | Mbaye | Cheikh | Dakar |
| CL2 | Diallo | Fatoumata | Saint-Louis |
| CL3 | Gueye | Mamadou | Dakar |

#### Relation COMMANDE

| num_commande | date_commande | code_client |
|--------------|---------------|-------------|
| CM1 | 2025-03-01 | CL1 |
| CM2 | 2025-03-05 | CL2 |
| CM3 | 2025-03-10 | CL1 |
| CM4 | 2025-03-12 | CL3 |

#### Relation ARTICLE

| ref_article | designation | prix_unitaire | categorie |
|-------------|-------------|---------------|-----------|
| AR1 | Stylo bille | 500 | Fourniture |
| AR2 | Cahier A4 | 1200 | Fourniture |
| AR3 | Calculatrice | 8500 | Electronique |
| AR4 | Clé USB 16Go | 5000 | Electronique |

#### Relation LIGNE_CMD

| num_commande | ref_article | quantite |
|--------------|-------------|----------|
| CM1 | AR1 | 10 |
| CM1 | AR2 | 5 |
| CM2 | AR3 | 2 |
| CM3 | AR1 | 20 |
| CM3 | AR4 | 1 |
| CM4 | AR2 | 8 |
| CM4 | AR3 | 1 |

---

# NIVEAU 1 — Operations unaires

> Ces exercices utilisent uniquement la sélection (σ) et la projection (π). Travaillez sur **une seule relation** à la fois.

---

## Exercice 1

**Base A — Bibliothèque**

1. Donnez l'expression permettant d'obtenir les adhérents qui habitent à **Dakar**.

2. Donnez l'expression permettant d'obtenir **uniquement** les titres et l'année de publication de tous les livres.

3. Donnez l'expression permettant d'obtenir les livres publiés **avant 1960**.

4. Donnez l'expression permettant d'obtenir **uniquement** les noms et prénoms de tous les adhérents, sans les autres colonnes.

---

## Exercice 2

**Base B — Commandes**

1. Donnez l'expression permettant d'obtenir les articles dont le prix unitaire est **supérieur ou égal à 5000**.

2. Donnez l'expression permettant d'obtenir **uniquement** les références d'articles et leurs catégories.

3. Donnez l'expression permettant d'obtenir les clients habitant à **Dakar**.

4. Donnez l'expression permettant d'obtenir les lignes de commande dont la quantité commandée est **strictement supérieure à 5**.

---

# NIVEAU 2 — Composition d'operations unaires

> Ces exercices combinent σ et π sur une même relation. Pensez à appliquer d'abord la sélection, puis la projection.

---

## Exercice 3

**Base A — Bibliothèque**

1. Donnez l'expression permettant d'obtenir **uniquement** les titres des livres publiés après 1960.

2. Donnez l'expression permettant d'obtenir **les noms et prénoms** des adhérents qui n'habitent **pas** à Dakar.

3. Donnez l'expression permettant d'obtenir **les isbn** des emprunts réalisés par l'adhérent dont le numéro de carte est **C1**.

4. Donnez l'expression permettant d'obtenir **les titres et éditeurs** des livres publiés entre 1950 et 1960 inclus (utilisez ∧ pour exprimer ET).

---

## Exercice 4

**Base B — Commandes**

1. Donnez l'expression permettant d'obtenir **les désignations** des articles de catégorie **Electronique**.

2. Donnez l'expression permettant d'obtenir **les numéros de commande et les dates** des commandes passées par le client **CL1**.

3. Donnez l'expression permettant d'obtenir **les références d'article** dont la quantité commandée est **inférieure à 5** dans une ligne de commande.

---

# NIVEAU 3 — Operations ensemblistes et jointures simples

> Ces exercices introduisent les opérations sur plusieurs relations. Vérifiez toujours la compatibilité des schémas avant d'appliquer une union, une intersection ou une différence.

---

## Exercice 5 — Operations ensemblistes

**Base A — Bibliothèque**

Considérez les deux expressions suivantes :

```
R1 = πnum_carte(σville='Dakar'(ADHERENT))
R2 = πnum_carte(σville='Thies'(ADHERENT))
```

1. Que contient **R1** ? Que contient **R2** ? Donnez les tuples de chaque résultat.

2. Donnez l'expression permettant d'obtenir les numéros de carte des adhérents habitant **à Dakar ou à Thiès**.

3. Donnez l'expression permettant d'obtenir les numéros de carte des adhérents habitant **à Dakar mais pas à Thiès** (dans ce cas précis, expliquez pourquoi le résultat est le même que R1).

4. **Base B — Commandes** : Donnez l'expression permettant d'obtenir les références d'articles qui ont été commandés **dans la commande CM1 ou dans la commande CM3**.

---

## Exercice 6 — Jointure simple

**Base A — Bibliothèque**

1. Donnez l'expression de jointure permettant d'associer chaque livre à son auteur. Précisez la condition de jointure.

2. En partant du résultat précédent, donnez l'expression permettant d'obtenir **uniquement** les titres des livres avec le nom et prénom de leur auteur.

3. **Base B — Commandes** : Donnez l'expression de jointure permettant d'associer chaque commande au client qui l'a passée.

4. En partant du résultat précédent, donnez l'expression permettant d'obtenir **les numéros de commande et les noms des clients** correspondants.

---

# NIVEAU 4 — Jointures multiples et division

> Ces exercices mobilisent plusieurs jointures successives ou la division. Décomposez toujours votre réponse en étapes numérotées (R1, R2, R3...) avant d'écrire l'expression finale.

---

## Exercice 7 — Jointures multiples

**Base A — Bibliothèque**

1. En trois étapes, donnez les expressions permettant d'obtenir la liste des **noms et prénoms des adhérents** avec les **titres des livres qu'ils ont empruntés**. Décomposez ainsi :
   - Étape 1 : jointure EMPRUNT et ADHERENT
   - Étape 2 : jointure du résultat avec LIVRE
   - Étape 3 : projection sur les colonnes souhaitées

2. En partant de la même démarche, donnez l'expression permettant d'obtenir les **noms des adhérents de Dakar** avec les **titres des livres qu'ils ont empruntés**.

---

## Exercice 8 — Jointures multiples

**Base B — Commandes**

1. En trois étapes, donnez les expressions permettant d'obtenir la liste des **noms des clients** avec les **désignations des articles** qu'ils ont commandés et les **quantités** correspondantes. Décomposez :
   - Étape 1 : jointure LIGNE_CMD et ARTICLE
   - Étape 2 : jointure du résultat avec COMMANDE
   - Étape 3 : jointure du résultat avec CLIENT
   - Étape 4 : projection finale

2. En partant de la même démarche, donnez l'expression permettant d'obtenir **uniquement** les noms des clients ayant commandé des articles de catégorie **Electronique**.

---

## Exercice 9 — Division

**Base A — Bibliothèque**

Considérez la relation suivante, construite à partir des données :

```
TOUS_LIVRES_ASIMOV = πisbn(σid_auteur='A4'(LIVRE))
```

Cette relation contient les isbn de tous les livres d'Asimov : {L4, L5}.

1. Que représente le résultat de l'expression suivante ?
   ```
   πnum_carte, isbn(EMPRUNT) ÷ TOUS_LIVRES_ASIMOV
   ```

2. Construisez la relation `LIVRES_GNOME` contenant les isbn de tous les livres publiés par l'éditeur **Gnome**, puis donnez l'expression permettant de trouver les adhérents ayant emprunté **tous** ces livres.

---

## Exercice 10 — Synthese generale

**Base A — Bibliothèque**

Répondez à chacune des questions suivantes en écrivant l'expression complète en algèbre relationnelle. Décomposez en étapes si nécessaire.

1. Quels sont les **titres des livres** empruntés par l'adhérent dont le nom est **Sow** ?

2. Quels sont les **noms et prénoms des adhérents** qui ont emprunté au moins un livre publié **avant 1960** ?

3. Quels sont les **noms des auteurs** dont au moins un livre a été emprunté par un adhérent habitant à **Dakar** ?

4. Quels sont les **numéros de carte** des adhérents qui ont emprunté **au moins deux livres** différents ? *(Indication : utilisez un renommage ρ pour comparer la relation EMPRUNT avec elle-même.)*