## **1. Noms et prénoms des patients ayant consulté un médecin**

```sql
SELECT DISTINCT P.nom, P.prénom
FROM Patient P
JOIN Consultation C ON P.id_patient = C.id_patient;
```

---

## **2. Médecins spécialisés en "Cardiologie"**

```sql
SELECT nom, prénom
FROM Médecin
WHERE spécialité = 'Cardiologie';
```

---

## **3. Patients hospitalisés en "Chirurgie"**

```sql
SELECT DISTINCT P.nom, P.prénom
FROM Patient P
JOIN Hospitalisation H ON P.id_patient = H.id_patient
JOIN Service S ON H.id_service = S.id_service
WHERE S.nom_service = 'Chirurgie';
```

---

## **4. Médicaments coûtant plus de 20 €**

```sql
SELECT nom_medicament, prix
FROM Médicament
WHERE prix > 20;
```

---

## **5. Services médicaux coûtant moins de 100 €**

```sql
SELECT nom_service, tarif
FROM Service
WHERE tarif < 100;
```

---

## **6. Patients hospitalisés plus de 10 jours**

```sql
SELECT DISTINCT P.nom, P.prénom
FROM Patient P
JOIN Hospitalisation H ON P.id_patient = H.id_patient
WHERE DATEDIFF(H.date_sortie, H.date_entree) > 10;
```

> `DATEDIFF(date1, date2)` retourne le nombre de jours entre deux dates.

---

## **7. Patients n’ayant jamais été hospitalisés**

```sql
SELECT nom, prénom
FROM Patient
WHERE id_patient NOT IN (
  SELECT id_patient FROM Hospitalisation
);
```

---

## **8. Médecins ayant prescrit le médicament "Paracétamol"**

```sql
SELECT DISTINCT M.nom, M.prénom
FROM Médecin M
JOIN Consultation C ON M.id_medecin = C.id_medecin
JOIN Ordonnance O ON C.id_consultation = O.id_consultation
JOIN Médicament Med ON O.id_medicament = Med.id_medicament
WHERE Med.nom_medicament = 'Paracétamol';
```

---

## **9. Diagnostics faits par "Dr Martin"**

```sql
SELECT DISTINCT C.diagnostic
FROM Consultation C
JOIN Médecin M ON C.id_medecin = M.id_medecin
WHERE M.nom = 'Martin';
```

> Si "Dr Martin" peut avoir plusieurs prénoms, tu peux aussi ajouter une condition sur le prénom pour plus de précision.

---

## **10. Patients ayant consulté le même médecin que "Mme Dubois"**

```sql
SELECT DISTINCT P2.nom, P2.prénom
FROM Patient P1
JOIN Consultation C1 ON P1.id_patient = C1.id_patient
JOIN Patient P2
JOIN Consultation C2 ON P2.id_patient = C2.id_patient
WHERE C1.id_medecin = C2.id_medecin
  AND P1.nom = 'Dubois' AND P1.prénom = 'Mme'
  AND P1.id_patient <> P2.id_patient;
```
