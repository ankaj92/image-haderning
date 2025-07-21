# ---- Build Stage ----
FROM gradle:8.7.0-jdk17-alpine AS builder

WORKDIR /app
COPY . /app
RUN gradle build --no-daemon

# ---- Runtime Stage ----
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy only the built JAR from the builder stage
COPY --from=builder /app/build/libs/*.jar /app/app.jar

# Create a non-root user for security
RUN addgroup -g 1001 appgroup && adduser -D -u 1001 -G appgroup appuser

USER appuser:appgroup

EXPOSE 8080

COPY test.txt /app/test.txt

ENTRYPOINT ["java", "-jar", "/app/app.jar"]