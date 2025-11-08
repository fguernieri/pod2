#!/bin/bash
echo "🚀 Iniciando ambiente..."

mkdir -p /workspace

if [ -z "$(ls -A /workspace 2>/dev/null)" ]; then
    echo "🧩 Workspace vazio — copiando código da imagem..."
    cp -r /app/* /workspace/
else
    echo "✅ Workspace já possui arquivos — não é necessário copiar."
fi

cd /workspace/app || cd /workspace || {
    echo "❌ Erro: diretório /workspace/app não encontrado."
    exit 1
}

echo "📂 Estrutura atual:"
ls -la /workspace/app

echo "🚀 Iniciando aplicação na porta 8090..."
uvicorn app.main:app --host 0.0.0.0 --port 8090
