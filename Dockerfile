FROM node:lts-slim

# 作業ディレクトリを /app に設定
WORKDIR /app

# シェルを bash に変更
RUN apt-get update && apt-get install -y bash \
    && rm -rf /var/lib/apt/lists/* \
    && chsh -s /bin/bash node

# 5173番ポートを公開（Vite用）
EXPOSE 5173

# Bash をデフォルトのシェルとして使用
CMD ["bash"]
