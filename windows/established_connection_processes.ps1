# Source - https://stackoverflow.com/q
# Posted by luckman212, modified by community. See post 'Timeline' for change history
# Retrieved 2026-01-17, License - CC BY-SA 3.0

# Build process lookup hashtable for fast O(1) lookups
$processLookup = @{}
Get-Process -IncludeUserName | Where-Object UserName | ForEach-Object {
    $processLookup[$_.Id] = @{
        ProcessName = $_.ProcessName
        UserName    = $_.UserName
    }
}

function CustomGet-NetTCPConnection {
    Set-StrictMode -Version Latest

    # Get established connections with process details
    Get-NetTCPConnection | Where-Object State -EQ 'Established' | ForEach-Object {
        $proc = $processLookup[[int]$_.OwningProcess]
        [PSCustomObject]@{
            RemoteAddress = $_.RemoteAddress
            RemotePort    = $_.RemotePort
            PID           = $_.OwningProcess
            ProcessName   = $proc.ProcessName
            UserName      = $proc.UserName
        }
    } | Sort-Object ProcessName, UserName | Format-Table -AutoSize
}

$customScripts = @{}
$customScripts.Add("CustomGet-NetTCPConnection", [scriptblock]{CustomGet-NetTCPConnection}) | Out-Null

foreach ($pair in $customScripts.GetEnumerator()) {
    try {
        & $pair.Value
    } catch {
        Write-Host "Error running $($pair.Key)"
    }
}