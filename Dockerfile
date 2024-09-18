# Étape de construction
FROM maven:3.8.6-openjdk-17 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers pom.xml et télécharger les dépendances
COPY pom.xml .
RUN mvn dependency:go-offline

# Copier le reste du code source et compiler le projet
COPY src ./src
RUN mvn clean package

# Étape d'exécution
FROM openjdk:17-jre-slim

# Définir le répertoire de travail pour l'exécution
WORKDIR /app

# Copier le fichier jar compilé de l'étape de construction
COPY --from=build /app/target/docker-k8s-demo-0.0.1-SNAPSHOT.jar /app/docker-k8s-demo.jar

# Exposer le port d'écoute de l'application
EXPOSE 8080

# Commande pour exécuter l'application
ENTRYPOINT ["java", "-jar", "/app/docker-k8s-demo.jar"]
