#!/bin/bash

echo "[+] Starting Reconizer installation..."

# ---- REQUIRE ROOT FOR PACKAGE INSTALLS ----
if [[ $EUID -ne 0 ]]; then
    echo "[!] Please run as root (sudo ./install.sh)"
    exit 1
fi

# ---- DETECT PACKAGE MANAGER ----
if command -v apt >/dev/null 2>&1; then
    PKG="apt"
elif command -v yum >/dev/null 2>&1; then
    PKG="yum"
else
    echo "[!] Supported package manager not found (apt or yum)"
    exit 1
fi

# ---- INSTALL SYSTEM PACKAGES ----
echo "[+] Installing system dependencies..."
$PKG update -y
$PKG install -y jq curl dnsutils python3-pip

# ---- CHECK GO ----
if ! command -v go >/dev/null 2>&1; then
    echo "[!] Go is not installed — please install Go and rerun."
    exit 1
fi

# ---- INSTALL GO TOOLS ----
echo "[+] Installing Go-based tools..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# ---- INSTALL SUBLIST3R ----
echo "[+] Installing Sublist3r..."
pip3 install sublist3r

# ---- UPDATE PATH IF NEEDED ----
if ! grep -q 'export PATH=$PATH:~/go/bin' ~/.bashrc; then
    echo 'export PATH=$PATH:~/go/bin' >> ~/.bashrc
    echo "[+] Added GOPATH to ~/.bashrc (restart terminal to activate)"
fi

# ---- INSTALL RECONIZER SCRIPT ----
echo "[+] Installing reconizer..."
chmod +x reconizer.sh
cp reconizer.sh /usr/local/bin/reconizer

echo ""
echo "✅ Installation complete!"
echo "👉 You can now run:  reconizer -h"
echo ""
