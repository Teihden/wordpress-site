.PHONY: up start stop down restart logs open

up:
	docker compose up -d
	until [ "$$(docker inspect -f '{{.State.Health.Status}}' wp_app 2>/dev/null)" = "healthy" ]; do sleep 2; done
	$(MAKE) open

start:
	docker compose start
	until [ "$$(docker inspect -f '{{.State.Health.Status}}' wp_app 2>/dev/null)" = "healthy" ]; do sleep 2; done
	$(MAKE) open

stop:
	docker compose stop

down:
	docker compose down

restart:
	docker compose stop
	docker compose start
	until [ "$$(docker inspect -f '{{.State.Health.Status}}' wp_app 2>/dev/null)" = "healthy" ]; do sleep 2; done
	$(MAKE) open

logs:
	docker compose logs -f

open:
	. ./.env; open -a "$$BROWSER" http://localhost:8080
