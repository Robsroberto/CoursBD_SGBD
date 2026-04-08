

#### **I. Modèle Conceptuel de Données (MCD) à compléter en MLD**  

**Contexte :**  
Une entreprise spécialisée dans les formations en ligne souhaite structurer son système d'information pour mieux gérer ses cours, ses apprenants et ses formateurs. La base de données devra permettre de stocker les informations relatives aux formations, suivre les inscriptions des apprenants, et enregistrer les évaluations. Voici les règles de gestion à respecter :  

1. **Gestion des Apprenants :**  
   - Chaque apprenant est identifié par un identifiant unique.  
   - Un apprenant possède un nom, un prénom, un email unique et un numéro de téléphone.  
   - Un apprenant peut s’inscrire à plusieurs cours.  

2. **Gestion des Formateurs :**  
   - Chaque formateur est identifié par un identifiant unique.  
   - Un formateur possède un nom, un prénom et une spécialité.  
   - Un formateur peut enseigner plusieurs cours, mais chaque cours a un seul formateur responsable.  

3. **Gestion des Cours :**  
   - Chaque cours est identifié par un identifiant unique.  
   - Un cours a un titre, une description et une durée (exprimée en heures).  
   - Chaque cours est animé par un formateur.  

4. **Gestion des Inscriptions :**  
   - Une inscription est un enregistrement qui associe un apprenant à un cours.  
   - Une inscription est datée (date d'inscription).  
   - Un apprenant peut s’inscrire à plusieurs cours, et un cours peut avoir plusieurs apprenants inscrits.  
   - Une même inscription ne peut pas être dupliquée pour un même apprenant dans un même cours.  

5. **Gestion des Évaluations :**  
   - Une évaluation est attribuée par un formateur à un apprenant pour un cours donné.  
   - Une évaluation contient une note (sur 20) et un commentaire.  
   - Un apprenant peut être évalué plusieurs fois pour un même cours, mais seule la dernière évaluation est considérée comme valide. 

### **Modèle Conceptuel de Données (MCD)**  

Sur la base de ces règles, voici un **MCD simplifié** :  
 
- **Apprenant** (*id_apprenant*, nom, prénom, email, téléphone)  
- **Formateur** (*id_formateur*, nom, prénom, spécialité)  
- **Cours** (*id_cours*, titre, description, durée, id_formateur)  
- **Inscription** (*id_inscription*, date_inscription, id_apprenant, id_cours)  
- **Évaluation** (*id_evaluation*, note, commentaire, id_apprenant, id_cours)  

**Travail demandé :**  
1. Complétez ce MCD en le transformant en **Modèle Logique de Données (MLD)** en définissant les relations et les clés étrangères.  
2. Assurez-vous que le schéma relationnel respecte les formes normales (3FN minimum).  

---

#### **II. Questions en Algèbre Relationnelle**  

1. Sélectionner tous les apprenants inscrits à un cours de Python.
2. Trouver les formateurs qui enseignent plus de 3 cours.  
3. Afficher les cours qui ont reçu au moins une évaluation avec une note inférieure à 10.  
4. Sélectionner les inscriptions faites après le 1er janvier 2024.  
5. Lister les noms des formateurs et les titres des cours qu'ils enseignent.  
6. Trouver les apprenants qui ne sont inscrits à aucun cours.  
7. Afficher la moyenne des notes attribuées pour chaque cours.  
8. Sélectionner les cours qui n’ont pas encore d’évaluations.  
9. Trouver les cours suivis par un apprenant spécifique (en fonction de son ID).  
10. Afficher les formateurs qui ont au moins un cours avec une moyenne de notes supérieure à 15.  

---

#### **III. Questions en SQL**  

1. Créer les tables en respectant le MLD complété.  
2. Insérer des données fictives dans chaque table.  
3. Sélectionner tous les apprenants et leurs inscriptions.  
4. Trouver les cours suivis par un apprenant donné.  
5. Lister les formateurs et le nombre de cours qu’ils enseignent.  
6. Afficher les cours dont la durée dépasse 10 heures.  
7. Calculer la moyenne des notes par cours.  
8. Afficher les apprenants avec leur meilleure note.  
9. Trouver les cours qui ont reçu des évaluations avec des commentaires.  
10. Mettre à jour l'email d’un apprenant spécifique.  
11. Supprimer un formateur qui n’a plus de cours actifs.  
12. Sélectionner les apprenants qui sont inscrits à plus de 2 cours.  
13. Afficher les apprenants avec le nombre total de cours suivis.  
14. Trouver le formateur ayant donné le cours le mieux noté en moyenne.  
15. Sélectionner les apprenants qui ont une note moyenne inférieure à 10 sur l’ensemble de leurs cours.  


 **Barème indicatif :**  
- Modélisation (MCD → MLD) : **5 points**  
- Algèbre relationnelle : **7 points**  
- Requêtes SQL : **8 points**  

<!-- 
### **Sujet de Devoir : Modélisation et Manipulation d’une Base de Données en SGBD Avancé**  

---

## **I. Modélisation Conceptuelle et Logique de Données**  

### **Contexte et Règles de Gestion**  

Une entreprise spécialisée dans les formations en ligne souhaite structurer son système d'information pour mieux gérer ses cours, ses apprenants et ses formateurs. La base de données devra permettre de stocker les informations relatives aux formations, suivre les inscriptions des apprenants, et enregistrer les évaluations. Voici les règles de gestion à respecter :  

1. **Gestion des Apprenants :**  
   - Chaque apprenant est identifié par un identifiant unique.  
   - Un apprenant possède un nom, un prénom, un email unique et un numéro de téléphone.  
   - Un apprenant peut s’inscrire à plusieurs cours.  

2. **Gestion des Formateurs :**  
   - Chaque formateur est identifié par un identifiant unique.  
   - Un formateur possède un nom, un prénom et une spécialité.  
   - Un formateur peut enseigner plusieurs cours, mais chaque cours a un seul formateur responsable.  

3. **Gestion des Cours :**  
   - Chaque cours est identifié par un identifiant unique.  
   - Un cours a un titre, une description et une durée (exprimée en heures).  
   - Chaque cours est animé par un formateur.  

4. **Gestion des Inscriptions :**  
   - Une inscription est un enregistrement qui associe un apprenant à un cours.  
   - Une inscription est datée (date d'inscription).  
   - Un apprenant peut s’inscrire à plusieurs cours, et un cours peut avoir plusieurs apprenants inscrits.  
   - Une même inscription ne peut pas être dupliquée pour un même apprenant dans un même cours.  

5. **Gestion des Évaluations :**  
   - Une évaluation est attribuée par un formateur à un apprenant pour un cours donné.  
   - Une évaluation contient une note (sur 20) et un commentaire.  
   - Un apprenant peut être évalué plusieurs fois pour un même cours, mais seule la dernière évaluation est considérée comme valide.  

### **Modèle Conceptuel de Données (MCD)**  

Sur la base de ces règles, voici un **MCD simplifié** :  

#### **Entités principales :**  
- **Apprenant** (*id_apprenant*, nom, prénom, email, téléphone)  
- **Formateur** (*id_formateur*, nom, prénom, spécialité)  
- **Cours** (*id_cours*, titre, description, durée, id_formateur)  
- **Inscription** (*id_inscription*, date_inscription, id_apprenant, id_cours)  
- **Évaluation** (*id_evaluation*, note, commentaire, id_apprenant, id_cours)  

#### **Relations et Clés Étrangères :**  
- `id_formateur` dans **Cours** → Clé étrangère pointant vers **Formateur**.  
- `id_apprenant` et `id_cours` dans **Inscription** → Clés étrangères pointant respectivement vers **Apprenant** et **Cours**.  
- `id_apprenant` et `id_cours` dans **Évaluation** → Clés étrangères pointant respectivement vers **Apprenant** et **Cours**.  

💡 **Remarque :** L'association **Inscription** devient une entité, car elle contient un attribut propre (`date_inscription`).  

---

## **II. Modèle Logique de Données (MLD)**  

Sur la base du MCD, nous obtenons le **schéma relationnel suivant :**  

```sql
-- Table des Apprenants
CREATE TABLE Apprenant (
    id_apprenant INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telephone VARCHAR(20) NOT NULL
);

-- Table des Formateurs
CREATE TABLE Formateur (
    id_formateur INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    specialite VARCHAR(100) NOT NULL
);

-- Table des Cours
CREATE TABLE Cours (
    id_cours INT PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    duree INT NOT NULL,
    id_formateur INT NOT NULL,
    FOREIGN KEY (id_formateur) REFERENCES Formateur(id_formateur) ON DELETE CASCADE
);

-- Table des Inscriptions (relation entre Apprenant et Cours)
CREATE TABLE Inscription (
    id_inscription INT PRIMARY KEY AUTO_INCREMENT,
    date_inscription DATE NOT NULL,
    id_apprenant INT NOT NULL,
    id_cours INT NOT NULL,
    FOREIGN KEY (id_apprenant) REFERENCES Apprenant(id_apprenant) ON DELETE CASCADE,
    FOREIGN KEY (id_cours) REFERENCES Cours(id_cours) ON DELETE CASCADE,
    UNIQUE (id_apprenant, id_cours) -- Un même apprenant ne peut s'inscrire deux fois au même cours
);

-- Table des Évaluations
CREATE TABLE Evaluation (
    id_evaluation INT PRIMARY KEY AUTO_INCREMENT,
    note DECIMAL(5,2) CHECK (note BETWEEN 0 AND 20),
    commentaire TEXT,
    id_apprenant INT NOT NULL,
    id_cours INT NOT NULL,
    FOREIGN KEY (id_apprenant) REFERENCES Apprenant(id_apprenant) ON DELETE CASCADE,
    FOREIGN KEY (id_cours) REFERENCES Cours(id_cours) ON DELETE CASCADE
);
```

---

## **III. Questions en Algèbre Relationnelle (10 Questions)**  

1. Sélectionner tous les apprenants inscrits à un cours donné.  
2. Trouver les formateurs qui enseignent plus de 3 cours.  
3. Afficher les cours ayant au moins une évaluation avec une note inférieure à 10.  
4. Sélectionner les inscriptions faites après le 1er janvier 2024.  
5. Lister les noms des formateurs et les titres des cours qu'ils enseignent.  
6. Trouver les apprenants qui ne sont inscrits à aucun cours.  
7. Afficher la moyenne des notes attribuées pour chaque cours.  
8. Sélectionner les cours qui n’ont pas encore d’évaluations.  
9. Trouver les cours suivis par un apprenant spécifique (en fonction de son ID).  
10. Afficher les formateurs qui ont au moins un cours avec une moyenne de notes supérieure à 15.  

---

## **IV. Questions en SQL (15 Questions)**  

1. Insérer des données fictives dans chaque table.  
2. Sélectionner tous les apprenants et leurs inscriptions.  
3. Trouver les cours suivis par un apprenant donné.  
4. Lister les formateurs et le nombre de cours qu’ils enseignent.  
5. Afficher les cours dont la durée dépasse 10 heures.  
6. Calculer la moyenne des notes par cours.  
7. Afficher les apprenants avec leur meilleure note.  
8. Trouver les cours qui ont reçu des évaluations avec des commentaires.  
9. Mettre à jour l'email d’un apprenant spécifique.  
10. Supprimer un formateur qui n’a plus de cours actifs.  
11. Sélectionner les apprenants qui sont inscrits à plus de 2 cours.  
12. Afficher les apprenants avec le nombre total de cours suivis.  
13. Trouver le formateur ayant donné le cours le mieux noté en moyenne.  
14. Sélectionner les apprenants qui ont une note moyenne inférieure à 10 sur l’ensemble de leurs cours.  
15. Trier les cours du plus suivi au moins suivi.  

---

## **Barème indicatif :**  
- **Modélisation (MCD → MLD) :** **10 points**  
- **Algèbre relationnelle :** **10 points**  
- **Requêtes SQL :** **15 points**  

📌 **Objectif :** Tester la capacité à structurer une base de données et à manipuler des données efficacement en SGBD.  

---

Dis-moi si tu veux des ajustements ! 🚀

 -->

