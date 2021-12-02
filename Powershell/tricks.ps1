code (Get-PSReadlineOption).HistorySavePath

# Nifty way of reversing a stream of items. Uses funky scope parameter $script
# https://stackoverflow.com/questions/22771724/reverse-elements-via-pipeline
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-7
$thing | Sort-Object {(--$script:i)}

#Subtle pipeline behaviors

@(@(1,2,3,4,5)) | measure # Count == 5
,(@(1,2,3,4,5)) | measure # Count == 1


@(@(1,2), @(1,2), @(1,2)) | %{ $_ } | measure # Count == 6
@(@(1,2), @(1,2), @(1,2)) | %{, $_ } | measure # Count == 3
