# Laravel VPS Multidomain Deploy

Arquitetura Laravel pronta para produção utilizando Docker, Traefik, SSL automático, múltiplos domínios em uma única VPS e deploy automatizado com GitHub Actions.

---

## Visão Geral

Este repositório centraliza toda a documentação necessária para utilizar a arquitetura completa de deploy Full Stack do projeto.

O objetivo é demonstrar uma estrutura real contendo:

- APIs Laravel escaláveis
- Frontend React modular
- Múltiplos domínios em uma única VPS
- Ambientes separados
- SSL automático
- Deploy automatizado
- CI/CD

---

## Repositórios

### Backend Laravel API

```txt
git-public-api
```

Responsável por:

- API Laravel
- Docker
- Nginx
- PHP
- MySQL
- Workers
- Workflows GitHub Actions
- Deploy homolog e produção

---

### Frontend React

```txt
git-public-front
```

Responsável por:

- Frontend React
- Arquitetura modular
- Vite
- Ambientes separados
- Deploy automatizado

---

## Stack Utilizada

- Laravel
- React
- Docker
- Docker Compose
- Traefik
- GitHub Actions
- Let's Encrypt
- Ubuntu VPS

---

## Arquitetura

```txt
Internet
   |
HTTPS / SSL
   |
Traefik Reverse Proxy
   |
   |-- Frontend Homolog
   |-- Backend Homolog
   |-- Frontend Produção
   |-- Backend Produção
```

---

## Domínios

### Homologação

```txt
https://git-public-front-homolog.olirumcloud.com.br
https://git-public-api-homolog.olirumcloud.com.br
```

### Produção

```txt
https://git-public-front-production.olirumcloud.com.br
https://git-public-api-production.olirumcloud.com.br
```

---

## Recursos da VPS

- Múltiplos domínios
- SSL automático
- Reverse proxy
- Isolamento por ambiente
- Containers Docker
- Deploy automático
- Pipeline CI/CD
- Arquitetura reutilizável

---

## Fluxo de Deploy

```txt
develop -> homologação
main    -> produção
```

---

## Traefik

O Traefik é responsável por:

- SSL automático
- Reverse proxy
- Roteamento dos domínios
- Integração Docker
- Gerenciamento HTTPS

Documentação:

```txt
/docs/pt-br/traefik.md
```

---

## Documentação

### Inglês

```txt
/docs/en
```

### Português

```txt
/docs/pt-br
```

---

## GitHub Actions

Os deploys são executados automaticamente via GitHub Actions.

Recursos:

- Deploy automático por push
- Separação de ambientes
- SSH + RSync
- Rebuild automático dos containers
- Fluxo totalmente automatizado

---

## Roadmap

- Rollback automático
- Health checks
- Monitoramento
- Backup automatizado
- Escalabilidade de workers
- Deploy Blue/Green
- Fluxos com IA
- Observabilidade

---

## Topics GitHub

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

## Autor

Murilo Dark
