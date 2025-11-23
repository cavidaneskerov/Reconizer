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


## 📥 Installation

```bash
git clone https://github.com/cavidaneskerov/Reconizer
cd Reconizer
chmod +x reconizer.sh

```
---
## 🧪 Usage Examples

### 🔹 Subdomain Enumeration

```bash
./reconizer.sh -d example.com -s
```
### 🔹 Collect Archived URLs with gau

```bash
./reconizer.sh -d example.com -g
```
