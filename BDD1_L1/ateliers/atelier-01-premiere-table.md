<div class="bandeau"><img src="../images/bandeau-sql.png" alt="SQL" /></div>

# Atelier 1 : installer son SGBD et créer la table des médecins

<p class="auteur">Par <strong>Robert DIASSÉ</strong>, Ingénieur Logiciel et Data</p>

> **Cours** : Base de données 1, fondements, modélisation et SQL · **Chapitre** : 1, Fondamentaux des bases de données et des SGBD · **Version** : 2026-10-31

## Avant de commencer

| | |
|---|---|
| **Ce que vous allez construire** | Votre environnement de travail (un SGBD et un outil pour lui parler), la base `clinique`, et sa première table, celle des médecins, remplie et interrogée |
| **Durée** | 🟢 Débutant : 4 h · 🔵 Standard : 3 h · 🟣 Expert : 2 h (sans les défis) |
| **Prérequis** | Avoir lu le chapitre 1 |
| **Fichiers fournis** | Aucun |
| **Rendu** | Le fichier `atelier1.sql` (toutes vos instructions, dans l'ordre) et une capture d'écran du résultat de l'étape 5, déposés à l'endroit indiqué par votre enseignant |

A la fin, votre table `medecin` contient ceci :

```text
 id_medecin | nom  |  prenom  |    specialite     |  telephone   | date_embauche
------------+------+----------+-------------------+--------------+---------------
          1 | Ba   | Mamadou  | Médecine générale | 77 100 20 30 | 2015-09-01
          2 | Faye | Aminata  | Pédiatrie         | 78 200 30 40 | 2019-01-15
          3 | Sow  | Ibrahima | Cardiologie       |              | 2021-03-10
          4 | Kane | Ndeye    | Pédiatrie         | 76 300 40 50 | 2023-10-02
```

> 📍 **Point de départ : un nouveau projet.** Vous créez la base de la clinique Santé Plus. Elle grandira à chaque atelier.
>
> **La suite du fil rouge** : atelier 1 (ce travail) → atelier 2 (le modèle complet de la clinique : patients, médecins, consultations, services...) → atelier 3 (la base complète, créée en SQL) → atelier 4 (les requêtes de la clinique).

### Comment travailler

L'atelier est découpé en **7 étapes** (0 à 6). Chaque étape a un objectif, des choses à faire, à chercher, à comprendre, et une vérification. **Tapez** les instructions vous-même, ne les copiez-collez pas : c'est en tapant qu'on apprend la syntaxe.

**Deux règles pour tout l'atelier**

1. **Gardez toutes vos instructions** dans un fichier texte `atelier1.sql` (Bloc-notes, VS Code...), dans l'ordre où vous les exécutez. C'est votre rendu.
2. **Lisez chaque message d'erreur** avant de corriger : la plupart disent exactement ce qui ne va pas.

---

## Étape 0 : choisir sa voie (10 min)

🎯 **Objectif** : savoir sur quel SGBD vous allez travailler tout le semestre.

🛠️ **A faire**

1. Avec votre enseignant, choisissez **une** voie parmi les trois du chapitre (section « Trois façons de travailler ») : MySQL (ou MariaDB), PostgreSQL ou Oracle.
2. Notez votre choix en première ligne de `atelier1.sql`, en commentaire : `-- Voie choisie : PostgreSQL` (en SQL, tout ce qui suit `--` sur une ligne est un **commentaire**, ignoré par le SGBD).

💡 **A comprendre**

- Pourquoi est-il important de garder le même SGBD tout le semestre ?

✅ **Vérification** : `atelier1.sql` existe et commence par votre commentaire.

---

## Étape 1 : installer (ou ouvrir) son SGBD (45 min)

🎯 **Objectif** : avoir un SGBD qui fonctionne, et un outil pour lui envoyer du SQL.

🛠️ **A faire** (selon votre voie)

- **Voie MySQL, avec XAMPP** : installez XAMPP, ouvrez le *XAMPP Control Panel*, démarrez le module **MySQL** (XAMPP fournit MariaDB, compatible MySQL), puis ouvrez phpMyAdmin (bouton **Admin** de la ligne MySQL) et son onglet **SQL**.
- **Voie MySQL, avec MySQL Community Server** : installez MySQL Server et **MySQL Workbench** ; notez le mot de passe de l'utilisateur `root` choisi pendant l'installation ; dans Workbench, ouvrez la connexion locale, puis un onglet de requête.
- **Voie PostgreSQL** : installez PostgreSQL (l'installateur propose aussi **pgAdmin**) ; notez le mot de passe de l'utilisateur `postgres` ; dans pgAdmin, ouvrez le serveur local, puis **Query Tool** (outil de requête).
- **Voie Oracle** : ouvrez https://freesql.com, connectez-vous avec un compte oracle.com (gratuit), puis ouvrez la feuille SQL (*worksheet*). Si votre école vous a ouvert un accès à Oracle Autonomous Database, utilisez plutôt **Database Actions > SQL**.

🔎 **A chercher** : « installer XAMPP Windows », « installer PostgreSQL Windows pgAdmin », « FreeSQL Oracle ». Prenez les liens des **sites officiels** (apachefriends.org, mysql.com, postgresql.org, freesql.com).

💡 **A comprendre**

- Dans votre installation, qui est le **client** et qui est le **serveur** (chapitre 1, section 5.2) ? Sont-ils sur la même machine ?
- Pourquoi ne faut-il **jamais** perdre le mot de passe de `root` ou de `postgres` ?

✅ **Vérification** : dans votre outil, la requête `SELECT 1 + 1;` affiche `2`.

<details><summary>Indice : le module MySQL de XAMPP ne démarre pas</summary>

Le plus souvent, le port 3306 est déjà utilisé par une autre installation de MySQL. Le panneau de XAMPP l'indique en rouge dans son journal. Arrêtez l'autre service MySQL (ou changez le port de XAMPP dans **Config > my.ini**), puis relancez.

</details>

---

## Étape 2 : créer la base `clinique` (15 min)

🎯 **Objectif** : un espace à vous, où ranger les tables de la clinique.

🛠️ **A faire**

- **MySQL** : exécutez `CREATE DATABASE clinique;` puis `USE clinique;` (dans phpMyAdmin ou Workbench, vous pouvez aussi cliquer sur la base dans la liste de gauche pour la choisir).
- **PostgreSQL** : exécutez `CREATE DATABASE clinique;` ; puis, dans pgAdmin, faites un clic droit sur la nouvelle base `clinique` (actualisez la liste si besoin) et ouvrez **Query Tool** **sur cette base**.
- **Oracle** : rien à faire. Votre compte a déjà son propre **schéma** : vos tables y seront créées.

💡 **A comprendre**

- Que se passerait-il si vous oubliiez le `USE clinique;` (MySQL), ou si vous ouvriez l'outil de requête sur la base `postgres` (PostgreSQL), avant de créer vos tables ?

✅ **Vérification** : la base `clinique` apparaît dans la liste de gauche de votre outil (sauf voie Oracle).

---

## Étape 3 : créer la table `medecin` (30 min)

🎯 **Objectif** : écrire votre premier `CREATE TABLE`.

🛠️ **A faire**

Créez la table `medecin` avec ces six colonnes :

| Colonne | Contenu | Type | Règle |
|---|---|---|---|
| `id_medecin` | numéro du médecin | nombre entier | clé primaire |
| `nom` | nom de famille | texte, 50 caractères au plus | obligatoire |
| `prenom` | prénom | texte, 50 caractères au plus | obligatoire |
| `specialite` | spécialité | texte, 40 caractères au plus | obligatoire |
| `telephone` | numéro de téléphone | texte, 20 caractères au plus | facultatif |
| `date_embauche` | date d'arrivée à la clinique | date | facultatif |

🔎 **A chercher** : chapitre 1, section 7.2 (la table `patient`).

💡 **A comprendre**

- Pourquoi le téléphone est-il du **texte** et pas un nombre ? (Pensez aux espaces, au `+221`, et à un numéro qui commence par 0.)
- Pourquoi `telephone` et `date_embauche` ne sont-elles pas `NOT NULL` ?

✅ **Vérification** : le `CREATE TABLE` s'exécute sans erreur, et la table `medecin` apparaît dans la liste de votre outil (actualisez si besoin).

<details><summary>Indice : la forme générale</summary>

```sql
CREATE TABLE nom_de_table (
    colonne1 TYPE contrainte,
    colonne2 TYPE contrainte,
    colonne3 TYPE
);
```

Une virgule **entre** les colonnes, aucune après la dernière.

</details>

---

## Étape 4 : remplir la table (25 min)

🎯 **Objectif** : insérer les quatre médecins de la clinique.

🛠️ **A faire**

1. Insérez les quatre médecins de l'aperçu (en début d'énoncé), avec un `INSERT INTO` par médecin. Le Dr Sow n'a pas encore de téléphone : mettez `NULL`.
2. Essayez ensuite d'insérer un cinquième médecin avec le **numéro 2**, puis un médecin **sans spécialité** (`NULL`). Notez les deux messages d'erreur dans `atelier1.sql`, en commentaires.

🔎 **A chercher** : chapitre 1, sections 7.2 et 7.3.

💡 **A comprendre**

- Quelle contrainte a refusé chacune des deux insertions ? Quelle limite des fichiers (chapitre 1, section 2.2) ces refus vous évitent-ils ?
- `NULL` et `'NULL'` (avec apostrophes) : est-ce la même chose ? (Essayez avec le téléphone d'un médecin de test, puis supprimez-le avec `DELETE FROM medecin WHERE id_medecin = 9;`.)

✅ **Vérification** : `SELECT * FROM medecin;` affiche exactement les quatre lignes de l'aperçu.

---

## Étape 5 : interroger la table (30 min)

🎯 **Objectif** : répondre à des questions de la direction de la clinique.

🛠️ **A faire** : écrivez une requête pour chaque question.

1. Le nom et le prénom des **pédiatres**.
2. Le nom, la spécialité et la date d'embauche des médecins arrivés **après le 1er janvier 2020**.
3. Le nom et le prénom des médecins **sans téléphone**.
4. Une requête de votre choix, qui répond à une question utile à la clinique (écrivez la question en commentaire au-dessus).

🔎 **A chercher** : chapitre 1, section 7.2 (`WHERE`) ; « SQL IS NULL » ; les opérateurs de comparaison `>`, `<`, `>=`, `<=`, `<>`.

💡 **A comprendre**

- Pour la question 3, essayez `WHERE telephone = NULL`. Combien de lignes obtenez-vous ? Pourquoi faut-il écrire `IS NULL` ?
- Pour la question 1, essayez `'pédiatrie'` avec un **p** minuscule. Que se passe-t-il sur votre SGBD ? (Chapitre 1, encadré 🔵 de la section 7.3.)

✅ **Vérification** :

| Question | Résultat attendu |
|---|---|
| 1 | Faye Aminata, Kane Ndeye |
| 2 | Sow (Cardiologie, 2021-03-10), Kane (Pédiatrie, 2023-10-02) |
| 3 | Sow Ibrahima |

Faites la capture d'écran du résultat de la question 2.

---

## Étape 6 : relancer tout le script (15 min)

🎯 **Objectif** : vérifier que votre fichier `atelier1.sql` est **complet** et rejouable.

🛠️ **A faire**

1. Supprimez la table : `DROP TABLE medecin;`.
2. Exécutez **tout** votre fichier `atelier1.sql` d'un coup (en retirant ou en mettant en commentaire les instructions qui provoquent volontairement une erreur, et le `CREATE DATABASE` si la base existe déjà).
3. Vérifiez que vous retrouvez la table et les résultats de l'étape 5.

💡 **A comprendre**

- Pourquoi est-il utile de pouvoir **recréer** une base entière à partir d'un script ? (Pensez à un ordinateur qui tombe en panne la veille du rendu.)

✅ **Vérification** : le script s'exécute de bout en bout sans erreur et redonne les quatre médecins.

---

## 🏆 Défis (facultatifs)

1. **La table des patients.** Ajoutez à votre base la table `patient` du chapitre (section 7.2), avec les trois patients, et une requête qui affiche les patients nés avant 2000.
2. **Deux SGBD.** Exécutez votre `atelier1.sql` sur une **deuxième** voie (par exemple FreeSQL si vous travaillez sur MySQL). Notez ce qui marche tel quel et ce qu'il faut changer.
3. **Le dictionnaire de données.** Cherchez comment afficher la liste des tables et la description d'une table dans votre SGBD (`SHOW TABLES;` et `DESCRIBE medecin;` sur MySQL ; `\dt` et `\d medecin` dans `psql` ; `SELECT table_name FROM user_tables;` sur Oracle). A quel composant du SGBD (chapitre 1, section 3.3) ces informations appartiennent-elles ?
4. **Combien de pédiatres ?** Cherchez « SQL COUNT » et écrivez la requête qui compte les pédiatres (résultat : 2).

---

## Grille d'autoévaluation

| Je sais... | Oui | Pas encore |
|---|---|---|
| dire quel SGBD j'utilise, et qui est le client et le serveur dans mon installation | ☐ | ☐ |
| créer une base (MySQL, PostgreSQL) et choisir dans quelle base je travaille | ☐ | ☐ |
| écrire un `CREATE TABLE` avec des types, une clé primaire et des colonnes obligatoires | ☐ | ☐ |
| insérer des lignes, y compris avec une valeur `NULL` | ☐ | ☐ |
| écrire un `SELECT` avec une condition `WHERE`, et tester l'absence de valeur avec `IS NULL` | ☐ | ☐ |
| lire un message d'erreur et retrouver la contrainte qui a refusé une insertion | ☐ | ☐ |
| rejouer un script SQL complet | ☐ | ☐ |
