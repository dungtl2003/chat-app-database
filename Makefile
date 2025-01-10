up: 
	docker compose up -d

down: 
	docker compose down

clean: down
	docker volume rm database_chat-app-db-data
	rm -f .env

generate_schema: up
	./scripts/create_env_file.sh
	echo "Generating Prisma Client"
	./scripts/generate_prisma_client.sh
	$(MAKE) down

access_db:
	./scripts/create_env_file.sh
	./scripts/access_db.sh
