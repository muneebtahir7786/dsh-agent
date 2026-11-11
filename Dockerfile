 
FROM node:22-slim

# Zaroori system tools install karein
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    bash \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ARM64 ya x86_64 detect karke sahi ttyd binary download karein
RUN ARCH=$(uname -m) && \
    echo "Architecture detected: $ARCH" && \
    if [ "$ARCH" = "x86_64" ]; then \
        wget -q https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 -O /usr/local/bin/ttyd; \
    elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then \
        wget -q https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.aarch64 -O /usr/local/bin/ttyd; \
    else \
        echo "Unsupported architecture: $ARCH"; \
        exit 1; \
    fi && \
    chmod +x /usr/local/bin/ttyd

# DSH ka exact version install karein (taake notarget error na aaye)
RUN npm install -g @deepseek-ai/dsh@0.2.1-rc.2

# Port expose karein aur ttyd terminal start karein
EXPOSE 7860
CMD ["ttyd", "-p", "7860", "-W", "bash"]
