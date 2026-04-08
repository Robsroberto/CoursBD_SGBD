# SOLUTIONS COMPLÈTES — DÉPENDANCES FONCTIONNELLES, MCD ET MLD

## **MÉTHODOLOGIE GÉNÉRALE**

Pour chaque exercice, nous suivons la démarche systématique suivante :

1. **Identification des Dépendances Fonctionnelles (DF)**
2. **Construction du graphe et de la couverture minimale**  
3. **Conception du MCD normalisé**
4. **Transformation en MLD avec contraintes d'intégrité**

**Conventions de notation :**
- **#** = Clé primaire
- **→** = Référence de clé étrangère
- **CP** = Clé Primaire, **CE** = Clé Étrangère

---

## **EXERCICE 1 — GESTION SIMPLE D'UNE BIBLIOTHÈQUE**

### **Étape 1 : Dépendances Fonctionnelles**

```
DF1 : ISBN → titre, annee_publication, nom_editeur, code_auteur
DF2 : code_auteur → nom_auteur, prenom_auteur  
DF3 : num_carte → nom_adherent, prenom_adherent, ville
DF4 : (num_carte, ISBN, date_emprunt) → (identifie un emprunt unique)
```

**Remarque :** `date_retour_prevue` est calculable (date_emprunt + 15 jours) → attribut dérivé à ne pas stocker.

### **Étape 2 : Graphe des DF et normalisation**

**Dépendance transitive détectée :**
$$\text{ISBN} \rightarrow \text{code\_auteur} \rightarrow \text{nom\_auteur, prenom\_auteur}$$

**Solution :** Créer une entité AUTEUR séparée pour respecter la 3FN.

### **Étape 3 : MCD normalisé**

```
┌─────────────┐    1,n     ┌──────────────┐    0,n     ┌─────────────┐
│   AUTEUR    │ ─────── │     LIVRE      │ ─────── │  ADHÉRENT   │
├─────────────┤  Écrit   ├──────────────┤ Emprunte ├─────────────┤
│ code_auteur │          │ ISBN          │ (date)   │ num_carte   │
│ nom         │          │ titre         │          │ nom         │
│ prenom      │          │ annee_pub     │          │ prenom      │
└─────────────┘          │ nom_editeur   │          │ ville       │
                         └──────────────┘          └─────────────┘
```

### **Étape 4 : MLD**

```
AUTEUR(#code_auteur, nom, prenom)

LIVRE(#ISBN, titre, annee_publication, nom_editeur, code_auteur)
  avec : code_auteur → AUTEUR.code_auteur

ADHÉRENT(#num_carte, nom, prenom, ville)

EMPRUNT(#num_carte, #ISBN, #date_emprunt)
  avec : num_carte → ADHÉRENT.num_carte
         ISBN → LIVRE.ISBN
```

**Contraintes d'intégrité :**
- Intégrité référentielle : toutes les CE référencent des CP existantes
- Domaine : annee_publication ≤ YEAR(CURRENT_DATE)

---

## **EXERCICE 2 — SYSTÈME DE COMMANDES CLIENT**

### **Étape 1 : Dépendances Fonctionnelles**

```
DF1 : code_client → nom, prenom, adresse, telephone
DF2 : num_commande → date_commande, code_client
DF3 : ref_article → designation, prix_catalogue, categorie  
DF4 : (num_commande, ref_article) → quantite, prix_applique
```

### **Étape 2 : Normalisation**

**Dépendance transitive :**
$$\text{num\_commande} \rightarrow \text{code\_client} \rightarrow \text{attributs\_client}$$

### **Étape 3 : MCD normalisé**

```
┌─────────────┐    1,n     ┌─────────────┐    1,n     ┌─────────────┐
│   CLIENT    │ ─────── │  COMMANDE   │ ─────── │   ARTICLE   │
├─────────────┤  Passe   ├─────────────┤ Contient ├─────────────┤
│ code_client │          │num_commande │ (quantite│ ref_article │
│ nom         │          │date_commande│ prix_app)│ designation │
│ prenom      │          └─────────────┘          │ prix_cat    │
│ adresse     │                                   │ categorie   │
│ telephone   │                                   └─────────────┘
└─────────────┘
```

