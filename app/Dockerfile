FROM denoland/deno:latest

WORKDIR /app

# Copy dependency files
COPY deno.json .

# Copy source code
COPY src ./src

# Cache dependencies
RUN deno install --entrypoint src/main.ts

# Expose port
EXPOSE 8000

# Run the application
CMD ["deno", "run", "--allow-net", "--allow-env", "src/main.ts"]
