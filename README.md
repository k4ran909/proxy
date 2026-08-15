# ⚡ FluxNat Rotating Proxy Pool & AI Agent Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Status: Live](https://img.shields.io/badge/Status-Live%20&%20Active-brightgreen)](https://proxy.fluxnat.dev)
[![API: HTTPS](https://img.shields.io/badge/API-HTTPS%20SSL-success)](https://proxy.fluxnat.dev/get/)

An open-source rotating IP proxy tool, multi-language SDK, and specialized **AI Agent Skill (`SKILL.md`)** for Hermes Agent, Antigravity, AutoGen, and custom AI scraping bots powered by the **FluxNat Rotating Proxy Pool** (`https://proxy.fluxnat.dev`).

---

## 🚀 1-Line Quick Install for Any Agent / Project

### Option A: One-Line Terminal Command

#### Linux / macOS / Git Bash:
```bash
curl -fsSL https://raw.githubusercontent.com/k4ran909/proxy/main/install.sh | bash
```

#### Windows (PowerShell):
```powershell
irm https://raw.githubusercontent.com/k4ran909/proxy/main/install.ps1 | iex
```

*This automatically installs the `/proxy` skill globally to `~/.gemini/config/skills/proxy/`, `~/.hermes/skills/proxy/`, and your current project's `.agents/skills/proxy/` directory!*

---

### Option B: One-Line Prompt for Any AI Agent (Hermes, Claude, ChatGPT, Cursor)

Just paste this single prompt to your AI Agent:

```text
Load and follow the proxy skill from: https://raw.githubusercontent.com/k4ran909/proxy/main/skills/proxy/SKILL.md
```

Then trigger it anytime by saying:
> **/proxy** *(e.g. "use /proxy to scrape target URL")*

---

## 🔑 Endpoint Credentials & API Reference

| Endpoint | Method | Description |
| :--- | :--- | :--- |
| `https://proxy.fluxnat.dev/get/` | `GET` | Fetch a single pre-validated, live rotating proxy IP (`IP:PORT`) |
| `https://proxy.fluxnat.dev/count/` | `GET` | Check live pool health & total active proxy count |
| `https://proxy.fluxnat.dev/all/` | `GET` | View JSON list of all active verified proxies |
| `https://proxy.fluxnat.dev/delete/?proxy=IP:PORT` | `GET` | Purge a dead/timed-out proxy from the Redis pool |

* **Authentication**: None required (Open HTTPS API)
* **Protocols**: HTTP & HTTPS
* **Pool Size**: 100+ Live Verified IPs updated 24/7

---

## 💻 Quick Code Integrations

### Python (`requests`)
```python
import requests

def get_proxy():
    return requests.get("https://proxy.fluxnat.dev/get/").json()["proxy"]

proxy_ip = get_proxy()
proxies = {"http": f"http://{proxy_ip}", "https": f"http://{proxy_ip}"}

response = requests.get("https://httpbin.org/ip", proxies=proxies, timeout=10)
print("Outgoing IP:", response.text)
```

### Node.js (`axios`)
```javascript
const axios = require('axios');
const { HttpsProxyAgent } = require('https-proxy-agent');

async function main() {
    const { data } = await axios.get('https://proxy.fluxnat.dev/get/');
    const agent = new HttpsProxyAgent(`http://${data.proxy}`);
    const res = await axios.get('https://httpbin.org/ip', { httpsAgent: agent });
    console.log("Outgoing IP:", res.data);
}
main();
```

### cURL One-Liner
```bash
curl -s -x "http://$(curl -s https://proxy.fluxnat.dev/get/ | grep -oE '"proxy":"[^"]+"' | cut -d'"' -f4)" http://api.ipify.org
```

---

## 📁 Repository Structure

```
├── .agents/skills/proxy/SKILL.md   # Workspace Agent Skill
├── skills/proxy/SKILL.md           # Universal Skill Definition
├── sdk/
│   ├── python/fluxnat_proxy.py    # Python Helper Class
│   └── nodejs/index.js            # Node.js Helper Class
├── examples/                      # Runnable code examples
├── install.sh                     # Unix 1-Line Installer
└── install.ps1                    # Windows 1-Line Installer
```

---

## 📄 License
MIT License. Created and maintained by [k4ran909](https://github.com/k4ran909).
