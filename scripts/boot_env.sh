#!/bin/bash
echo "🚀 Iniciando ambiente..."

mkdir -p /workspace

# Copia o app pro volume persistente se estiver vazio
if [ -z "$(ls -A /workspace 2>/dev/null)" ]; then
    echo "🧩 Workspace vazio — copiando código da imagem..."
    cp -r /app/* /workspace/
else
    echo "✅ Workspace já possui arquivos — não é necessário copiar."
fi

# Usa /app direto (onde o código existe de fato)
cd /app || {
    echo "❌ Erro: diretório /app não encontrado."
    exit 1
}

echo "📂 Estrutura atual:"
ls -la /app/app

# Cria __init__.py se faltar (necessário para FastAPI importar o pacote)
if [ ! -f /app/app/__init__.py ]; then
    echo "⚙️ Criando __init__.py..."
    touch /app/app/__init__.py
fi

# Inicia o FastAPI corretamente
echo "🚀 Iniciando aplicação na porta 8090..."
uvicorn app.main:app --host 0.0.0.0 --port 8090
