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

# CHAPITRE 5 — ALGÈBRE RELATIONNELLE

## Par Robert DIASSÉ

<img src="sql.jpeg" alt="ISI" width="50px">


---


---

## **A. INTRODUCTION**

L'algèbre relationnelle constitue le **fondement théorique** du modèle relationnel et des systèmes de gestion de bases de données. Développée par Edgar F. Codd en 1970, elle fournit un ensemble d'opérations mathématiques permettant de manipuler les relations de manière formelle et rigoureuse.

Contrairement au SQL qui est un langage **déclaratif** (on décrit *ce que l'on veut* obtenir), l'algèbre relationnelle est un langage **procédural** (on décrit *comment* obtenir le résultat par une séquence d'opérations).

**Place dans la démarche de modélisation :**

```
┌─────────────────────────────────────────────────────────┐
│         ÉVOLUTION DE LA MODÉLISATION                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  MCD (Conceptuel)     → Que modéliser ?                 │
│           ↓                                             │
│  MLD (Logique)        → Comment structurer ?            │
│           ↓                                             │
│  Algèbre Relationnelle → Comment manipuler ?            │
│           ↓                                             │
│  SQL (Implémentation) → Comment implémenter ?           │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Objectifs du chapitre :**
- Maîtriser les opérations fondamentales sur les relations
- Comprendre la composition d'opérations pour résoudre des requêtes complexes
- Établir le lien entre algèbre relationnelle et langage SQL

---

## **B. CONCEPTS FONDAMENTAUX**

### **I. Définition d'une relation**

En algèbre relationnelle, une **relation** est un ensemble de tuples (lignes) partageant les mêmes attributs (colonnes). Elle correspond à la notion de **table** dans le modèle logique.

**Propriétés fondamentales d'une relation :**
- Chaque tuple est **unique** (pas de doublons)
- L'**ordre des tuples** n'a pas d'importance
- L'**ordre des attributs** n'a pas d'importance
- Chaque attribut possède un **domaine de valeurs** défini

### **II. Propriété de fermeture**

L'algèbre relationnelle est un système **fermé** :
- L'entrée d'une opération est une ou plusieurs relations
- La **sortie** est toujours une **relation**

Cette propriété permet d'**imbriquer** les opérations : le résultat d'une opération peut servir d'entrée à une autre opération.

### **III. Notations**

**Relation :** R, S, T

**Attributs :** A, B, C

**Schéma de relation :** R(A₁, A₂, ..., Aₙ)

**Cardinalité :** nombre de tuples dans une relation, noté |R|

**Degré :** nombre d'attributs d'une relation

### **IV. Relations d'exemple**

Pour illustrer les opérations, nous utiliserons les relations suivantes, basées sur le MLD du chapitre précédent :

**ÉTUDIANT**
```
┌─────────────┬──────────┬─────────┬─────────────┐
│ id_etudiant │   nom    │ prenom  │    ville    │
├─────────────┼──────────┼─────────┼─────────────┤
│     1001    │  Dupont  │  Marie  │    Paris    │
│     1002    │  Martin  │  Pierre │    Lyon     │
│     1003    │  Durand  │  Sophie │    Paris    │
│     1004    │  Bernard │  Jean   │   Marseille │
└─────────────┴──────────┴─────────┴─────────────┘
```

**COURS**
```
┌──────────┬──────────────┬──────────┐
│ id_cours │   intitule   │ nb_heures│
├──────────┼──────────────┼──────────┤
│    C1    │ Mathématiques│    40    │
│    C2    │ Informatique │    60    │
│    C3    │   Physique   │    30    │
└──────────┴──────────────┴──────────┘
```

**INSCRIPTION**
```
┌─────────────┬──────────┬──────┐
│ id_etudiant │ id_cours │ note │
├─────────────┼──────────┼──────┤
│     1001    │    C1    │  15  │
│     1001    │    C2    │  18  │
│     1002    │    C1    │  12  │
│     1003    │    C2    │  14  │
└─────────────┴──────────┴──────┘
```

---

## **C. OPÉRATIONS UNAIRES**

Les opérations unaires s'appliquent à une seule relation.

### **I. Sélection (σ) - Restriction**

**Définition :** La sélection extrait les tuples d'une relation qui satisfont une condition donnée. C'est un **filtre horizontal**.

**Notation :** $$\sigma_{\text{condition}}(R)$$

**Propriétés :**
- Le schéma reste identique
- La cardinalité diminue ou reste égale
- Opération de filtrage des lignes

**Exemple 1 :** Sélectionner les étudiants habitant à Paris

$$\sigma_{\text{ville='Paris'}}(\text{ÉTUDIANT})$$

**Résultat :**
```
┌─────────────┬──────────┬─────────┬─────────────┐
│ id_etudiant │   nom    │ prenom  │    ville    │
├─────────────┼──────────┼─────────┼─────────────┤
│     1001    │  Dupont  │  Marie  │    Paris    │
│     1003    │  Durand  │  Sophie │    Paris    │
└─────────────┴──────────┴─────────┴─────────────┘
```

**Conditions complexes :**
- **ET logique (∧) :** $$\sigma_{\text{ville='Paris' } \land \text{ nom='Dupont'}}(\text{ÉTUDIANT})$$
- **OU logique (∨) :** $$\sigma_{\text{ville='Paris' } \lor \text{ ville='Lyon'}}(\text{ÉTUDIANT})$$
- **Négation (¬) :** $$\sigma_{\neg(\text{ville='Paris'})}(\text{ÉTUDIANT})$$
- **Comparaisons :** $$\sigma_{\text{note} > 15}(\text{INSCRIPTION})$$

### **II. Projection (π)**

**Définition :** La projection extrait certains attributs d'une relation en éliminant automatiquement les doublons. C'est un **filtre vertical**.

**Notation :** $$\pi_{\text{liste\_attributs}}(R)$$

**Propriétés :**
- Le degré diminue ou reste égal
- Élimine les doublons automatiquement
- Opération de filtrage des colonnes

**Exemple 1 :** Extraire les noms et prénoms des étudiants

$$\pi_{\text{nom, prenom}}(\text{ÉTUDIANT})$$

**Résultat :**
```
┌──────────┬─────────┐
│   nom    │ prenom  │
├──────────┼─────────┤
│  Dupont  │  Marie  │
│  Martin  │  Pierre │
│  Durand  │  Sophie │
│  Bernard │  Jean   │
└──────────┴─────────┘
```

**Exemple 2 :** Extraire les villes (avec élimination des doublons)

$$\pi_{\text{ville}}(\text{ÉTUDIANT})$$

**Résultat :**
```
┌─────────────┐
│    ville    │
├─────────────┤
│    Paris    │
│    Lyon     │
│   Marseille │
└─────────────┘
```

### **III. Renommage (ρ)**

**Définition :** Le renommage permet de modifier le nom d'une relation ou de ses attributs.

**Notations :**
- Renommer la relation : $$\rho_{S}(R)$$
- Renommer un attribut : $$\rho_{B/A}(R)$$ (remplace A par B)
- Renommer relation et attributs : $$\rho_{S(B_1, B_2, ..., B_n)}(R)$$

**Utilité :** Éviter les conflits de noms lors des jointures, clarifier la sémantique.

**Exemple :**

$$\rho_{\text{ELEVE(numero, nom\_famille, prenom, localite)}}(\text{ÉTUDIANT})$$

---

## **D. COMPOSITION D'OPÉRATIONS UNAIRES**

Les opérations peuvent être combinées pour former des requêtes complexes.

**Exemple :** Extraire les noms des étudiants habitant à Paris

$$\pi_{\text{nom}}(\sigma_{\text{ville='Paris'}}(\text{ÉTUDIANT}))$$

**Évaluation étape par étape :**

**Étape 1 - Sélection :**
$$\sigma_{\text{ville='Paris'}}(\text{ÉTUDIANT})$$
→ Filtre les étudiants parisiens

**Étape 2 - Projection :**
$$\pi_{\text{nom}}$$
→ Extrait uniquement les noms

**Résultat final :**
```
┌──────────┐
│   nom    │
├──────────┤
│  Dupont  │
│  Durand  │
└──────────┘
```

---

## **E. OPÉRATIONS ENSEMBLISTES**

Ces opérations traitent les relations comme des ensembles mathématiques. Elles nécessitent que les relations soient **compatibles** (même nombre d'attributs, domaines compatibles).

### **I. Union (∪)**

**Définition :** L'union de deux relations R et S contient tous les tuples présents dans R ou dans S, sans doublons.

**Notation :** $$R \cup S$$

**Condition de compatibilité :**
- Même nombre d'attributs
- Domaines compatibles pour chaque attribut

**Exemple :**

```
ÉTUDIANTS_PARIS                    ÉTUDIANTS_LYON
┌─────────────┬──────────┐         ┌─────────────┬──────────┐
│ id_etudiant │   nom    │         │ id_etudiant │   nom    │
├─────────────┼──────────┤         ├─────────────┼──────────┤
│     1001    │  Dupont  │         │     1002    │  Martin  │
│     1003    │  Durand  │         │     1005    │  Petit   │
└─────────────┴──────────┘         └─────────────┴──────────┘
```

$$\text{ÉTUDIANTS\_PARIS} \cup \text{ÉTUDIANTS\_LYON}$$

**Résultat :**
```
┌─────────────┬──────────┐
│ id_etudiant │   nom    │
├─────────────┼──────────┤
│     1001    │  Dupont  │
│     1003    │  Durand  │
│     1002    │  Martin  │
│     1005    │  Petit   │
└─────────────┴──────────┘
```

### **II. Intersection (∩)**

**Définition :** L'intersection contient les tuples présents **simultanément** dans les deux relations.

**Notation :** $$R \cap S$$

### **III. Différence (−)**

**Définition :** La différence R − S contient les tuples présents dans R mais **pas** dans S.

**Notation :** $$R - S$$

**Propriété importante :** L'opération n'est **pas commutative** : $$R - S \neq S - R$$

---

## **F. PRODUIT CARTÉSIEN (×)**

**Définition :** Le produit cartésien de deux relations R et S produit une nouvelle relation contenant **toutes les combinaisons possibles** des tuples de R avec les tuples de S.

**Notation :** $$R \times S$$

**Propriétés :**
- Si R a n tuples et S a m tuples, alors $$R \times S$$ a $$n \times m$$ tuples
- Le degré de $$R \times S$$ est la somme des degrés de R et S

**Exemple :**

```
ÉTUDIANT (simplifié)               COURS (simplifié)
┌─────────────┬──────────┐         ┌──────────┬──────────────┐
│ id_etudiant │   nom    │         │ id_cours │   intitule   │
├─────────────┼──────────┤         ├──────────┼──────────────┤
│     1001    │  Dupont  │         │    C1    │ Mathématiques│
│     1002    │  Martin  │         │    C2    │ Informatique │
└─────────────┴──────────┘         └──────────┴──────────────┘
```

$$\text{ÉTUDIANT} \times \text{COURS}$$

**Résultat :**
```
┌─────────────┬──────────┬──────────┬──────────────┐
│ id_etudiant │   nom    │ id_cours │   intitule   │
├─────────────┼──────────┼──────────┼──────────────┤
│     1001    │  Dupont  │    C1    │ Mathématiques│
│     1001    │  Dupont  │    C2    │ Informatique │
│     1002    │  Martin  │    C1    │ Mathématiques│
│     1002    │  Martin  │    C2    │ Informatique │
└─────────────┴──────────┴──────────┴──────────────┘
```

**Utilisation :** Le produit cartésien seul génère souvent des résultats non pertinents. Il sert de base théorique aux jointures.

---

## **G. JOINTURES**

La jointure est l'opération la plus importante en pratique. Elle permet de combiner des informations provenant de plusieurs relations en utilisant des valeurs communes.

### **I. Jointure conditionnelle (θ-join)**

**Définition :** Jointure de deux relations selon une condition θ quelconque.

**Notation :** $$R \bowtie_{\theta} S$$

**Équivalence :** $$R \bowtie_{\theta} S = \sigma_{\theta}(R \times S)$$

### **II. Équi-jointure**

**Définition :** Cas particulier où la condition θ est une égalité.

**Exemple :** Associer chaque inscription à l'étudiant correspondant

$$\text{ÉTUDIANT} \bowtie_{\text{ÉTUDIANT.id\_etudiant = INSCRIPTION.id\_etudiant}} \text{INSCRIPTION}$$

**Résultat :**
```
┌─────────────┬──────────┬─────────┬─────────────┬──────────┬──────┐
│ id_etudiant │   nom    │ prenom  │    ville    │ id_cours │ note │
├─────────────┼──────────┼─────────┼─────────────┼──────────┼──────┤
│     1001    │  Dupont  │  Marie  │    Paris    │    C1    │  15  │
│     1001    │  Dupont  │  Marie  │    Paris    │    C2    │  18  │
│     1002    │  Martin  │  Pierre │    Lyon     │    C1    │  12  │
│     1003    │  Durand  │  Sophie │    Paris    │    C2    │  14  │
└─────────────┴──────────┴─────────┴─────────────┴──────────┴──────┘
```

### **III. Jointure naturelle (⋈)**

**Définition :** Jointure équi sur les attributs **de même nom**, en éliminant les colonnes dupliquées.

**Notation :** $$R \bowtie S$$

**Exemple :** Si ÉTUDIANT et INSCRIPTION ont tous deux l'attribut id_etudiant

$$\text{ÉTUDIANT} \bowtie \text{INSCRIPTION}$$

Le résultat est identique à l'équi-jointure mais avec une seule colonne id_etudiant.

### **IV. Jointures externes**

**Définition :** Conservent les tuples qui n'ont pas de correspondance dans l'autre relation.

**Types :**
- **Jointure externe gauche (⟕)** : conserve tous les tuples de la relation gauche
- **Jointure externe droite (⟖)** : conserve tous les tuples de la relation droite
- **Jointure externe complète (⟗)** : conserve tous les tuples des deux relations

**Exemple de jointure externe gauche :**

$$\text{ÉTUDIANT} \, ⟕ \, \text{INSCRIPTION}$$

Conserve tous les étudiants, même ceux sans inscription (avec NULL pour les attributs manquants).

---

## **H. DIVISION (÷)**

**Définition :** La division répond aux requêtes de type "tous les X qui sont en relation avec **tous** les Y".

**Notation :** $$R \div S$$

**Condition :** Les attributs de S doivent être inclus dans ceux de R.

**Exemple :** Trouver les étudiants inscrits à TOUS les cours

```
INSCRIPTION                         COURS (id_cours seulement)
┌─────────────┬──────────┐         ┌──────────┐
│ id_etudiant │ id_cours │         │ id_cours │
├─────────────┼──────────┤         ├──────────┤
│     1001    │    C1    │         │    C1    │
│     1001    │    C2    │         │    C2    │
│     1001    │    C3    │         │    C3    │
│     1002    │    C1    │         └──────────┘
│     1002    │    C2    │
│     1003    │    C1    │
└─────────────┴──────────┘
```

$$\text{INSCRIPTION} \div \text{COURS}$$

**Résultat :**
```
┌─────────────┐
│ id_etudiant │
├─────────────┤
│     1001    │  ← Inscrit à C1, C2 et C3 (tous les cours)
└─────────────┘
```

---

## **I. EXEMPLE COMPLET DE REQUÊTE COMPLEXE**

**Question :** Trouver les noms des étudiants parisiens ayant une note supérieure à 15.

**Décomposition étape par étape :**

**Étape 1 :** Sélectionner les étudiants parisiens
$$R1 = \sigma_{\text{ville='Paris'}}(\text{ÉTUDIANT})$$

**Étape 2 :** Sélectionner les inscriptions avec note > 15
$$R2 = \sigma_{\text{note} > 15}(\text{INSCRIPTION})$$

**Étape 3 :** Joindre les deux résultats
$$R3 = R1 \bowtie_{\text{id\_etudiant}} R2$$

**Étape 4 :** Projeter sur les noms
$$R4 = \pi_{\text{nom}}(R3)$$

**Expression complète :**
$$\pi_{\text{nom}}(\sigma_{\text{ville='Paris'}}(\text{ÉTUDIANT}) \bowtie_{\text{id\_etudiant}} \sigma_{\text{note} > 15}(\text{INSCRIPTION}))$$

---

## **J. PROPRIÉTÉS DES OPÉRATIONS**

### **I. Commutativité**

**Opérations commutatives :**
- $$R \cup S = S \cup R$$
- $$R \cap S = S \cap R$$
- $$R \times S = S \times R$$ (à l'ordre des attributs près)
- $$R \bowtie S = S \bowtie R$$

**Opérations non commutatives :**
- $$R - S \neq S - R$$
- $$R \div S \neq S \div R$$

### **II. Associativité**

- $$R \cup (S \cup T) = (R \cup S) \cup T$$
- $$R \cap (S \cap T) = (R \cap S) \cap T$$
- $$R \bowtie (S \bowtie T) = (R \bowtie S) \bowtie T$$

### **III. Distributivité**

La sélection est distributive sur l'union :
$$\sigma_{\theta}(R \cup S) = \sigma_{\theta}(R) \cup \sigma_{\theta}(S)$$

La projection est distributive sur l'union :
$$\pi_{A}(R \cup S) = \pi_{A}(R) \cup \pi_{A}(S)$$

---

## **K. SYNTHÈSE DES OPÉRATIONS**

```
╔═══════════════════════════════════════════════════════════════╗
║                SYNTHÈSE DES OPÉRATIONS                        ║
╠═══════════════════════════════════════════════════════════════╣
║                                                               ║
║  OPÉRATIONS UNAIRES :                                         ║
║    • Sélection (σ)     → Filtre les lignes                   ║
║    • Projection (π)    → Sélectionne les colonnes            ║
║    • Renommage (ρ)     → Renomme relation/attributs          ║
║                                                               ║
║  OPÉRATIONS BINAIRES :                                        ║
║    • Union (∪)         → Combine sans doublons               ║
║    • Intersection (∩)  → Éléments communs                    ║
║    • Différence (−)    → Éléments de R1 pas dans R2          ║
║    • Produit cart. (×) → Toutes les combinaisons             ║
║    • Jointure (⋈)      → Combine selon une condition         ║
║    • Division (÷)      → Requêtes "pour tous"                ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
```

### **Correspondance avec SQL**

| **Algèbre Relationnelle** | **SQL** |
|---------------------------|---------|
| Sélection (σ) | WHERE |
| Projection (π) | SELECT |
| Union (∪) | UNION |
| Intersection (∩) | INTERSECT |
| Différence (−) | EXCEPT / MINUS |
| Produit cartésien (×) | FROM table1, table2 |
| Jointure (⋈) | JOIN ... ON |
| Division (÷) | NOT EXISTS (imbriqués) |

---

## **L. RÈGLES D'OPTIMISATION**

### **I. Principes généraux**

**Règle 1 :** Effectuer les sélections le plus tôt possible pour réduire la taille des relations intermédiaires.

**Règle 2 :** Effectuer les projections tôt pour réduire le nombre d'attributs.

**Règle 3 :** Remplacer les produits cartésiens suivis de sélections par des jointures.

**Règle 4 :** Regrouper les opérations de même type.

### **II. Exemple d'optimisation**

**Requête non optimisée :**
$$\sigma_{\text{ville='Paris'}}(\text{ÉTUDIANT} \times \text{INSCRIPTION})$$

**Requête optimisée :**
$$\sigma_{\text{ville='Paris'}}(\text{ÉTUDIANT}) \bowtie \text{INSCRIPTION}$$

**Avantage :** Réduction significative du nombre de tuples avant la jointure.

---

## **M. CONCLUSION**

L'algèbre relationnelle constitue le socle théorique indispensable à la compréhension et à la maîtrise des bases de données relationnelles. Elle fournit :

- Un **cadre formel** pour la manipulation des données
- Les **fondements mathématiques** du langage SQL
- Les **bases de l'optimisation** des requêtes
- Une **approche systématique** pour résoudre des problèmes complexes

**Points clés à retenir :**

- Les huit opérations fondamentales permettent d'exprimer toute requête
- La propriété de fermeture autorise la composition d'opérations
- L'optimisation repose sur les propriétés mathématiques des opérations
- Chaque opération d'algèbre relationnelle a son équivalent en SQL

La maîtrise de l'algèbre relationnelle est essentielle pour :
- Comprendre le fonctionnement interne des SGBD
- Écrire des requêtes SQL efficaces
- Optimiser les performances des bases de données
- Concevoir des algorithmes de traitement de données
