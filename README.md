# Reconizer

Reconizer is a fast and automated reconnaissance tool for bug bounty hunters and penetration testers.  
It combines subdomain discovery, URL harvesting, host lookup, and live probing into a single Bash script.

---

## ✅ Features
- 🕵️ Subdomain enumeration from multiple sources
- 🌐 Historical URL collection using `gau`
- 🔍 DNS host lookup
- 🚦 Live host probing with status code, title, and server info
- 🔁 Combined workflow: subdomain + host scan
- 📦 Automatic output saving

---

## 📌 Requirements

The following tools must be installed:

- `subfinder`
- `sublist3r`
- `anew`
- `gau`
- `httpx` (httpx-toolkit)
- `jq`
- `curl`
- `xargs`
- `host` (`dnsutils` / `bind-utils`)

### 🔧 Install dependencies (Linux)

```bash
sudo apt update && sudo apt install -y jq curl dnsutils

go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

pip install sublist3r
