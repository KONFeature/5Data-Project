# Image de base
FROM mongo

# Copie de nos données
ADD http://nivelais.com/students.json /students.json
        
# Import des données dans mango
CMD mongoimport --host mongo \ 
    --db data-projects --collection students \ 
    --type json --drop --file /students.json --jsonArray