# 1. 基础镜像：推荐使用 NVIDIA 官方维护的深度学习/CUDA 基础开发环境
# 你也可以换成包含特定 PyTorch 版本的镜像，如 nvcr.io/nvidia/pytorch:24.01-py3
FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

# 2. 设置免交互（防止 apt 弹出地区和时间选择阻断构建）
ENV DEBIAN_FRONTEND=noninteractive

# 3. 安装系统依赖工具
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    openssh-client \
    ca-certificates \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 4. 在 Ubuntu 环境中安全安装 Node.js 22 (Claude Code 所需)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# 5. 全局安装 Claude Code CLI
RUN npm install -g @anthropic-ai/claude-code

# 6. 设置 python / pip 别名
RUN ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip

# 7. 配置工作目录
WORKDIR /workspace

# 默认启动终端（提示配置 API Key）
CMD ["/bin/bash", "-c", "echo '请先运行: export ANTHROPIC_API_KEY=your_key' && /bin/bash"]