### **Étape 4 : MLD**

```
CLIENT(#code_client, nom, prenom, adresse, telephone)

COMMANDE(#num_commande, date_commande, code_client)
  avec : code_client → CLIENT.code_client

ARTICLE(#ref_article, designation, prix_catalogue, categorie)

LIGNE_COMMANDE(#num_commande, #ref_article, quantite, prix_applique)
  avec : num_commande → COMMANDE.num_commande
         ref_article → ARTICLE.ref_article
```

**Contraintes spécifiques :**
- `prix_applique` peut différer de `prix_catalogue` (promotions)
- `quantite > 0`

---

## **EXERCICE 3 — CLUB SPORTIF MULTIDISCIPLINAIRE**

### **Étape 1 : Dépendances Fonctionnelles**

```
DF1 : num_licence → nom, prenom, date_naissance, adresse
DF2 : code_sport → libelle, tarif_annuel
DF3 : matricule → nom, prenom, telephone, specialite, id_lieu
DF4 : id_lieu → nom_gymnase, adresse, capacite
DF5 : (num_licence, code_sport) → niveau, date_inscription
DF6 : (matricule, code_sport) → (encadrement)
```

### **Étape 2 : Normalisation**

**Dépendance transitive :**
$$\text{matricule} \rightarrow \text{id\_lieu} \rightarrow \text{attributs\_lieu}$$

### **Étape 3 : MCD normalisé**

```
┌─────────────┐         ┌─────────────┐         ┌─────────────┐
│  ADHÉRENT   │   n,n   │    SPORT    │   n,n   │ ENTRAÎNEUR  │
├─────────────┤ ─────── ├─────────────┤ ─────── ├─────────────┤
│ num_licence │S'inscrit│ code_sport  │ Encadre │ matricule   │
│ nom         │(niveau, │ libelle     │         │ nom         │
│ prenom      │ date)   │ tarif       │         │ prenom      │
│ date_naiss  │         └─────────────┘         │ telephone   │
│ adresse     │                                 │ specialite  │
└─────────────┘                                 └─────────────┘
                                                       │ n,1
                                                   Rattaché
                                                       │ 1,1
                                                ┌─────────────┐
                                                │    LIEU     │
                                                ├─────────────┤
                                                │ id_lieu     │
                                                │ nom_gymnase │
                                                │ adresse     │
                                                │ capacite    │
                                                └─────────────┘
```

### **Étape 4 : MLD**

```
LIEU(#id_lieu, nom_gymnase, adresse, capacite)

ENTRAÎNEUR(#matricule, nom, prenom, telephone, specialite, id_lieu)
  avec : id_lieu → LIEU.id_lieu

SPORT(#code_sport, libelle, tarif_annuel)

ADHÉRENT(#num_licence, nom, prenom, date_naissance, adresse)

INSCRIPTION(#num_licence, #code_sport, niveau, date_inscription)
  avec : num_licence → ADHÉRENT.num_licence
         code_sport → SPORT.code_sport

ENCADREMENT(#matricule, #code_sport)
  avec : matricule → ENTRAÎNEUR.matricule
         code_sport → SPORT.code_sport
```

---

## **EXERCICE 4 — GESTION DE PROJETS D'ENTREPRISE**

### **Étape 1 : Dépendances Fonctionnelles**

```
DF1 : matricule → nom, prenom, fonction, salaire, date_embauche, code_dept
DF2 : code_dept → nom_dept, budget_annuel
DF3 : code_projet → titre, date_debut, date_fin_prevue, budget, matricule_chef
DF4 : (matricule, code_projet) → nb_heures, role
```

### **Étape 2 : MCD normalisé**

```
┌─────────────┐    n,1     ┌─────────────┐
│   EMPLOYÉ   │ ─────── │ DÉPARTEMENT │
├─────────────┤Appartient├─────────────┤
│ matricule   │          │ code_dept   │
│ nom         │          │ nom_dept    │
│ prenom      │          │ budget      │
│ fonction    │          └─────────────┘
│ salaire     │
│ date_embau  │
└─────────────┘
       │                  ┌─────────────┐
       │ 0,n              │   PROJET    │
       │ ─────────────── ├─────────────┤
       │    Travaille     │ code_projet │
       │   (nb_heures,    │ titre       │
       │    role)         │ date_debut  │
       │                  │ date_fin    │
       │ 0,n              │ budget      │
       └─────────────────►└─────────────┘
              1,1                ▲
            Dirige               │ 1,1
                                │
                         (Chef de projet)
```

