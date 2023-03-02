#!/bin/bash
docker-compose \
    -f code/service.yml \
    -f obsidian/service.yml \
    -f ghost/service.yml \
    up -d 

