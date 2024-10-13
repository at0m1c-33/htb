# ==========================================
#          Discord VPN Configuration
# ==========================================

# Function to display a header
function Show-Header {
    $header = @"
+-------------------------------------------+
|       Discord VPN Configuration           |
+-------------------------------------------+
"@
    Write-Host $header -ForegroundColor Green
}

# Function to display a footer
function Show-Footer {
    $footer = @"
+-------------------------------------------+
|       Configuration Complete              |
+-------------------------------------------+
"@
    Write-Host $footer -ForegroundColor Green
}

# Display header
Show-Header

# Check for Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Write-Host "Administrator privileges required. Relaunching..." -ForegroundColor Red
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
} else {
    Write-Host "Administrator privileges confirmed." -ForegroundColor Green
}

# Check for certificate 'Home VPN CA' in Trusted Root Certification Authorities
Write-Host "Checking for 'Home VPN CA' certificate..." -ForegroundColor Green
$cert = Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object { $_.Subject -like "*Home VPN CA*" }

if (-not $cert) {
    Write-Host "Certificate 'Home VPN CA' not found. Please install it before proceeding." -ForegroundColor Red
    Exit
} else {
    Write-Host "Certificate 'Home VPN CA' found." -ForegroundColor Green
}

# Check if VPN connection 'Discord VPN' exists
Write-Host "Checking if 'Discord VPN' connection exists..." -ForegroundColor Green
$vpnConnection = Get-VpnConnection -Name "Discord VPN" -ErrorAction SilentlyContinue

if (-not $vpnConnection) {
    Write-Host "Creating 'Discord VPN' connection..." -ForegroundColor Green
    Add-VpnConnection -Name "Discord VPN" `
        -ServerAddress "194.164.58.151" `
        -TunnelType "IKEv2" `
        -AuthenticationMethod "EAP" `
        -EncryptionLevel "Maximum" `
        -RememberCredential `
        -Force
    Write-Host "VPN ciphers and split tunneling configured." -ForegroundColor Green
} else {
    Write-Host "'Discord VPN' connection exists." -ForegroundColor Green
}

# Check if VPN is connected
Write-Host "Checking if 'Discord VPN' is connected..." -ForegroundColor Green
$vpnConnection = Get-VpnConnection -Name "Discord VPN"

if ($vpnConnection.ConnectionStatus -ne 'Connected') {
    Write-Host "VPN is not connected. Please connect manually and rerun the script." -ForegroundColor Red
    Exit
} else {
    Write-Host "VPN is connected." -ForegroundColor Green
}

# Define the file paths
$filePath1 = "https://raw.githubusercontent.com/GhostRooter0953/discord-voice-ips/master/regions/russia/russia-voice-domains"
$filePath2 = "https://raw.githubusercontent.com/GhostRooter0953/discord-voice-ips/master/discord-domains-list"

# Retrieve and combine domain lists
Write-Host "Retrieving domain lists..." -ForegroundColor Green
$domains1 = Invoke-WebRequest -Uri $filePath1 -UseBasicParsing | Select-Object -ExpandProperty Content
$domains2 = Invoke-WebRequest -Uri $filePath2 -UseBasicParsing | Select-Object -ExpandProperty Content
$domains = ($domains1 + $domains2).Split([Environment]::NewLine) | Where-Object { $_ -ne '' } | Select-Object -Unique

Write-Host "Total domains to process: $($domains.Count)" -ForegroundColor Green

# Process each domain
foreach ($domain in $domains) {
    Write-Host "Processing domain: $domain" -ForegroundColor Green
    $ips = Resolve-DnsName $domain -ErrorAction SilentlyContinue | Where-Object { $_.QueryType -eq 'A' } | Select-Object -ExpandProperty IPAddress

    foreach ($ip in $ips) {
        Write-Host "Adding IPv4 route for IP: $ip" -ForegroundColor Green
        $command = "route add $ip MASK 255.255.255.255 194.164.58.151 METRIC 1"
        Invoke-Expression $command
        Write-Host "IPv4 route added for $ip" -ForegroundColor Green
    }
}

# Display footer
Show-Footer
