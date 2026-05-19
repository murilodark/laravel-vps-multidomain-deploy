
# Laravel VPS Multidomain Deploy

Arquitetura Full Stack pronta para produção utilizando Laravel, React, Docker, Traefik, SSL automático, múltiplos domínios em uma única VPS e deploy automatizado com GitHub Actions.

---

# Visão Geral

Este repositório funciona como o hub principal da arquitetura.

Aqui estão centralizadas todas as documentações necessárias para configurar:

- infraestrutura da VPS;
- Traefik;
- SSL automático;
- múltiplos domínios;
- CI/CD;
- deploy automatizado;
- integração entre frontend e backend;
- arquitetura Full Stack desacoplada.

O objetivo é disponibilizar uma estrutura moderna, reutilizável e escalável para aplicações Laravel + React utilizando Docker em ambientes reais de homologação e produção.

---

# Objetivos da Arquitetura

Esta estrutura foi projetada para:

- aplicações Laravel escaláveis;
- frontend React modular;
- deploy automatizado;
- múltiplos ambientes;
- isolamento por domínio;
- SSL automático;
- integração contínua;
- reutilização da infraestrutura;
- padronização de deploys;
- redução de custo operacional.

---

# Repositórios do Ecossistema

## Backend Laravel API

```txt
git-public-api
````

Responsável por:

* API Laravel;
* Docker backend;
* PHP;
* Nginx;
* MySQL;
* Queue Workers;
* Migrations;
* Configuração de ambientes;
* Deploy homolog;
* Deploy produção;
* GitHub Actions.

---

## Frontend React

```txt
git-public-front
```

Responsável por:

* Frontend React;
* Vite;
* Arquitetura modular;
* Providers;
* Layouts;
* Consumo da API;
* Build frontend;
* Deploy automatizado;
* Ambientes separados.

---

## Repositório Âncora

```txt
laravel-vps-multidomain-deploy
```

Responsável por:

* documentação principal;
* infraestrutura;
* Traefik;
* SSL;
* VPS;
* arquitetura geral;
* onboarding;
* diagramas;
* CI/CD;
* instruções de deploy;
* DNS;
* padronização do ecossistema.

---

# Stack Utilizada

## Backend

* Laravel
* PHP
* Nginx
* MySQL
* Queue Workers

## Frontend

* React
* Vite
* TypeScript

## Infraestrutura

* Docker
* Docker Compose
* Traefik
* Let's Encrypt
* Ubuntu VPS

## DevOps

* GitHub Actions
* SSH
* RSync
* CI/CD

---

# Arquitetura Geral

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

# Fluxo de Ambientes

## Homologação

```txt
Branch: develop
```

Deploy automático para:

```txt
git-public-front-homolog.olirumcloud.com.br
git-public-api-homolog.olirumcloud.com.br
```

---

## Produção

```txt
Branch: main
```

Deploy automático para:

```txt
git-public-front-production.olirumcloud.com.br
git-public-api-production.olirumcloud.com.br
```

---

# Fluxo de Deploy

```txt
develop -> homologação
main    -> produção
```

Cada push executa automaticamente:

* conexão SSH na VPS;
* sincronização dos arquivos;
* rebuild dos containers;
* restart dos serviços;
* atualização do ambiente.

---

# Estrutura da VPS

A VPS executa:

* Traefik global;
* múltiplos containers Docker;
* múltiplos ambientes;
* múltiplos domínios;
* SSL automático;
* pipelines independentes;
* frontend e backend desacoplados.

---

# Estrutura do Repositório

```txt
.
├── README.md
├── docs/
├── infra/
│   └── traefik/
├── examples/
└── diagrams/
```

---

# Traefik

O Traefik é o reverse proxy central da arquitetura.

Responsabilidades:

* SSL automático;
* integração Docker;
* reverse proxy;
* roteamento por domínio;
* gerenciamento HTTPS;
* redirecionamento HTTP → HTTPS;
* emissão automática de certificados Let's Encrypt.

---

# Instalação do Traefik

Toda a configuração do Traefik está localizada em:

```txt
infra/traefik
```

O diretório contém:

```txt
infra/traefik/
├── docker-compose.yml
├── .env.example
└── README.md
```

O README do Traefik documenta:

* instalação completa;
* configuração DNS;
* criação do SSL;
* estrutura da VPS;
* configuração de rede Docker;
* labels do Traefik;
* troubleshooting;
* deploy da infraestrutura.

---

# Domínios Utilizados

## Homologação

```txt
https://git-public-front-homolog.olirumcloud.com.br
https://git-public-api-homolog.olirumcloud.com.br
```

---

## Produção

```txt
https://git-public-front-production.olirumcloud.com.br
https://git-public-api-production.olirumcloud.com.br
```

---

# Recursos da Infraestrutura

* múltiplos domínios;
* SSL automático;
* reverse proxy;
* ambientes isolados;
* containers independentes;
* pipelines separados;
* deploy automatizado;
* CI/CD;
* arquitetura reutilizável;
* baixo custo operacional;
* fácil replicação.

---

# GitHub Actions

Os deploys são executados automaticamente via GitHub Actions.

Recursos implementados:

* deploy por branch;
* deploy homolog;
* deploy produção;
* SSH automatizado;
* RSync;
* rebuild automático;
* restart automático;
* sincronização de arquivos;
* automação completa de deploy.

---

# CI/CD

Pipeline atual:

```txt
Git Push
   |
GitHub Actions
   |
SSH VPS
   |
RSync
   |
Docker Compose
   |
Deploy Finalizado
```

---

# Roadmap

## Infraestrutura

* rollback automatizado;
* backup automatizado;
* observabilidade;
* monitoramento;
* métricas;
* logs centralizados;
* Blue/Green Deploy;
* Health Checks.

## Backend

* escalabilidade horizontal;
* workers distribuídos;
* filas avançadas;
* cache distribuído.

## Frontend

* SSR;
* Edge Rendering;
* CDN;
* otimizações de performance.

## DevOps

* deploy com IA;
* automações avançadas;
* validações automatizadas;
* pipelines inteligentes.

---

# Documentação

## Infraestrutura

```txt
infra/traefik
```

---

## Português

```txt
docs/pt-br
```

---

## Inglês

```txt
docs/en
```

---

# Público-Alvo

Este projeto é ideal para:

* desenvolvedores Laravel;
* desenvolvedores React;
* DevOps;
* freelancers;
* agências;
* SaaS;
* aplicações multiambiente;
* arquiteturas Full Stack modernas;
* deploys profissionais de baixo custo.

---

# Benefícios da Arquitetura

* infraestrutura reutilizável;
* separação clara de responsabilidades;
* baixo acoplamento;
* alta escalabilidade;
* deploy simplificado;
* fácil manutenção;
* baixo custo de hospedagem;
* SSL automatizado;
* padronização de projetos;
* onboarding simplificado.

---

# Topics GitHub

```txt
laravel
react
docker
docker-compose
vps
deploy
deployment
traefik
github-actions
multi-domain
ssl
ci-cd
reverse-proxy
full-stack
production-ready
devops
automation
```

---

# Autor

Murilo Dark
