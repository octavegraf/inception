SRC					=	srcs
COMPOSE				=	$(addprefix $(SRC), /docker-compose.yml)
all					:
	docker compose -f $(COMPOSE) build

run					:
	docker compose -f $(COMPOSE) up

stop				:
	docker compose -f $(COMPOSE) down

.PHONY				:	all clean fclean re run stop
# .SILENT				: