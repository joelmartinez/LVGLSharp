# LVGLSharp

This project is a .NET port of [LVGL](https://github.com/lvgl/lvgl). It
works by generating the API interface from the C headers.

## Dependencies

- git - https://git-scm.com
- dotnet 7.x - https://dotnet.microsoft.com/
- Powershell 7.x - https://learn.microsoft.com/PowerShell

## Initializing

Run the powershell script at `generator/init.ps1` in a terminal running _Powershell_. This script will verify that all dependencies are installed such as [CAstFfi](https://github.com/bottlenoselabs/CAstFfi), and then fetch the LVGL source and generate the AST definition file in `/tmp/ast`

## Generating dotnet API from Headers

Run the powershell script at `generator/bindings.ps1`. This script will also call the `init` script, and then ensure that [c2cs](https://github.com/bottlenoselabs/c2cs) is installed. It will subsequently generate the C# bindings which you can find in the `/generator/tmp/LVGLSharp` folder.

## Cleanup

```powershell
PS > ./generator/cleanup.ps1
```