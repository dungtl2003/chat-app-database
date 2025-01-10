#!/bin/bash

CONTAINER_NAME="chat-app-db"

MAX_RETRIES=5

# Function to check if the container is running
is_container_running() {
    docker inspect -f '{{.State.Running}}' "$CONTAINER_NAME" 2>/dev/null
}

# Wait for the container to be up and running
echo "Waiting for container '$CONTAINER_NAME' to start..."
until [ "$(is_container_running)" == "true" ]; do
    sleep 2
done

# Once the container is up, run the command
echo "Container '$CONTAINER_NAME' is running. Executing the command..."

RETRIES=0
EXIT_CODE=1  # Initial value to enter the loop

# Retry loop
while [ $RETRIES -lt $MAX_RETRIES ] && [ $EXIT_CODE -ne 0 ]; do
    # Run the command and capture the exit status
    zsh -c 'source ./scripts/load_nvm.sh && npx prisma migrate dev --name init'
    EXIT_CODE=$?

    # If the command failed, increment the retry counter
    if [ $EXIT_CODE -ne 0 ]; then
        RETRIES=$((RETRIES + 1))
        echo "Attempt $RETRIES of $MAX_RETRIES failed with exit code $EXIT_CODE. Retrying..."
        sleep 2  # Optional: wait before retrying
    fi
done

# Final check after retries
if [ $EXIT_CODE -eq 0 ]; then
    echo "Command executed successfully."
else
    echo "Command failed after $MAX_RETRIES attempts with exit code $EXIT_CODE."
fi
