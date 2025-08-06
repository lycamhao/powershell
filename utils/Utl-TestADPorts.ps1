$ADPorts = @(
    53,   
    88,   
    135,
    389,  
    445,  
    464,  
    3268, 
    3269,
    9389  
)

$DomainController = "192.168.10.244" 

foreach ($port in $ADPorts) {
    $result = Test-NetConnection -ComputerName $DomainController -Port $port -WarningAction SilentlyContinue
    if ($result.TcpTestSucceeded) {
        Write-Host "Port $port on $DomainController is OPEN."
    } else {
        Write-Host "Port $port on $DomainController is CLOSED or UNREACHABLE."
    }
}