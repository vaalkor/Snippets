param(
    [switch]$List,
    # [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]$Stack,
    # [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]$ComposeContext
    #TODO: Add restart, kill commands with confirmation and filter!
)

if($ComposeContext){
    "Setting COMPOSE_CURRENT_CONTEXT env var to $ComposeContext"
    $env:COMPOSE_CURRENT_CONTEXT = $ComposeContext
    exit 0
}

if($List -and $Stack)
{
    $psJson = docker compose -p "$Stack" ps --format json | ConvertFrom-Json
    $psJson | Select-Object -Property Service, State
    exit 0
}

if($List)
{
    $composeList = docker compose ls --format json | ConvertFrom-Json
    $composeList | %{
        $services = docker compose -f "$($_.ConfigFiles)" ps --format json | ConvertFrom-Json
        "$($_.Name): $($_.ConfigFiles)"
        $services | Select-Object -Property Service, State
        "`n========================="
    }
    exit 0
}
