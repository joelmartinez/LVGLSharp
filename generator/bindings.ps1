& "$PSScriptRoot\init.ps1"

if (-not(Get-Command -Name c2cs -ErrorAction SilentlyContinue)) {
    dotnet tool install bottlenoselabs.c2cs.tool --global 
}

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
push-location $scriptPath

$c2csConfig = "./c2cs-config-win.json"

if ($IsMacOS) {
    $c2csConfig = "./c2cs-config-mac.json"
}

c2cs generate --config $c2csConfig

cp ./LVGLSharp.csproj ./tmp/LVGLSharp/LVGLSharp.csproj

$genPath = "./tmp/LVGLSharp/LVGL.gen.cs"

# work around due to https://github.com/bottlenoselabs/c2cs/issues/155
$r = (Get-Content -Path $genPath) -replace 'public static (_?lv_.*_t) (LV_.*) = (\d+);', 'public static $1 $2 = ($1)$3;'
$r | Set-Content -Path $genPath


pop-location