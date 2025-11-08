#!/bin/bash
set -e
echo "🚀 Iniciando ambiente..."
cd /workspace/app
uvicorn main:app --host 0.0.0.0 --port 8000
