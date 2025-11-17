#!/usr/bin/env bash
# ~/.dotfiles/cheat.sh
# Quick reference for common daily commands

# Colors
BOLD='\033[1m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
MAGENTA='\033[0;35m'
BLUE='\033[0;34m'
RESET='\033[0m'

echo -e "${BOLD}${CYAN}╔════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${CYAN}║             🚀  Quick Command Reference                   ║${RESET}"
echo -e "${BOLD}${CYAN}╚════════════════════════════════════════════════════════════╝${RESET}"
echo ""

# Navigation
echo -e "${BOLD}${GREEN}📁 Navigation:${RESET}"
echo -e "  ${YELLOW}cdev${RESET}             → ~/workspace"
echo -e "  ${YELLOW}cwork${RESET}            → ~/workspace/work"
echo -e "  ${YELLOW}cper${RESET}             → ~/workspace/personal"
echo -e "  ${YELLOW}cexp${RESET}             → ~/workspace/experiments"
echo -e "  ${YELLOW}cproj <name>${RESET}     → Jump to project in any workspace area"
echo ""

# Git
echo -e "${BOLD}${GREEN}🌿 Git:${RESET}"
echo -e "  ${YELLOW}gs${RESET}               → git status"
echo -e "  ${YELLOW}gb${RESET}               → git branch"
echo -e "  ${YELLOW}gl${RESET}               → git log --oneline --graph --decorate"
echo ""

# Docker - Containers
echo -e "${BOLD}${GREEN}🐳 Docker - Containers:${RESET}"
echo -e "  ${YELLOW}docker ps${RESET}                     → List running containers"
echo -e "  ${YELLOW}docker ps -a${RESET}                  → List all containers"
echo -e "  ${YELLOW}docker run -d -p 8080:80 <img>${RESET} → Run container in background"
echo -e "  ${YELLOW}docker exec -it <name> bash${RESET}   → Shell into running container"
echo -e "  ${YELLOW}docker logs -f <name>${RESET}         → Follow container logs"
echo -e "  ${YELLOW}docker stop <name>${RESET}            → Stop container"
echo -e "  ${YELLOW}docker rm <name>${RESET}              → Remove container"
echo ""

# Docker Compose
echo -e "${BOLD}${GREEN}🔧 Docker Compose:${RESET}"
echo -e "  ${YELLOW}docker compose up -d${RESET}          → Start services in background"
echo -e "  ${YELLOW}docker compose down${RESET}           → Stop and remove containers"
echo -e "  ${YELLOW}docker compose logs -f${RESET}        → Follow all service logs"
echo -e "  ${YELLOW}docker compose ps${RESET}             → List running services"
echo ""

# System
echo -e "${BOLD}${GREEN}🛠️  System:${RESET}"
echo -e "  ${YELLOW}ll${RESET}               → ls -alF (detailed list)"
echo -e "  ${YELLOW}docker system prune -a${RESET}    → Clean up Docker (images, containers, etc.)"
echo ""

echo -e "${BOLD}${BLUE}💡 Tip: Edit ~/.dotfiles/docker-cheat.sh to customize this list${RESET}"
echo ""
