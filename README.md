# TYPO3 Docker Image

This project is experimental.

Dockerfile with TYPO3 8.6 based on a tiny Alpine Linux.

## Supported Tags

- `8.6`, `latest` [(Dockerfile)](https://github.com/ueberdosis/docker-typo3)

## Usage in Development

- Clone repository
- Build `docker-compose build`
- Run `docker-compose up -d`
- Install dependencies `docker-compose exec php composer install`
- Unlock installation `docker-compose exec php touch FIRST_INSTALL`
- Open `http://localhost`