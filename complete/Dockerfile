FROM maven as build

WORKDIR /build

COPY pom.xml .
RUN mvn --fail-never verify

COPY src src
RUN mvn -T 10C -Dmaven.test.skip -DskipTests -o package


FROM openjdk

COPY --from=build /build/target/gs-maven-0.1.0.jar /app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]