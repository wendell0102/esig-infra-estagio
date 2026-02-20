FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Pacotes necessarios para os scripts do repo
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    nano \
    htop \
    postgresql \
    postgresql-client \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Diretorio de trabalho padrao do Codespace
WORKDIR /workspaces/esig-infra-estagio
