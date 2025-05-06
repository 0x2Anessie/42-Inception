## Commandes Makefile – Inception

Ce projet utilise un Makefile pour automatiser les principales actions Docker liées au projet Inception.  
Chaque commande simplifie la gestion des images, conteneurs, volumes et réseaux nécessaires au bon fonctionnement des services (MariaDB, WordPress, NGINX).

| Commande         | Que fait-elle ?                                                                                                  |
|------------------|------------------------------------------------------------------------------------------------------------------|
| `make build`     | Construit les **images Docker** pour chaque service à partir des `Dockerfile`. Ne crée ni conteneurs ni volumes. |
| `make up`        | Lance les **conteneurs** à partir des images, crée les **réseaux** et **volumes** si nécessaire.                |
| `make create`    | Exécute `make build` **puis** `make up` → tout est prêt en une commande.                                         |
| `make stop`      | Arrête les **conteneurs en cours d'exécution**, mais **ne les supprime pas**.                                   |
| `make start`     | Redémarre les **conteneurs déjà créés**, sans les reconstruire.                                                  |
| `make down`      | Supprime les **conteneurs et le réseau**, mais **garde les volumes** intacts.                                   |
| `make clean`     | Supprime les **conteneurs, volumes, et réseau**, **puis supprime les dossiers bindés** (dans `/home/...`).       |
| `make prune`     | Fait un `make clean` **puis** supprime toutes les ressources Docker **inutilisées** sur la machine (`prune -a`). |
| `make open`      | Ouvre le site WordPress à l’adresse `https://acatusse.42.fr`.                                                    |
| `make openadmin` | Ouvre l’interface d’administration WordPress à `https://acatusse.42.fr/wp-admin/`.                              |
