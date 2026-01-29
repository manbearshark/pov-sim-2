# Step 1: Use an official Gradle image to build the application
FROM gradle:8.3.0-jdk17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project to the container
COPY . .

# Build the application
RUN gradle clean bootJar

# Step 2: Use a lightweight JDK image for running the app
FROM --platform=linux/amd64 eclipse-temurin:17-jdk-alpine

# Set the working directory for the runtime container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/build/libs/*.jar app.jar
COPY ./pyroscope.jar pyroscope.jar
COPY ./grafana-opentelemetry-java.jar grafana-opentelemetry-java.jar

# Expose the port the application runs on
EXPOSE 8080

# Set the command to run the application
ENTRYPOINT ["java", "-javaagent:grafana-opentelemetry-java.jar", "-javaagent:pyroscope.jar", "-jar", "app.jar"]
