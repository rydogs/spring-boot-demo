FROM maven:3.8-openjdk-11-slim AS build
COPY src src
COPY pom.xml pom.xml
COPY newrelic newrelic
RUN mvn clean package

FROM adoptopenjdk/openjdk11
ARG JAR_FILE=target/app.jar
COPY --from=build ${JAR_FILE} app.jar
COPY --from=build newrelic newrelic
RUN curl https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-agent.jar -O
EXPOSE 8080
ENTRYPOINT ["java", "${JAVA_OPTS}", "-jar", "-javaagent:/newrelic/newrelic-agent.jar", "-Dnewrelic.config.file=/newrelic/newrelic.yaml", "/app.jar"]