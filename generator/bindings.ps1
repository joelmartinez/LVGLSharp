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
mkdir build
cd build
cmake -DBUILD_SHARED_LIBS=TRUE ..
make

pop-location
pop-location