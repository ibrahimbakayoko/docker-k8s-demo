# Étape de construction
FROM maven:3.8.6-eclipse-temurin-17 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet dans le conteneur
COPY . .

# Construire le projet Maven
RUN mvn clean package

# Étape d'exécution
FROM eclipse-temurin:17-jdk-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier JAR de l'étape de construction
COPY --from=build /app/target/hello-world-0.0.1-SNAPSHOT.jar /app/hello-world-app.jar

# Définir le point d'entrée pour l'image Docker
ENTRYPOINT ["java", "-jar", "/app/hello-world-app.jar"]
