FROM alpine:3.21

# Install bash and gawk for stable decimal calculations
RUN apk add --no-cache bash gawk

# Set working directory inside the container
WORKDIR /app

# Copy your local script directly into the container workspace
COPY  memory-health-checker .

# Grant execution rights to the script file
RUN chmod +x memory-health-checker

# Force the script to execute immediately when the container launches
CMD ["./memory-health-checker"]


=======
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
>>>>>>> 5bd13af03e7c5cdb0bf60d45ba3ec5fa8862183d
