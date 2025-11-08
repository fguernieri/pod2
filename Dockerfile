FROM nvidia/cuda:12.8.1-cudnn9-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC \
    PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_BREAK_SYSTEM_PACKAGES=1

# 🔧 Dependências do sistema
RUN apt update && apt install -y \
    python3 python3-pip ffmpeg git curl wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# 🔧 Copia os arquivos necessários
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app
COPY models ./models
COPY scripts ./scripts

RUN chmod +x scripts/*.sh

CMD ["bash", "scripts/boot_env.sh"]
