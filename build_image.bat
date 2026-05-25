@echo off
setlocal

set IMAGE_NAME=claude-dev
set DOCKERFILE_DIR=%~dp0dockers

echo Building Docker image: %IMAGE_NAME%
docker build -t %IMAGE_NAME% %DOCKERFILE_DIR%
if %errorlevel% neq 0 (
    echo Build failed.
    exit /b %errorlevel%
)
echo Build complete. Run with: docker run --gpus all -it --rm -v "%cd%:/workspace" %IMAGE_NAME%

endlocal
