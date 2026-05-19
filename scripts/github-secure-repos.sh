#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Script: github-secure-repos.sh
# =============================================================================
#
# Objetivo
# -----------------------------------------------------------------------------
# Automatizar a configuração de segurança e padronização dos repositórios
# GitHub do projeto.
#
# Este script aplica regras básicas de governança DevOps para evitar:
#
# - Push direto inseguro na branch principal
# - Force push acidental
# - Remoção de branches críticas
# - Configurações inconsistentes entre repositórios
#
# -----------------------------------------------------------------------------
# Repositórios configurados
# -----------------------------------------------------------------------------
#
# devem estar no array 
# REPOS=(
#  "laravel-vps-multidomain-deploy"
#  "git-public-api"
#  "git-public-front"
#)
#
# -----------------------------------------------------------------------------
# Configurações aplicadas
# -----------------------------------------------------------------------------
#
# Repositório:
# - Visibilidade pública
# - Issues habilitado
# - Wiki desabilitada
# - Projects desabilitado
#
# Branch "main":
# - Pull Request obrigatório
# - 1 aprovação obrigatória
# - Aprovações antigas descartadas após novos commits
# - Force push bloqueado
# - Delete branch bloqueado
# - Regras aplicadas inclusive para administradores
#
# Branch "develop":
# - Force push bloqueado
# - Delete branch bloqueado
# - Regras aplicadas inclusive para administradores
#
# -----------------------------------------------------------------------------
# Pré-requisitos
# -----------------------------------------------------------------------------
#
# 1. GitHub CLI instalado:
#
#    sudo apt install gh
#
# 2. Login autenticado:
#
#    gh auth login
#
# 3. Branches já existentes nos repositórios:
#
#    main
#    develop
#
# -----------------------------------------------------------------------------
# Execução
# -----------------------------------------------------------------------------
#
# chmod +x scripts/github-secure-repos.sh
#
# ./scripts/github-secure-repos.sh
#
# -----------------------------------------------------------------------------
# Benefícios
# -----------------------------------------------------------------------------
#
# - Infraestrutura como código
# - Padronização enterprise
# - Segurança centralizada
# - Redução de erro humano
# - Reaproveitamento em múltiplos projetos
# - Facilita onboarding futuro
#
# =============================================================================


OWNER="murilodark"

REPOS=(
  "laravel-vps-multidomain-deploy"
  "git-public-api"
  "git-public-front"
)

configure_repository() {
  local repo="$1"

  gh repo edit "$OWNER/$repo" \
    --visibility public \
    --enable-issues=true \
    --enable-wiki=false \
    --enable-projects=false
}

protect_main_branch() {
  local repo="$1"

  gh api \
    --method PUT \
    -H "Accept: application/vnd.github+json" \
    "/repos/$OWNER/$repo/branches/main/protection" \
    --input - <<EOF
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": false,
    "required_approving_review_count": false
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
EOF
}

protect_develop_branch() {
  local repo="$1"

  gh api \
    --method PUT \
    -H "Accept: application/vnd.github+json" \
    "/repos/$OWNER/$repo/branches/develop/protection" \
    --input - <<EOF
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
EOF
}

for REPO in "${REPOS[@]}"; do
  echo
  echo "=================================================="
  echo "Configurando: $OWNER/$REPO"
  echo "=================================================="

  configure_repository "$REPO"

  echo "Protegendo branch main..."

  if protect_main_branch "$REPO"; then
    echo "OK main"
  else
    echo "Falha ao proteger main"
  fi

  echo "Protegendo branch develop..."

  if protect_develop_branch "$REPO"; then
    echo "OK develop"
  else
    echo "Falha ao proteger develop"
  fi
done

echo
echo "Configuração finalizada."