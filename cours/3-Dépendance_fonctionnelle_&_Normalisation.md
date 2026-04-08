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

# **CHAPITRE 3 — DÉPENDANCE FONCTIONNELLE & NORMALISATION**

## Par Robert DIASSÉ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<img src="sql.jpeg" alt="ISI" width="50px">

---

## A. DÉPENDANCES FONCTIONNELLES

### I. Rôle des dépendances fonctionnelles en modélisation

Le modèle conceptuel de données (MCD) ne doit pas seulement représenter la réalité métier, mais garantir une **cohérence logique durable**.
Un MCD apparemment correct peut cacher :

* des **redondances** inutiles ;
* des **incohérences** potentielles ;
* des **anomalies de mise à jour**.

Les dépendances fonctionnelles permettent de **formaliser les règles métier implicites** et de vérifier que chaque information est placée **au bon endroit**.

---

### II. Définition formelle d’une dépendance fonctionnelle

On dit qu’il existe une dépendance fonctionnelle de **A vers B**, notée :

> **A → B**

si, pour une même valeur de A, **une seule valeur de B est possible**.
![alt text](image-7.png)

Il ne s’agit pas d’un calcul, mais d’une **règle de cohérence métier**.

Exemples :

* `num_client → nom_client`
* `num_commande → date_commande`
* `ref_article → designation`
![alt text](df1-1.png)
---

### III. Dépendances fonctionnelles et identifiant

#### 1. Identifiant (clé primaire)

Un identifiant est l’attribut (ou le groupe minimal d’attributs) qui permet d’identifier **une occurrence unique**.

Propriétés :

* unicité ;
* stabilité ;
* minimalité.

#### 2. Propriété fondamentale

Dans une entité correctement construite :

> **Identifiant → tous les autres attributs**

Si un attribut ne dépend pas de l’identifiant :

* il est mal placé,
* ou il dépend d’un autre objet métier.

---

### IV. Types de dépendances fonctionnelles

#### 1. Dépendance élémentaire

* un attribut à gauche ;
* un attribut à droite.

Exemple :

* `num_client → adresse_client`

#### 2. Dépendance composée

Le côté gauche contient plusieurs attributs.
![alt text](image-2-1.png)
Exemple :

* `(num_commande, num_article) → quantite`

La quantité dépend du **couple** commande–article.

---

### V. Dépendances problématiques

#### 1. Dépendance partielle

Elle apparaît lorsqu’un attribut dépend **d’une partie seulement** d’une clé composée.

Exemple :

```
LigneCommande(num_commande, num_article, designation_article, quantite)
```

Or :

```
num_article → designation_article
```

Conséquences :

* répétitions ;
* incohérences ;
* anomalies de mise à jour.

> Problème traité par la **2FN**.

---

#### 2. Dépendance transitive

Elle apparaît lorsque :

```
A → B
B → C
donc A → C
```
![alt text](image-1-1.png)

Exemple :

```
num_voiture → modele
modele → constructeur
```

Conséquences :

* redondance ;
* incohérence possible.

> Problème traité par la **3FN**.

---


### VI. Couverture minimale

#### 1. Définition

La couverture minimale est un **ensemble équivalent de dépendances fonctionnelles**, mais :

* sans redondance ;
* sans attribut inutile ;
* réduit au strict nécessaire.

---

#### 2. Règles de construction

1. Un seul attribut à droite
   `A → BC` devient `A → B` et `A → C`

2. Suppression des dépendances déductibles
   si `A → B` et `B → C`, alors `A → C` est inutile

3. Simplification du côté gauche
   si `(A, D) → B` et `A → B`, alors `D` est inutile

---

#### 3. Graphe de couverture minimale

Le **graphe de couverture minimale** représente **uniquement les dépendances directes essentielles**, issues de la couverture minimale.

 **Il constitue la base obligatoire avant toute normalisation.**
 ![alt text](image-4-1.png)

---
### VI. Graphe des dépendances fonctionnelles

Le graphe des dépendances fonctionnelles représente :

* les attributs (nœuds) ;
* les dépendances A → B (flèches).

Il permet d’identifier :

* les dépendances directes ;
* les dépendances transitives ;
* les zones à problème.


À partir du graphe de couverture minimale, on peut :

* reconstruire le graphe des dépendances fonctionnelles ;
* vérifier l’absence de dépendances dangereuses ;
* préparer la décomposition normalisée.

⚠️ **Seules les dépendances directes nous intéressent** pour la normalisation.


## B. NORMALISATION DES DONNÉES

### I. Objectif de la normalisation

La normalisation vise à obtenir un modèle :

* sans redondance ;
* sans incohérence ;
* logiquement cohérent ;
* stable dans le temps.

Elle s’appuie sur :

* les dépendances fonctionnelles ;
* les cardinalités ;
* la structure des entités et associations.

---

### II. Les 9 règles de normalisation (MERISE)

1. Normalisation des entités
2. Normalisation des identifiants
3. Normalisation des attributs
4. Normalisation des attributs des associations
5. Normalisation des associations
6. Normalisation des cardinalités
7. Première forme normale (1FN)
8. Deuxième forme normale (2FN)
9. Troisième forme normale (3FN)

![alt text](normalisation1-1.png) 
![alt text](normalisation2-1.png)
![alt text](normalisation3-1.png) 

# Règle 1 – Normalisation des entités

