# -------- Build Stage --------
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy the whole project
COPY . .

# Build the project (skip tests to speed up)
RUN mvn clean install -DskipTests

# -------- Runtime Stage --------
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# Copy the compiled jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
