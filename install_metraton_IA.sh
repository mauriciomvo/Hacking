#!/bin/bash

# ==============================================================================
# METATRON - INSTALADOR E GUIA DE EXECUÇÃO
# ==============================================================================
# COMO RODAR APÓS A INSTALAÇÃO:
#
# TERMINAL 1 (Servidor de IA):
#   ollama serve
#
# TERMINAL 2 (Execução do Metatron):
#   cd ~/METATRON
#   source venv/bin/activate
#   ollama pull huihui_ai/qwen3.5-abliterated:9b  (Só precisa na primeira vez)
#   ollama create metatron-qwen -f Modelfile      (Só precisa na primeira vez)
#   python3 metatron.py
# ==============================================================================

# Garantir que o script rode como root
if [ "$EUID" -ne 0 ]; then 
  echo "Por favor, rode como root (sudo ./install_metatron.sh)"
  exit
fi

echo "--- Iniciando Instalação Completa do METATRON ---"

# 1. Dependências do Sistema
echo "[*] Instalando ferramentas de recon, MariaDB e Python..."
apt update
apt install -y nmap whois whatweb curl dnsutils nikto mariadb-server python3-venv python3-pip git

# 2. Configuração do MariaDB
echo "[*] Configurando banco de dados..."
systemctl start mariadb
systemctl enable mariadb

# Configuração completa do banco, usuário e TODAS as tabelas
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS metatron;
CREATE USER IF NOT EXISTS 'metatron'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON metatron.* TO 'metatron'@'localhost';
FLUSH PRIVILEGES;
USE metatron;

-- 1. Tabela de Histórico
CREATE TABLE IF NOT EXISTS history (
    sl_no INT AUTO_INCREMENT PRIMARY KEY,
    target VARCHAR(255) NOT NULL,
    scan_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50),
    results LONGTEXT,
    ai_analysis LONGTEXT
);

-- 2. Tabela de Sumário
CREATE TABLE IF NOT EXISTS summary (
    sl_no INT PRIMARY KEY,
    raw_scan LONGTEXT,
    ai_analysis LONGTEXT,
    risk_level VARCHAR(50),
    generated_at DATETIME,
    FOREIGN KEY (sl_no) REFERENCES history(sl_no) ON DELETE CASCADE
);

-- 3. Tabela de Vulnerabilidades (O que faltava agora)
CREATE TABLE IF NOT EXISTS vulnerabilities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sl_no INT,
    vulnerability TEXT,
    severity VARCHAR(50),
    description TEXT,
    remediation TEXT,
    FOREIGN KEY (sl_no) REFERENCES history(sl_no) ON DELETE CASCADE
);
EOF

# 3. Ambiente Python
echo "[*] Configurando ambiente virtual..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi
source venv/bin/activate
pip install -r requirements.txt

# 4. Ollama
if ! command -v ollama &> /dev/null; then
    echo "[*] Instalando Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo "[+] Ollama já está instalado."
fi

echo ""
echo "--- TUDO PRONTO! ---"
echo "Siga as instruções no topo deste script para iniciar os terminais."
