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

# npm cache ke liye writable directory set karein (EACCES error se bachne ke liye)
ENV npm_config_cache=/tmp/.npm

# DSH ko npx ke zariye chalayein taake global install ki zaroorat na pade
EXPOSE 7860
CMD ["npx", "-y", "@deepseek-ai/dsh", "web", "--port", "7860", "--host", "0.0.0.0"]
