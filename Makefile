SHELL:=/usr/bin/env bash
.PHONY : help up down network show-nginx-conf

help:  ## Show this help message.
	@echo -e "\nAvailame make command for docker-proy:\n"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
	@echo

up: network .env ## Start the docker-proxy
	docker-compose up --force-recreate --remove-orphans --renew-anon-volumes -d
	docker-compose ps

down: ## Stop docker-proxy
	docker-compose down --remove-orphans --volumes
	docker-compose ps

network: ## Creates the www-gateway network
	@docker network inspect www-gateway &> /dev/null \
	&& echo "Network www-gateway already exists, nothing to do" \
	|| ( echo -e "Creating www-gateway:" && docker network create www-gateway)

.env: ## Create the .env file (if not existing)
	cp .env.template .env
	source .env

show-nginx-conf: ## Display the auto-generated nginx config
	docker-compose exec nginx-proxy cat /etc/nginx/conf.d/default.conf
