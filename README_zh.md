# claude-code-nvidia-docker

中文 | [English](README.md)

基于 NVIDIA CUDA 的 Docker 开发环境，预装 Claude Code CLI，支持 VS Code Dev Containers。

## 前置要求

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)（Windows/Mac）或 Docker Engine（Linux）
- 宿主机已安装 [NVIDIA 驱动](https://www.nvidia.com/drivers)
- 已安装 [nvidia-container-toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
- [VS Code](https://code.visualstudio.com/) 及 [Dev Containers 扩展](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/jcsh4326/claude-code-nvidia-docker.git
cd claude-code-nvidia-docker
```

### 2. 构建镜像

**Linux / macOS：**
```bash
chmod +x build_image.sh run_claude.sh
./build_image.sh
```

**Windows：**
```bat
build_image.bat
```

### 3. 启动容器

**Linux / macOS：**
```bash
# 后台模式（推荐，配合 VS Code 使用）
./run_claude.sh -d

# 交互模式
./run_claude.sh
```

**Windows：**
```bat
run_claude.bat -d
```

### 4. 在 VS Code 中附加容器

`Ctrl+Shift+P` → `Dev Containers: Attach to Running Container` → 选择 `claude-workspace`

### 5. 登录 Claude Code

在容器终端中执行：
```bash
claude
```

按提示通过 claude.ai 完成身份验证。

## 代理配置

脚本默认使用 `host.docker.internal:7890` 作为代理地址。如需修改端口或禁用代理，请在构建前编辑以下文件：

- `run_claude.sh` / `run_claude.bat` — 修改 `HTTP_PROXY` / `HTTPS_PROXY` 的值
- `.devcontainer/devcontainer.json` — 修改 `http.proxy` 和 `claudeCode.environmentVariables`

如需完全禁用代理，删除运行脚本中所有 `-e HTTP_PROXY` / `-e HTTPS_PROXY` 相关行即可。

## 在新机器上使用

1. 克隆仓库
2. 执行 `build_image.sh` / `build_image.bat` 构建镜像
3. 启动容器后重新登录 Claude Code

> 认证 token 仅存储在运行中容器的文件系统（`~/.claude/`）内，不会打包进镜像。每台机器需要单独登录。

## 没有 GPU？

删除 `run_claude.sh` / `run_claude.bat` 中的 `--gpus all` 参数，以及 `.devcontainer/devcontainer.json` 的 `runArgs` 中对应的 `"--gpus", "all"` 两行即可。

## 项目结构

```
.
├── dockers/
│   └── Dockerfile          # 镜像定义（CUDA + Node.js 22 + Claude Code）
├── .devcontainer/
│   └── devcontainer.json   # VS Code Dev Container 配置
├── build_image.sh / .bat   # 镜像构建脚本
└── run_claude.sh / .bat    # 容器启动脚本
```
