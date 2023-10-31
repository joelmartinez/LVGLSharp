$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
push-location $scriptPath


if (test-path -path 'tmp')
{
    echo "🪓 Deleting tmp directory"
    Remove-Item -Path 'tmp' -Recurse -Force
}

pop-location
echo "✅ Cleaned up"
