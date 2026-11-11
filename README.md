FROM node:22-slim

# System dependencies install karein
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    bash \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Architecture detect karein aur uske mutabiq ttyd download karein
RUN ARCH=$(uname -m) && \
    echo "Architecture: $ARCH" && \
    if [ "$ARCH" = "x86_64" ]; then \
        echo "Downloading ttyd for x86_64"; \
        wget -q https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 -O /usr/local/bin/ttyd; \
    elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then \
        echo "Downloading ttyd for ARM64"; \
        wget -q https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.aarch64 -O /usr/local/bin/ttyd; \
    else \
        echo "Unsupported architecture: $ARCH"; \
        exit 1; \
    fi && \
    chmod +x /usr/local/bin/ttyd

# DeepSeek Harness install karein
RUN npm install -g @deepseek-ai/dsh

# Port expose karein
EXPOSE 7860

# ttyd terminal start karein
CMD ["ttyd", "-p", "7860", "-W", "bash"]
