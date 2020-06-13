#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
echo -e "${RED}This setup is not ideal for use in production.${NC}"

/www/webapp/WebApp --urls "http://+:8080" &
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile &
wait
