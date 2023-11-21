& "$PSScriptRoot\init.ps1"

if (-not(Get-Command -Name c2cs -ErrorAction SilentlyContinue)) {
    dotnet tool install bottlenoselabs.c2cs.tool --global 
}
else {
    echo "✅ c2cs already installed"
    echo "⬆️ updating c2cs to the latest version"
    dotnet tool update bottlenoselabs.c2cs.tool --global 
}

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
push-location $scriptPath

$c2csConfig = "./c2cs-config-win.json"

if ($IsMacOS) {
    $c2csConfig = "./c2cs-config-mac.json"
}

c2cs generate --config $c2csConfig

cp ./LVGLSharp.csproj ./tmp/LVGLSharp/LVGLSharp.csproj

# compile lvgl
push-location ./tmp/lvgl

# https://docs.lvgl.io/8.3/get-started/platforms/arduino.html#configure-lvgl
$confPath = "./src/lv_conf.h"

cp ./lv_conf_template.h $confPath
$r = (Get-Content -Path $confPath) -replace '#if 0', '#if 1'
$r | Set-Content -Path $confPath

# now run cmake
mkdir build
cd build
cmake -DBUILD_SHARED_LIBS=TRUE ..
make

pop-location
pop-location