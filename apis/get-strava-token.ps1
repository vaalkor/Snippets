# https://developers.strava.com/docs/getting-started/#:~:text=Access%20tokens%20are%20required%20for,tokens%20expire%20every%20six%20hours.

Param(
    [Parameter(Mandatory = $true)]
    [string]$CLIENT_ID
)

Start-Process "http://www.strava.com/oauth/authorize?client_id=$CLIENT_ID&response_type=code&redirect_uri=http://localhost/exchange_token&approval_prompt=force&scope=activity:read_all"
