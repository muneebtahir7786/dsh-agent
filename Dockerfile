FROM node:22-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl wget bash \
    && wget -q https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 -O /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd \
    && rm -rf /var/lib/apt/lists/*
RUN npm install -g @deepseek-ai/dsh
EXPOSE 7860
CMD ["ttyd", "-p", "7860", "-W", "bash"]
