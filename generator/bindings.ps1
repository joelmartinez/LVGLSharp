& "$PSScriptRoot\init.ps1"

if (-not(Get-Command -Name c2cs -ErrorAction SilentlyContinue)) {
    dotnet tool install bottlenoselabs.c2cs.tool --global 
}

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
push-location $scriptPath

c2cs generate --config ./config-cs.json

cp ./LVGLSharp.csproj ./tmp/LVGLSharp/LVGLSharp.csproj

pop-location