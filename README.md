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
chmod +x install.sh
./install.sh

```
---
## 🧪 Usage Examples

### 🔹 Subdomain Enumeration

```bash
reconizer -d example.com -s
```
### 🔹 Collect Archived URLs with gau

```bash
reconizer -d example.com -g
```
### 🔹 Run Host Lookup on a File

```bash
reconizer -t targets.txt
```
targets.txt example:
```bash
www.example.com
api.example.com
mail.example.com
```
### 🔹 Probe Only (domains.txt Already Exists)
```bash
reconizer -d example.com -p
```

### 🔹 Full Workflow (Subdomain Enum + Probe)

```bash
reconizer -d example.com -s -p
```
### 🔹 Automatic Subdomain + Host Scan

```bash
reconizer -d example.com -a
```

### Disclaimer
This tool is for educational and authorized security testing only.
Do not use it on systems you do not own or have permission to test.

