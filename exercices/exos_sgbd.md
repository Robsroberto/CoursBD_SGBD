## Exercice1

soit le schema relationnel suivant

1. **Voyageurs** 
(Voyageur):<u>`id_voyageur`</u>,`nom`,`prenom`,`date_naissance`,`adresse`

2. **Voyages** (Voyage): <u>`id_voyage`</u>, `destination`, `date_depart`,`date_retour`

3. **Reservations** (Réservation) : <u>`id_reservation`</u> ,#`id_voyageur`,#`id_voyage` 
4. **Hotels** (Hôtel) :<u>`id_hotel`</u> , `nom_hotel`,`adresse_hotel`

5. **Chambres** (Chambre) : `id_chambre`,#`id_hotel` , `type_chambre`, `prix_nuit`

Repondre en algèbre relationnelle basées sur ce schéma ci dessus :

1. Quels sont les noms et prénoms des voyageurs ayant réservé un voyage ?
2. Quelles sont les destinations des voyages réservés par le voyageur numero 010 ?
3. Quels sont les hôtels proposant des chambres à moins de 100 $ par nuit ?
4. Quels voyageurs ont réservé un voyage vers la destination Brésil ?
5. Quelle est la date de départ du voyage réservé par le voyageur Abdou Kane ?
6. Quels sont les types de chambres disponibles dans l'hôtel Radisson ?
7. Quels sont les prix des chambres dans tous les hôtels situé a mbour?
8. Quels voyageurs ont réservé un voyage pour la période du 1er juillet au  15 août ?

## Exercice 2


Soit le schéma relationnel suivant :

1. **Produits** (Produit) : <u>`id_produit`</u>,`nom_produit`, `categorie`, `quantite_stock`

2. **Commandes** (Commande) : <u>`id_commande`</u>, `date_commande`, #`id_produit`,#`id_client`

3. **Clients** (Client) : <u>`id_client`</u>, `nom_client`,`adresse`

Répondre en algèbre relationnelle basée sur ce schéma ci-dessus :

1. Quels sont les noms des produits dont la quantité en stock est inférieure à 10 ?
2. Quels clients ont passé une commande pour un produit spécifique (par exemple, "Ordinateur portable") ?
3. Quelle est la quantité totale en stock pour une catégorie donnée (par exemple, "Électronique") ?
4. Quelle est la date de la  commande passée par un client numero 099 ?
5. Quelle est la quantité  commandée pour le produit imprimante par le client 087 nommé Modou  ?
6. Quels clients ont passé une commande pour le produit Souris dont la quantité en stock est inférieure à 5 ?
7. Quels produits ont été commandés par les clients habitant a FASS ?


