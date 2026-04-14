🔱 METATRON - AI-powered penetration testing assistant using local LLM on linux ("Kali GNU/Linux Rolling")


What is Metatron?
Metatron is a CLI-based AI penetration testing assistant that runs entirely on your local machine — no cloud, no API keys, no subscriptions.

You give it a target IP or domain. It runs real recon tools (nmap, whois, whatweb, curl, dig, nikto), feeds all results to a locally running AI model, and the AI analyzes the target, identifies vulnerabilities, suggests exploits, and recommends fixes. Everything gets saved to a MariaDB database with full scan history.

✨ Features
🤖 Local AI Analysis — powered by metatron-qwen via Ollama, runs 100% offline
🔍 Automated Recon — nmap, whois, whatweb, curl headers, dig DNS, nikto
🌐 Web Search — DuckDuckGo search + CVE lookup (no API key needed)
🗄️ MariaDB Backend — full scan history with 5 linked tables
✏️ Edit / Delete — modify any saved result directly from the CLI
🔁 Agentic Loop — AI can request more tool runs mid-analysis
🚫 No API Keys — everything is free and local -📤 Export Reports
Metatron allows you to export scan results into clean, shareable report formats by selecting '2.view history'->select slno and export

📄 PDF — professional vulnerability reports 🌐 HTML — browser-viewable reports
