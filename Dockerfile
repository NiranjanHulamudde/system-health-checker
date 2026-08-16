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


