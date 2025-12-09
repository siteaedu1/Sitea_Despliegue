FROM maven:3.9-eclipse-temurin-11 AS builder

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:resolve

COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:11-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/*.war app.war

EXPOSE 8080

CMD ["java", "-jar", "app.war"]