![alt text](normalisation5-1.png)

**Principe**
Les entités représentant un même type d’objet réel doivent être **fusionnées**.
![alt text](normalisation6-1.png)
**Explication**
Deux entités sont dites homogènes lorsqu’elles possèdent :

* les mêmes attributs,
* le même identifiant,
* et représentent la même réalité métier.

Dans ce cas, il ne faut pas les séparer artificiellement.
La spécialisation (ex. *Encadrant* et *Salarié*) ne se justifie que s’il existe :

* des attributs spécifiques,
* ou des règles de gestion distinctes.

**Objectif**
Éviter la duplication d’informations et garantir l’unicité de représentation d’un objet métier.

---

# Règle 2 – Normalisation des identifiants

**Principe**
Chaque entité doit posséder **un identifiant unique, stable et minimal**.

**Explication**
L’identifiant permet de distinguer sans ambiguïté chaque occurrence d’une entité.
Il doit :

* identifier une et une seule occurrence ;
* ne pas changer dans le temps ;
* ne contenir aucun attribut inutile.

Un mauvais identifiant entraîne :

* des doublons,
* des incohérences,
* des erreurs de mise à jour.

**Objectif**
Assurer l’unicité et la fiabilité de l’accès aux données.

---

# Règle 3 – Normalisation des attributs

### 3.1 Attributs multivalués ou catégorisés

**Principe**
Un attribut qui peut prendre plusieurs valeurs ou catégories doit être remplacé par :

![alt text](normalisation7-1.png)

* une **entité**,
* et une **association**.

**Explication**
Des attributs comme `adresse_principale`, `adresse_secondaire` ne sont pas extensibles.
Si un enseignant possède plusieurs adresses, le modèle devient incohérent.

La solution consiste à :

* créer une entité **Adresse**,
* qualifier la relation par un attribut (ex. *type_adresse*).

---

### 3.2 Attributs calculables

**Principe**
Un attribut calculable à partir d’autres attributs ne doit pas être stocké.

![alt text](normalisation8-1.png)

**Explication**
Par exemple, `montant_total` peut être calculé à partir de :

* la quantité commandée,
* et le prix unitaire.

Le stocker introduit un risque d’incohérence si les données de base changent.

**Objectif**
Éviter les redondances et garantir la cohérence des valeurs.

---

# Règle 4 – Normalisation des attributs des associations

**Principe**
Lorsqu’une association possède des attributs, ceux-ci doivent être rattachés :

* à l’entité dont la cardinalité maximale est **1**.

![alt text](normalisation9-1.png)

**Explication**
Si une entité participe à une association avec une cardinalité maximale de 1 (1,1 ou 0,1),
cela signifie qu’à chaque occurrence de cette entité correspond **au plus une occurrence** de l’association.

Les attributs de l’association lui sont donc fonctionnellement dépendants.

**Objectif**
Éviter des associations inutiles et simplifier le modèle.

---

# Règle 5 – Normalisation des associations

**Principe**
Les associations dites **fantômes** doivent être éliminées.

![alt text](normalisation10-1.png)

**Explication**
Une association est fantôme lorsque :

* toutes les entités participantes ont une cardinalité (1,1),
* chaque occurrence est liée une et une seule fois.

Dans ce cas, l’association ne porte aucune information propre et peut être supprimée.
Les entités concernées sont alors **fusionnées**.

![alt text](normalisation11-1.png)

**Objectif**
Alléger le MCD et éviter des structures artificielles.

---

# Règle 6 – Normalisation des cardinalités

**Principe**
Les cardinalités doivent rester **générales et évolutives**.

![alt text](normalisation12-1.png)

**Explication**
Même si une règle de gestion impose aujourd’hui une limite (ex. 2 livres maximum),
cette règle peut évoluer dans le temps.

On adopte donc les conventions suivantes :

* cardinalité minimale : **0 ou 1** ;
* cardinalité maximale : **1 ou n**.

Une cardinalité maximale à 0 n’a pas de sens.

**Objectif**
Garantir la pérennité du modèle face à l’évolution des règles métier.


> Les règles **7, 8 et 9** sont les **formes normales**, mais elles **reposent sur les règles 1 à 6**.

---

### III. Formes normales

#### 1. Première forme normale (1FN)

* attributs atomiques ;
* aucune liste ;
* aucune valeur multiple.
![alt text](FN1.1-1.png)
![alt text](FN1-1.png)

#### 2. Deuxième forme normale (2FN)

* être en 1FN ;
* aucun attribut ne dépend partiellement d’une clé composée.

![alt text](FN2-1.png)

#### 3. Troisième forme normale (3FN)

* être en 2FN ;
* aucune dépendance transitive.

![alt text](FN3-1.png)

---

### IV. MCD normalisé

Un MCD normalisé respecte :

* les 9 règles ;
* toutes les DF directes ;
* aucune dépendance partielle ;
* aucune dépendance transitive ;
* des associations justifiées ;
* des cardinalités réalistes.

>Le MCD obtenu est **cohérent**, **stable** et **prêt pour le passage en MLD**.

---

## Conclusion

La normalisation n’est pas une suite de règles mécaniques, mais le **résultat logique** :

1. de l’analyse des dépendances fonctionnelles ;
2. de leur simplification (couverture minimale) ;
3. de leur traduction structurée en entités et associations.

---
