// Creation de la collection etudiants
db.createCollection("students")
print("Collection crée")


// Récuperation des données 
print("Récuperation du fichier students")
cd("docker-entrypoint-initdb.d/")
print(ls())
print(pwd())
var file = cat('./students.json')
print("Fichier chargé avec succès")
var studentsData = JSON.parse(file);

// Insertition des données
db.students.insert(studentsData)