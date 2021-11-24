cat (Get-PSReadlineOption).HistorySavePath

# Nifty way of reversing a stream of items. Uses funky scope parameter $script
# https://stackoverflow.com/questions/22771724/reverse-elements-via-pipeline
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-7
$thing | Sort-Object {(--$script:i)}