### **Étape 3 : MLD**

```
DÉPARTEMENT(#code_dept, nom_dept, budget_annuel)

EMPLOYÉ(#matricule, nom, prenom, fonction, salaire, date_embauche, code_dept)
  avec : code_dept → DÉPARTEMENT.code_dept

PROJET(#code_projet, titre, date_debut, date_fin_prevue, budget, matricule_chef)
  avec : matricule_chef → EMPLOYÉ.matricule

AFFECTATION(#matricule, #code_projet, nb_heures, role)
  avec : matricule → EMPLOYÉ.matricule
         code_projet → PROJET.code_projet
```

---

## **EXERCICE 5 — AGENCE IMMOBILIÈRE**

### **Étape 1 : Dépendances Fonctionnelles**

```
DF1 : code_proprietaire → nom, prenom, adresse, telephone
DF2 : ref_bien → adresse, superficie, nb_pieces, type, loyer, code_proprietaire
DF3 : num_dossier → nom, prenom, telephone, budget_max, type_recherche
DF4 : (num_dossier, ref_bien, date_visite, heure_visite) → observations
```

### **Étape 2 : MLD**

```
PROPRIÉTAIRE(#code_proprietaire, nom, prenom, adresse, telephone)

BIEN(#ref_bien, adresse, superficie, nb_pieces, type, loyer, code_proprietaire)
  avec : code_proprietaire → PROPRIÉTAIRE.code_proprietaire

LOCATAIRE(#num_dossier, nom, prenom, telephone, budget_max, type_recherche)

VISITE(#num_dossier, #ref_bien, #date_visite, #heure_visite, observations)
  avec : num_dossier → LOCATAIRE.num_dossier
         ref_bien → BIEN.ref_bien
```

**Remarque :** La clé primaire de VISITE inclut date et heure pour permettre plusieurs visites du même bien par le même locataire.

---

## **EXERCICE 6 — COMPAGNIE AÉRIENNE (Association réflexive)**

### **Étape 1 : Particularité**

Association **réflexive** : un VOL relie deux AÉROPORTS (départ et arrivée).

### **Étape 2 : MLD**

```
AÉROPORT(#code_IATA, nom, ville, pays)

AVION(#immatriculation, type, capacite, date_mise_service)

VOL(#num_vol, heure_depart, heure_arrivee, jours_operation,
    code_aeroport_depart, code_aeroport_arrivee)
  avec : code_aeroport_depart → AÉROPORT.code_IATA
         code_aeroport_arrivee → AÉROPORT.code_IATA

AFFECTATION_VOL(#num_vol, #date_vol, immatriculation)
  avec : num_vol → VOL.num_vol
         immatriculation → AVION.immatriculation
```

**Contrainte spéciale :** `code_aeroport_depart ≠ code_aeroport_arrivee`

---

## **EXERCICE 7 — CABINET MÉDICAL**

### **MLD**

```
MÉDECIN(#num_RPPS, nom, prenom, specialite, telephone)

PATIENT(#num_secu, nom, prenom, date_naissance, adresse, telephone)

CONSULTATION(#num_consultation, date, heure, motif, diagnostic, montant,
             num_RPPS, num_secu)
  avec : num_RPPS → MÉDECIN.num_RPPS
         num_secu → PATIENT.num_secu

MÉDICAMENT(#code_CIP, nom_commercial, principe_actif, prix_unitaire)

PRESCRIPTION(#num_consultation, #code_CIP, posologie, duree_traitement, instructions)
  avec : num_consultation → CONSULTATION.num_consultation
         code_CIP → MÉDICAMENT.code_CIP
```

---

## **EXERCICE 8 — GESTION DE STOCK**

### **MLD**

