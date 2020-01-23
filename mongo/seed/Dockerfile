# Arguments pour ce dockerfile
ARG MONGO_USER=data
ARG MONGO_PASS=achanger
ARG MONGO_DB=data-project

# Image de base
FROM mongo

# Copie de nos données
COPY students.json /students.json

# Import des données dans mango
RUN echo "Lancement de l'import des données pour le user : '$MONGO_USER'"
CMD mongoimport --host mongo \ 
    --username $MONGO_USER --password $MONGO_PASS \
    --db $MONGO_DB --collection students \ 
    --type json --drop --file /students.json --jsonArray