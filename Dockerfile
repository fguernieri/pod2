FROM nvidia/cuda:13.0.2-cudnn-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC \
    PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_BREAK_SYSTEM_PACKAGES=1

# 🔧 Dependências do sistema
RUN apt update && apt install -y \
    python3 python3-pip ffmpeg git curl wget \
    && rm -rf /var/lib/apt/lists/*

# Diretório principal do app (fora do volume do RunPod)
WORKDIR /app

# Copia o requirements e instala libs Python
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Copia o código-fonte e scripts
COPY app ./app
COPY models ./models
COPY scripts ./scripts

# Garante permissão de execução nos scripts
RUN chmod +x /app/scripts/*.sh

# Cria o volume persistente (caso não exista)
VOLUME ["/workspace"]

# 🔁 Comando padrão: executa boot_env.sh ou outro via variável START_CMD
CMD ["bash", "-c", "${START_CMD:-/app/scripts/boot_env.sh}"]
