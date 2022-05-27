FROM adoptopenjdk/openjdk11 AS build
COPY src src
COPY pom.xml pom.xml
RUN ./mvnw clean package

FROM adoptopenjdk/openjdk11
ARG JAR_FILE=target/app.jar
ADD ${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]