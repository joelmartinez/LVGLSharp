$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
push-location $scriptPath


if (test-path -path 'tmp')
{
    echo "🪓 Deleting tmp directory"
    Remove-Item -Path 'tmp' -Recurse -Force
}

if (test-path -path 'bin')
{
    echo "🪓 Deleting bin directory"
    Remove-Item -Path 'bin' -Recurse -Force
}

if (test-path -path 'obj')
{
    echo "🪓 Deleting obj directory"
    Remove-Item -Path 'obj' -Recurse -Force
}

pop-location
echo "✅ Cleaned up"
