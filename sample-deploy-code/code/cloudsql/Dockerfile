FROM maven:3.8.5-jdk-11 as builder
# WORKDIR /src/main/java/com/example/cloudsql
COPY pom.xml .
RUN mvn -B dependency:resolve
COPY src ./src
RUN mvn -B package

FROM openjdk:11-jdk-slim
# WORKDIR /src/main/java/com/example/cloudsql
COPY --from=builder target/cloudsql-1.0.jar /cloudsql/cloudsql-1.0.jar
EXPOSE 8080
ENTRYPOINT ["java", "-cp", "/cloudsql/cloudsql-1.0.jar", "com.example.cloudsql.functions.Main"]