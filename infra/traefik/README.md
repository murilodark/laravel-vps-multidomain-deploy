Segue o `infra/traefik/README.md` completo:
# Traefik - Reverse Proxy Global da VPS

Este diretório contém a configuração base do Traefik para atuar como reverse proxy global da VPS, responsável por rotear múltiplos domínios para diferentes aplicações Docker e emitir certificados SSL automaticamente via Let's Encrypt.

## Objetivo

O Traefik será instalado uma única vez na VPS e utilizado por todos os projetos do ecossistema.

Ele será responsável por:

- receber requisições HTTP e HTTPS;
- redirecionar HTTP para HTTPS;
- identificar containers Docker expostos por labels;
- rotear domínios para os containers corretos;
- emitir certificados SSL automaticamente;
- renovar certificados SSL sem intervenção manual.

## Arquitetura

```txt
Internet
   |
   |  HTTPS
   |
Traefik
   |
   |-- git-public-front-homolog.olirumcloud.com.br
   |-- git-public-front-production.olirumcloud.com.br
   |-- git-public-api-homolog.olirumcloud.com.br
   |-- git-public-api-production.olirumcloud.com.br
````

## Estrutura

```txt
infra/traefik/
├── docker-compose.yml
├── .env.example
└── README.md
```

## Pré-requisitos

Antes de instalar o Traefik, a VPS deve possuir:

* Docker instalado;
* Docker Compose instalado;
* portas `80` e `443` liberadas;
* domínios apontando para o IP da VPS;
* acesso root ou usuário com permissão para Docker.

## Domínios utilizados

Configure no provedor DNS os seguintes registros do tipo `A`, todos apontando para o IP da VPS:

```txt
git-public-front-homolog.olirumcloud.com.br
git-public-front-production.olirumcloud.com.br
git-public-api-homolog.olirumcloud.com.br
git-public-api-production.olirumcloud.com.br
```

Exemplo:

```txt
Tipo: A
Nome: git-public-api-homolog
Valor: IP_DA_VPS
TTL: Automático
```

## Instalação

Acesse a VPS:

```bash
ssh root@IP_DA_VPS
```

Crie o diretório do Traefik:

```bash
mkdir -p /root/traefik
cd /root/traefik
```

Copie os arquivos deste diretório para a VPS:

```txt
infra/traefik/docker-compose.yml
infra/traefik/.env.example
```

Renomeie o arquivo de ambiente:

```bash
cp .env.example .env
```

Edite o `.env`:

```bash
nano .env
```

Configure o e-mail usado pelo Let's Encrypt:

```env
ACME_EMAIL=seu-email@dominio.com
```

## Criar diretório de certificados

Crie o diretório onde o Traefik armazenará os certificados SSL:

```bash
mkdir -p letsencrypt
touch letsencrypt/acme.json
chmod 600 letsencrypt/acme.json
```

## Subir o Traefik

Execute:

```bash
docker compose up -d
```

Verifique se o container está rodando:

```bash
docker ps
```

Resultado esperado:

```txt
traefik   traefik:v2.11   Up
```

## docker-compose.yml

O arquivo principal deve seguir este modelo:

```yml
services:
  traefik:
    image: traefik:v2.11
    container_name: traefik
    restart: always

    command:
      - --api.dashboard=false
      - --api.insecure=false
      - --log.level=INFO

      - --providers.docker=true
      - --providers.docker.exposedbydefault=false

      - --entrypoints.web.address=:80
      - --entrypoints.websecure.address=:443

      - --entrypoints.web.http.redirections.entrypoint.to=websecure
      - --entrypoints.web.http.redirections.entrypoint.scheme=https

      - --certificatesresolvers.letsencrypt.acme.httpchallenge=true
      - --certificatesresolvers.letsencrypt.acme.httpchallenge.entrypoint=web
      - --certificatesresolvers.letsencrypt.acme.email=${ACME_EMAIL}
      - --certificatesresolvers.letsencrypt.acme.storage=/letsencrypt/acme.json

    ports:
      - "80:80"
      - "443:443"

    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./letsencrypt:/letsencrypt

networks:
  default:
    name: traefik-network
```

## Rede Docker compartilhada

O Traefik utiliza a rede:

```txt
traefik-network
```

Os containers dos projetos backend e frontend precisam estar conectados a essa mesma rede para que o Traefik consiga rotear as requisições corretamente.

Nos arquivos `docker-compose` dos projetos, utilize:

```yml
networks:
  traefik-network:
    external: true
```

E nos serviços expostos pelo Traefik:

```yml
networks:
  - traefik-network
```

## Exemplo de labels Traefik

Exemplo para uma API Laravel em homologação:

```yml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.api-homolog.rule=Host(`git-public-api-homolog.olirumcloud.com.br`)"
  - "traefik.http.routers.api-homolog.entrypoints=websecure"
  - "traefik.http.routers.api-homolog.tls.certresolver=letsencrypt"
  - "traefik.http.services.api-homolog.loadbalancer.server.port=80"
```

Exemplo para um frontend React em produção:

```yml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.front-production.rule=Host(`git-public-front-production.olirumcloud.com.br`)"
  - "traefik.http.routers.front-production.entrypoints=websecure"
  - "traefik.http.routers.front-production.tls.certresolver=letsencrypt"
  - "traefik.http.services.front-production.loadbalancer.server.port=80"
```

## Validar logs

Para acompanhar os logs:

```bash
docker logs -f traefik
```

## Testar HTTPS

Após subir os containers das aplicações, acesse:

```txt
https://git-public-api-homolog.olirumcloud.com.br
https://git-public-api-production.olirumcloud.com.br
https://git-public-front-homolog.olirumcloud.com.br
https://git-public-front-production.olirumcloud.com.br
```

O Traefik deve gerar os certificados automaticamente no primeiro acesso válido.

## Problemas comuns

### Certificado SSL não foi emitido

Verifique:

* se o domínio aponta para o IP correto da VPS;
* se as portas `80` e `443` estão abertas;
* se o container Traefik está rodando;
* se o container da aplicação está na rede `traefik-network`;
* se as labels Traefik estão corretas;
* se o e-mail `ACME_EMAIL` foi configurado.

### Erro 404 do Traefik

Normalmente indica que o Traefik está rodando, mas não encontrou nenhum router compatível.

Verifique:

```bash
docker logs -f traefik
```

E revise as labels do container da aplicação.

### Erro 502 Bad Gateway

Normalmente indica que o Traefik encontrou o container, mas não conseguiu acessar a porta interna correta.

Verifique esta label:

```yml
- "traefik.http.services.NOME_DO_SERVICE.loadbalancer.server.port=80"
```

A porta deve ser a porta interna do container, não necessariamente a porta publicada na VPS.

## Reiniciar Traefik

```bash
docker compose restart
```

## Parar Traefik

```bash
docker compose down
```

## Atualizar Traefik

```bash
docker compose pull
docker compose up -d
```

## Observação importante

O Traefik deve ser instalado antes dos repositórios de backend e frontend serem publicados na VPS.

Fluxo recomendado:

```txt
1. Configurar DNS
2. Instalar Docker na VPS
3. Instalar Traefik
4. Criar secrets no GitHub
5. Configurar backend
6. Configurar frontend
7. Executar deploy automático
```

## Referências internas

Este Traefik é utilizado pelos seguintes projetos:

* `git-public-api`
* `git-public-front`
* `laravel-vps-multidomain-deploy`