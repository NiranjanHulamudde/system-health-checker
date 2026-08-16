# Use a lightweight Linux base image
FROM alpine:latest

# Install core utilities needed for system checking
RUN apk add --no-cache bash coreutils procps

# Set the working directory inside the container
WORKDIR /app

# Copy your tracking scripts into the container
COPY check_mem.sh /app/check_mem.sh
COPY memory-health-checker /app/memory-health-checker

# Grant executable permissions to the scripts
RUN chmod +x /app/check_mem.sh /app/memory-health-checker

# Set the script to run when the container starts
CMD ["/bin/bash", "/app/memory-health-checker"]
