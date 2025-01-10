#!/bin/bash

create_env() {
    if [ -f .env ]; then
        echo ".env file already exists"
    else
        echo "Creating .env file"
        echo "DATABASE_URL=postgresql://admin:testpass123@localhost:6000/chat-app" > .env
    fi
}

create_env