```
CATÉGORIE(#code_categorie, libelle)

PRODUIT(#ref_produit, designation, quantite_stock, prix_vente, code_categorie)
  avec : code_categorie → CATÉGORIE.code_categorie

FOURNISSEUR(#code_fournisseur, raison_sociale, adresse, telephone)

CATALOGUE_FOURNISSEUR(#ref_produit, #code_fournisseur, prix_achat, delai_livraison)
  avec : ref_produit → PRODUIT.ref_produit
         code_fournisseur → FOURNISSEUR.code_fournisseur

COMMANDE_APPRO(#num_commande, date_commande, code_fournisseur)
  avec : code_fournisseur → FOURNISSEUR.code_fournisseur

LIGNE_COMMANDE_APPRO(#num_commande, #ref_produit, quantite_commandee)
  avec : num_commande → COMMANDE_APPRO.num_commande
         ref_produit → PRODUIT.ref_produit
```

---

## **EXERCICE 9 — FESTIVAL DE CINÉMA**

### **MLD**

```
GENRE(#code_genre, libelle)

RÉALISATEUR(#id_realisateur, nom, prenom, nationalite)

FILM(#code_film, titre, duree, annee_production, pays_origine,
     id_realisateur, code_genre)
  avec : id_realisateur → RÉALISATEUR.id_realisateur
         code_genre → GENRE.code_genre

SALLE(#num_salle, nom_salle, capacite, equipement)

PROJECTION(#num_projection, date_projection, heure_projection,
           code_film, num_salle)
  avec : code_film → FILM.code_film
         num_salle → SALLE.num_salle

SPECTATEUR(#num_badge, nom, prenom, categorie)

PARTICIPATION(#num_badge, #num_projection, date_reservation)
  avec : num_badge → SPECTATEUR.num_badge
         num_projection → PROJECTION.num_projection

MEMBRE_JURY(#id_membre, nom, prenom, profession)

NOTATION(#id_membre, #code_film, note, commentaire)
  avec : id_membre → MEMBRE_JURY.id_membre
         code_film → FILM.code_film
```

---

## **EXERCICE 10 — PARC INFORMATIQUE (Historisation)**

### **Particularité : Gestion de l'historique**

Pour gérer l'historique, les **dates** font partie des **clés primaires** des associations.

### **MLD avec historisation**

```
POSTE(#num_serie, marque, modele, date_achat, config_technique)

UTILISATEUR(#matricule, nom, prenom, fonction, service)

BUREAU(#num_bureau, etage, batiment, superficie)

LOGICIEL(#ref_licence, nom_logiciel, version, type_licence, date_expiration)

AFFECTATION_POSTE(#num_serie, #matricule, #date_debut_affect, date_fin_affect)
  avec : num_serie → POSTE.num_serie
         matricule → UTILISATEUR.matricule

LOCALISATION_POSTE(#num_serie, #num_bureau, #date_debut_install, date_fin_install)
  avec : num_serie → POSTE.num_serie
         num_bureau → BUREAU.num_bureau

INSTALLATION_LOGICIEL(#ref_licence, #num_serie, #date_installation,
                      date_desinstallation)
  avec : ref_licence → LOGICIEL.ref_licence
         num_serie → POSTE.num_serie
```

**Contraintes d'historisation :**
- `date_fin_affect IS NULL` → affectation en cours
- Pas de chevauchement de périodes pour un même poste
- Vérification de cohérence temporelle

---

## **CHECKLIST DE VALIDATION**

Pour vérifier la qualité des solutions :

**✓ Structure :**
- Chaque relation a une clé primaire unique
- Toutes les clés étrangères référencent des clés primaires existantes
- Les cardinalités du MCD sont respectées

**✓ Normalisation :**
- 1FN : attributs atomiques
- 2FN : pas de dépendance partielle
- 3FN : pas de dépendance transitive

**✓ Contraintes :**
- Intégrité d'entité (clés primaires uniques et non nulles)
- Intégrité référentielle (cohérence des références)
- Intégrité de domaine (valeurs dans les domaines autorisés)
- Règles métier respectées

Ces solutions respectent rigoureusement les règles de transformation MCD→MLD et garantissent des bases de données cohérentes et normalisées.