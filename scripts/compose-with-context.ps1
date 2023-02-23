if($env:COMPOSE_CURRENT_CONTEXT){
    docker compose -p $env:COMPOSE_CURRENT_CONTEXT $args
}
else
{
    "COMPOSE_CURRENT_CONTEXT env var is not set!"
    exit 1
}
