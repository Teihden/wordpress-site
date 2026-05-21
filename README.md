# WordPress Site

Local WordPress project running on Docker Compose with a separate MySQL container and simple `Makefile` commands.

## What Is Included

- `wordpress:latest` for the application
- `mysql:8.0` for the database
- `phpmyadmin:latest` for DB web UI
- `.env` for local secrets
- `.env.example` as an environment variable template
- `Makefile` for `up`, `start`, `stop`, `down`, `restart`, and `logs`
- browser selection via `BROWSER`

## Requirements

- Docker
- Docker Compose
- `make`

## Structure

- [docker-compose.yml](/Users/denis/Documents/Training practice/study repos/wordpress-site/docker-compose.yml:1) defines the `wordpress`, `db`, and `phpmyadmin` services
- [Makefile](/Users/denis/Documents/Training practice/study repos/wordpress-site/Makefile:1) contains helper commands
- [.env.example](/Users/denis/Documents/Training practice/study repos/wordpress-site/.env.example:1) shows the required environment variables

## Setup

1. Create a local `.env` file based on `.env.example`.
2. Fill in the values:

```env
MYSQL_ROOT_PASSWORD=change_me_root_password
MYSQL_DATABASE=wordpress
MYSQL_USER=change_me_user
MYSQL_PASSWORD=change_me_password
BROWSER=Firefox Developer Edition
```

`.env` is not committed to the repository and is used only locally.

## Run

Create and start containers, then open the site in the browser configured in `BROWSER`:

```bash
make up
```

After startup:

```text
http://localhost:8080
http://localhost:8081
```

## Useful Commands

Start already created containers:

```bash
make start
```

Stop containers without removing them:

```bash
make stop
```

Stop and remove containers/network:

```bash
make down
```

Restart already created containers and open the site again:

```bash
make restart
```

View logs:

```bash
make logs
```

## How It Works

- the `db` service starts MySQL
- the `wordpress` service connects to the database at `db:3306`
- the `phpmyadmin` service connects to `db` and is available at `http://localhost:8081`
- MySQL data is persisted in the Docker volume `db_data`
- `make up`, `make start`, and `make restart` wait until the `wordpress` container becomes `healthy`, then run `open -a "$(BROWSER)" http://localhost:8080`

## Notes

- `3306` is the standard internal MySQL port
- the database is not exposed to the host machine
- `BROWSER` should match the macOS application name exactly
- if secrets were committed earlier, they should be rotated
