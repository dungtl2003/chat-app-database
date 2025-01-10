#!/bin/bash

CONTAINER_NAME="chat-app-db"

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

# Ensure DATABASE_URL is set
if [ -z "$DATABASE_URL_INSIDE_CONTAINER" ]; then
  echo "DATABASE_URL is not set!"
  exit 1
fi

docker container exec -it $CONTAINER_NAME bash -c "psql $DATABASE_URL_INSIDE_CONTAINER"
