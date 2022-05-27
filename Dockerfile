FROM maven:3.8-openjdk-11-slim AS build
COPY src src
COPY pom.xml pom.xml
RUN mvn clean package

FROM adoptopenjdk/openjdk11
ARG JAR_FILE=target/app.jar
COPY --from=build ${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]