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
