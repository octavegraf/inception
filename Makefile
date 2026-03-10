SRC					=	srcs
COMPOSE				=	$(addprefix $(SRC), /docker-compose.yml)
all					:
	test -f $(SRC)/.env || mv $(SRC)/.env.example $(SRC)/.env
	docker compose -f $(COMPOSE) build

run					:
	docker compose -f $(COMPOSE) up --build

stop				:
	docker compose -f $(COMPOSE) down

.PHONY				:	all run stop
# .SILENT				: