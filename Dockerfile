# -------- Build Stage --------
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Build the application without running tests
RUN mvn clean package -DskipTests

# -------- Runtime Stage --------
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# Copy built jar to runtime container
COPY --from=build /app/target/javamaven-0.0.1-SNAPSHOT.jar app.jar

# Expose port (optional: update to match your app's port)
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "app.jar"]
