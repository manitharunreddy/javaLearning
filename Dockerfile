# ----------- Build Stage -----------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy all files
COPY . .

# Package the application without tests
RUN mvn clean install -DskipTests

# ----------- Run Stage -----------
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the jar
CMD ["java", "-jar", "app.jar"]
