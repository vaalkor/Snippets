param(
    [switch]$Container,
    [switch]$Images,
    [string]$Filter,
    [switch]$NoAction,
    [switch]$All
    #TODO: Add restart, kill commands with confirmation and filter!
)

function Confirm($text)
{
    $yesValues = 'y','Y','yes','YES'
    $noValues = 'n','N','no','NO'
    while($True){
        $userInput = Read-Host -Prompt "$text (Press Y or N)"
        if($yesValues.Contains($userInput)){
            return $true
        }
        if($noValues.Contains($userInput)){
            return $false
        }
    }
}

function GetAction($actions){
    Write-Host "Choose an action"
    $actions | %{ Write-Host "- $($_)"}
    while($True){
        $userInput = Read-Host -Prompt "Choose an action"
        if(-not $actions.Contains($userInput)){
            continue
        }
        return $userInput
    }
}

function GetConfirmedAction($actions){
    while($True){
        $action = GetAction $actions
        if(Confirm "Are you sure you want to $action"){
            return $action
        }
    }
}

function GetIndices($promptText, $items)
{
    while($True)
    {
        $userInput = Read-Host -Prompt $promptText
        $indices = $userInput.Split(" ") | %{$_.Trim()} | ?{$_}
        if(-not $indices -or $indices.Count -eq 0){
            Write-Host "Nothing selected!"
            continue
        }
        $indices = $indices | Sort-Object | Get-Unique
        if( $indices | ?{-not ($items | %{$_.' '}).Contains($_) }){
            Write-Host "Invalid selections. Choose properly you doofus."
            continue
        }
        return $indices
    }
}

function AddIndices($items)
{
    $index = 1;
    $items | %{
        $_ | Add-Member -MemberType NoteProperty -Name ' ' -Value "$index" -Force
        $index++
    }
}

function ApplyContainerAction($containers, $action)
{
    $containers | %{
        "Applying action for $($_.Names)"
        if($action -eq 'restart'){ 
            docker container restart $_.Names
        }
        elseif($action -eq 'kill'){ 
            docker container kill $_.Names
        }
        elseif($action -eq 'logs'){ 
            docker container logs $_.Names
        }
        elseif($action -eq 'remove'){ 
            docker container rm $_.Names
        }
        elseif($action -eq 'stop'){ 
            docker container stop $_.Names
        }
        elseif($action -eq 'exec'){ 
            docker container exec -it $_.Names /bin/bash
        }
    }
}

function LineBreak(){ Write-Host "=========================" }

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

if($Container)
{
    $containerArgs = 'ls', '--format', "`"{{json .}}`""
    if($All){
        $containerArgs += "-a"
    }
    $containers = docker container $containerArgs | ConvertFrom-Json
    if($Filter){
        $containers = $containers | ?{$_.Names -match $Filter}
    }
    if($containers.Count -eq 0){
        "No containers running or match provided filter."
        exit 0
    }

    AddIndices $containers
    $containers | Format-Table -Property ' ', Names, State, Image, Id, Status
    if($NoAction) {exit 0 }

    $indexes = GetIndices 'Select containers to kill, restart, logs, exec etc...' $containers
    $containers = $containers | ?{$indexes.Contains($_.' ')}

    LineBreak
    "Selected containers:"
    $containers | %{"- $($_.Names)"}
    LineBreak

    $action = GetAction 'kill', 'restart', 'logs', 'exec', 'inspect', 'remove', 'stop'
    LineBreak
    "Confirmed action: $action"
    ApplyContainerAction $containers $action
    exit 0
}


if($Images)
{
    docker image ls --format "{{json .}}" | ConvertFrom-Json | Format-Table -Property Repository, Tag, ID, Size, CreatedAt
    exit 0
}
