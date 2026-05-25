# claude-code-nvidia-docker

Docker development environment based on NVIDIA CUDA with Claude Code CLI pre-installed, ready for VS Code Dev Containers.

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Windows/Mac) or Docker Engine (Linux)
- [NVIDIA Driver](https://www.nvidia.com/drivers) installed on the host
- [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
- [VS Code](https://code.visualstudio.com/) with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/jcsh4326/claude-code-nvidia-docker.git
cd claude-code-nvidia-docker
```

### 2. Build the image

**Linux / macOS:**
```bash
chmod +x build_image.sh run_claude.sh
./build_image.sh
```

**Windows:**
```bat
build_image.bat
```

### 3. Start the container

**Linux / macOS:**
```bash
# Detached mode (recommended for VS Code)
./run_claude.sh -d

# Interactive mode
./run_claude.sh
```

**Windows:**
```bat
run_claude.bat -d
```

### 4. Attach in VS Code

`Ctrl+Shift+P` → `Dev Containers: Attach to Running Container` → select `claude-workspace`

### 5. Sign in to Claude Code

Inside the container terminal:
```bash
claude
```

Follow the prompts to authenticate via claude.ai.

## Proxy Configuration

The scripts default to `host.docker.internal:7890`. If you use a different proxy port or no proxy at all, edit the following files before building:

- `run_claude.sh` / `run_claude.bat` — `HTTP_PROXY` / `HTTPS_PROXY` values
- `.devcontainer/devcontainer.json` — `http.proxy` and `claudeCode.environmentVariables`

To disable the proxy entirely, remove all `-e HTTP_PROXY` / `-e HTTPS_PROXY` lines from the run scripts.

## Using on a New Machine

1. Clone the repository
2. Build the image with `build_image.sh` / `build_image.bat`
3. Start the container and sign in to Claude Code again

> Authentication tokens are stored only in the running container's filesystem (`~/.claude/`) and are never baked into the image. Each machine requires a separate login.

## No GPU?

Remove `--gpus all` from the `docker run` commands in `run_claude.sh` / `run_claude.bat` and the `runArgs` section in `.devcontainer/devcontainer.json`.

## Project Structure

```
.
├── dockers/
│   └── Dockerfile          # Image definition (CUDA + Node.js 22 + Claude Code)
├── .devcontainer/
│   └── devcontainer.json   # VS Code Dev Container configuration
├── build_image.sh / .bat   # Build scripts
└── run_claude.sh / .bat    # Container run scripts
```
