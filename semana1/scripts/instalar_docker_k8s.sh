#!/bin/bash
set -e

echo "=== Actualizando paquetes ==="
apt update

echo "=== Instalando Docker ==="
apt install -y docker.io
systemctl enable --now docker

echo "=== Instalando kubectl ==="
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "=== Verificando versiones ==="
docker --version
kubectl version --client

echo "=== Instalación completa ==="
