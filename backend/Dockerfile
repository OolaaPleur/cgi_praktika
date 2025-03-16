# Use Java 21 JDK on Ubuntu Jammy as the build environment
FROM eclipse-temurin:21-jdk-jammy AS builder

# Install Maven for dependency management and building
RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean

# Set working directory for the build
WORKDIR /app

# Copy and cache project dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code and build the application
COPY . .
RUN mvn clean package -DskipTests

# Use Java 21 JRE as the runtime environment
FROM eclipse-temurin:21-jre-jammy

# Create a non-root user for security
RUN useradd -m appuser
USER appuser

# Set working directory for the runtime
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Set the entrypoint to run the Java application
ENTRYPOINT ["java", "-jar", "app.jar"] 