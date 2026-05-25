@echo off
setlocal

set IMAGE_NAME=claude-dev
set CONTAINER_NAME=claude-workspace
set DETACH=false

if "%1"=="-d" set DETACH=true
if "%1"=="--detach" set DETACH=true

if not "%1"=="" if not "%1"=="-d" if not "%1"=="--detach" (
    echo Usage: run_claude.bat [-d ^| --detach]
    echo   -d, --detach    Detached mode ^(background, for VS Code Dev Containers^)
    exit /b 1
)

if "%ANTHROPIC_API_KEY%"=="" (
    echo Warning: ANTHROPIC_API_KEY is not set. Claude Code will not work without it.
    echo You can set it with: set ANTHROPIC_API_KEY=your_key
)

if "%DETACH%"=="true" (
    docker run -d -it ^
        --name %CONTAINER_NAME% ^
        --gpus all ^
        -e ANTHROPIC_API_KEY=%ANTHROPIC_API_KEY% ^
        -e HTTP_PROXY=http://host.docker.internal:7890 ^
        -e HTTPS_PROXY=http://host.docker.internal:7890 ^
        -e NO_PROXY=localhost,127.0.0.1 ^
        -v "%cd%:/workspace" ^
        %IMAGE_NAME%
    echo Container '%CONTAINER_NAME%' started in background.
    echo In VS Code: Ctrl+Shift+P -^> "Attach to Running Container" -^> %CONTAINER_NAME%
    echo To stop: docker stop %CONTAINER_NAME% ^&^& docker rm %CONTAINER_NAME%
) else (
    docker run --rm -it ^
        --gpus all ^
        -e ANTHROPIC_API_KEY=%ANTHROPIC_API_KEY% ^
        -e HTTP_PROXY=http://host.docker.internal:7890 ^
        -e HTTPS_PROXY=http://host.docker.internal:7890 ^
        -e NO_PROXY=localhost,127.0.0.1 ^
        -v "%cd%:/workspace" ^
        %IMAGE_NAME%
)

endlocal
