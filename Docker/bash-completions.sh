#!/bin/bash

# This is a half baked attempt at adding bash completions that let you tab through container names
# It needs a little more tweaking methinks.

# Add the following to your ~/.bashrc

Docker completion function for container IDs and names
_docker_container_completion()
{
    local cur_word="${COMP_WORDS[COMP_CWORD]}"
    
    # Fetch a list of running containers: ID and names
    local containers=$(docker ps --format "{{.ID}} {{.Names}}")

    # Generate completions using both container IDs and names
    COMPREPLY=($(compgen -W "$containers" -- "$cur_word"))
}

# Register the completion function for specific Docker commands
complete -F _docker_container_completion docker inspect
complete -F _docker_container_completion docker kill
complete -F _docker_container_completion docker start
complete -F _docker_container_completion docker stop
complete -F _docker_container_completion docker restart
complete -F _docker_container_completion docker exec
complete -F _docker_container_completion docker logs