SRC					=	srcs
COMPOSE				=	$(addprefix $(SRC), /docker-compose.yml)
all					:
	test -f $(SRC)/.env || mv $(SRC)/.env.example $(SRC)/.env
	docker compose -f $(COMPOSE) build

run					:
	docker compose -f $(COMPOSE) up --build

stop				:
	docker compose -f $(COMPOSE) down

clean				:
	docker compose -f $(COMPOSE) down --remove-orphans

fclean				:	clean
	docker compose -f $(COMPOSE) down --rmi all --volumes
.PHONY				:	all run stop clean fclean
# .SILENT				: