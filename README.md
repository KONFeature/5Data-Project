# 5Data-Project

## Variables

Dans le fichier '.env' il y'a toute les variables de deploiement des container docker.

## Ports utilisé

Avec la configuration par default, les ports sortant utilisé sont : 

| Service                  | Port  |
|--------------------------|-------|
| Shiny (Server R)         | 80    |
| Mongo Express (Mongo UI) | 8070  |
| Spark master UI          | 8080  |
| Spark worker UI          | 8081  |
| Mongo DB                 | 27017 |
| Spark master             | 7077  |
| Spark worker             | 8881  |

## Identifiants


Par default les identifiants utilisé sont : 

| Service       | Utilisateur  | Mot de passe                      |
|---------------|--------------|-----------------------------------|
| Mongo Express | data-project | ReallYStronGPassworDFoRThEProjecT |

Nous mettons les identifiants en clair dans .env ici, mais dans le cadre d'un projet concret, les identifiants serait placé dans le fichier docker-secret du serveur de production
