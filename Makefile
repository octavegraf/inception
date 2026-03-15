SRC					=	srcs
COMPOSE				=	$(addprefix $(SRC), /docker-compose.yml)
VOLUMES				=	~/ocgraf/data/
all					:
	./$(SRC)/secrets_init.sh
	test -f $(SRC)/.env || cp $(SRC)/.env.example $(SRC)/.env
	mkdir -p $(VOLUMES)/mariadb
	mkdir -p $(VOLUMES)/wordpress
	docker compose -f $(COMPOSE) build

run					: all
	docker compose -f $(COMPOSE) up

stop				:
	docker compose -f $(COMPOSE) down

clean				:
	docker compose -f $(COMPOSE) down --remove-orphans

fclean				:	clean
	docker compose -f $(COMPOSE) down --rmi all --volumes
	rm -rf $(VOLUMES)
.PHONY				:	all run stop clean fclean
# .SILENT				: