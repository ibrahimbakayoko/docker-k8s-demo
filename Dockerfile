FROM openjdk:11
COPY target/hello-world-0.0.1-SNAPSHOT.jar hello-world-app.jar
ENTRYPOINT ["java", "-jar", "hello-world-app.jar"]
