# Use Maven image to build the application
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy only the necessary files for building the application
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use OpenJDK image as the base image for the runtime environment
FROM openjdk:17.0.1-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the compiled JAR file from the build stage to the current directory in the runtime stage
COPY --from=build /app/target/SpringStarter-0.0.1-SNAPSHOT.jar SpringStarter.jar

# Expose the port the application runs on
EXPOSE 8080

# Set the command to run the application when the container starts
CMD ["java", "-jar", "SpringStarter.jar"]
