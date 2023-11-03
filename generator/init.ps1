$tmp_path = "tmp"
$lvgl_path = "lvgl"

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
push-location $scriptPath

## Verify Dependencies
if ($IsLinux) {
    echo "❌ Linux is not supported ... yet"
    Exit
}

if ($IsWindows) {
    winget install -i LLVM.LLVM
}

if (-not(Get-Command -Name castffi -ErrorAction SilentlyContinue)) {
    dotnet tool install bottlenoselabs.castffi.tool -g
}
else 
{
    echo "✅ castffi already installed"
}

if (-not(Get-Command -Name git -ErrorAction SilentlyContinue)) {
    echo "❌ must install git"
    Exit
}
else 
{
    echo "✅ git already installed"
}

### Fetch and Generate Header artifacts
if (-not(test-path -path $tmp_path)) {
    mkdir $tmp_path
}

if (-not (test-path -path $lvgl_path)) {
    echo "⬇️ Cloning the lvgl repo's src directory"
    cd tmp
    git clone --filter=blob:none --sparse https://github.com/lvgl/lvgl
    cd $lvgl_path
    git sparse-checkout add src
    cd ../..
}
else {
    echo "✅ LVGL path already exists. Skipping clone."
}

cd $tmp_path
$platform = "windows"
if ($IsMacOS) {
    $platform = "macos"
}
$castffi_path = "../config-"+ $platform +".json"
castffi extract --config $castffi_path
if (test-path -path "ast") {
    Remove-Item -Path 'ast' -Recurse -Force
}
mv ../ast ./
cd ../
pop-location
echo "✅ done!"
