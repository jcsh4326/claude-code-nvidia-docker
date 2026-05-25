#!/usr/bin/env bash
set -e

IMAGE_NAME="claude-dev"
CONTAINER_NAME="claude-workspace"
WORKSPACE="$(pwd)"
DETACH=false

usage() {
    echo "Usage: $0 [-d]"
    echo "  -d    Detached mode (background, for VS Code Dev Containers)"
    exit 1
}

while getopts "d" opt; do
    case $opt in
        d) DETACH=true ;;
        *) usage ;;
    esac
done

if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "Warning: ANTHROPIC_API_KEY is not set. Claude Code will not work without it."
    echo "You can set it with: export ANTHROPIC_API_KEY=your_key"
fi

if [ "$DETACH" = true ]; then
    docker run -d -it \
        --name "${CONTAINER_NAME}" \
        --gpus all \
        -e ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY}" \
        -e HTTP_PROXY=http://host.docker.internal:7890 \
        -e HTTPS_PROXY=http://host.docker.internal:7890 \
        -e NO_PROXY=localhost,127.0.0.1 \
        -v "${WORKSPACE}:/workspace" \
        "${IMAGE_NAME}"
    echo "Container '${CONTAINER_NAME}' started in background."
    echo "In VS Code: Ctrl+Shift+P -> 'Attach to Running Container' -> ${CONTAINER_NAME}"
    echo "To stop: docker stop ${CONTAINER_NAME} && docker rm ${CONTAINER_NAME}"
else
    docker run --rm -it \
        --gpus all \
        -e ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY}" \
        -e HTTP_PROXY=http://host.docker.internal:7890 \
        -e HTTPS_PROXY=http://host.docker.internal:7890 \
        -e NO_PROXY=localhost,127.0.0.1 \
        -v "${WORKSPACE}:/workspace" \
        "${IMAGE_NAME}"
fi
