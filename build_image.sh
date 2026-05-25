#!/usr/bin/env bash
set -e

IMAGE_NAME="claude-dev"
DOCKERFILE_DIR="$(dirname "$0")/dockers"

echo "Building Docker image: ${IMAGE_NAME}"
docker build -t "${IMAGE_NAME}" "${DOCKERFILE_DIR}"
echo "Build complete. Run with: docker run --gpus all -it --rm -v \"\$(pwd):/workspace\" ${IMAGE_NAME}"
