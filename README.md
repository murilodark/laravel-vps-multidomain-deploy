# Laravel VPS Multidomain Deploy

Production-ready Laravel deployment architecture using Docker, Traefik, automatic SSL, multi-domain VPS setup and CI/CD with GitHub Actions.

---

## Overview

This repository centralizes the documentation and infrastructure flow for a complete Laravel Full Stack deployment architecture.

The project demonstrates how to deploy:

- Scalable Laravel APIs
- Modular React frontends
- Multiple domains on a single VPS
- Homolog and production environments
- Automatic SSL with Let's Encrypt
- Automated deployment pipelines with GitHub Actions

---

## Repositories

### Backend API

```txt
git-public-api
```

Laravel API infrastructure containing:

- Docker environment
- Nginx
- PHP
- MySQL
- Queue workers
- GitHub Actions deploy workflows
- Homolog and production environments

---

### Frontend React

```txt
git-public-front
```

React application containing:

- Modular architecture
- Vite build system
- Environment separation
- Automated deployment workflows

---

## Infrastructure Stack

- Laravel
- React
- Docker
- Docker Compose
- Traefik
- GitHub Actions
- Let's Encrypt SSL
- Ubuntu VPS

---

## Architecture

```txt
Internet
   |
HTTPS / SSL
   |
Traefik Reverse Proxy
   |
   |-- Frontend Homolog
   |-- Backend Homolog
   |-- Frontend Production
   |-- Backend Production
```

---

## Domains

### Homolog

```txt
https://git-public-front-homolog.olirumcloud.com.br
https://git-public-api-homolog.olirumcloud.com.br
```

### Production

```txt
https://git-public-front-production.olirumcloud.com.br
https://git-public-api-production.olirumcloud.com.br
```

---

## VPS Features

- Multiple domains on the same server
- Automatic SSL generation
- Reverse proxy routing
- Environment isolation
- Containerized applications
- Automated deployments
- CI/CD workflow
- Production-ready architecture

---

## Deployment Flow

```txt
develop branch -> homolog deploy
main branch    -> production deploy
```

---

## Traefik Setup

Traefik is responsible for:

- Reverse proxy
- HTTPS routing
- SSL generation
- Domain management
- Docker service discovery

Documentation:

```txt
/docs/traefik.md
```

---

## Documentation

### English

```txt
/docs/en
```

### Portuguese

```txt
/docs/pt-br
```

---

## GitHub Actions

Automated deployment is executed through GitHub Actions workflows.

Features:

- Automatic deploy via push
- Environment separation
- SSH deployment
- Docker container rebuild
- Zero manual deployment process

---

## Roadmap

- Automated rollback
- Health checks
- Monitoring
- Backup automation
- Queue scaling
- Blue/Green deployment
- AI-assisted workflows
- Observability stack

---

## Topics

```txt
laravel
docker
vps
deploy
deployment
traefik
github-actions
multi-domain
ssl
ci-cd
reverse-proxy
production-ready
```

---

## Licença

Este projeto é livre para estudo, adaptação e uso como base em aplicações reais.

## Autor

Desenvolvido por Murilo Dark.
