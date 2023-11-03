& "$PSScriptRoot\init.ps1"

if (-not(Get-Command -Name c2cs -ErrorAction SilentlyContinue)) {
    dotnet tool install bottlenoselabs.c2cs.tool --global 
}

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
push-location $scriptPath

$c2csConfig = "./config-win.json"

if ($IsMacOS) {
    $c2csConfig = "./config-mac.json"
}

c2cs generate --config $c2csConfig

cp ./LVGLSharp.csproj ./tmp/LVGLSharp/LVGLSharp.csproj

pop-location