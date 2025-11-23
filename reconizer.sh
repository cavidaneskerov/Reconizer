#!/bin/bash
domain=""
do_host=false
do_sub=false
do_gau=false
do_subhost=false
do_probe=false

cat << "EOF"

 ____  _____ ___   ___  _   _ ___ ______ _____ ____
|  _ \| ____/  _\ / _ \| \ | |_ _|____  | ____|  _ \
| |_) |  _| | |  | | | |  \| || |    / /|  _| | |_) |
|  _ <| |___| |_ | |_| | |\  || |   / /_| |___|  _ <
|_| \_\_____\___/ \___/|_| \_|___| /____|_____|_| \_\
                        RECONIZER



EOF

while [[ $# -gt 0 ]]; do

case $1 in
  -h|--help)
    cat <<EOF
Usage: reconizer [flags]
   -h, --help         show this help message and exit
   -d, --domain       target domain address
   -s, --sub          perform subdomain enumeration
   -g, --gau          fetch archived URLs using gau
   -t, --host         target host for scanning
   -a, --subhost     subdomain enumaration and run host scan
   -p, --probe        check live hosts and fetch status/tech
EOF
    exit 0
    ;;

  -d|--domain)
    if [[ -z $2 || $2 == -* ]]; then
        echo -e "Specify the target domain.\n"
        echo "Example: ./reconizer.sh -d example.com "
        exit 1
    fi
    domain="$2"
    shift 2
    ;;

  -s|--sub)
    do_sub=true
    shift
    ;;

  -g|--gau)
    do_gau=true
    shift
    ;;

  -p|--probe)
    do_probe=true
    shift
    ;;

  -t|--host)
    if [[ -z $2 || $2 == -* ]]; then
        echo -e "Error: missing or invalid file after -t \n"
        echo "Example: ./reconizer.sh -t file.txt"
        exit 1
    fi
    do_host=true
    file="$2"
    shift 2
    ;;

  -a|--subhost)
    do_subhost=true
    shift
    ;;

  *)
    echo "Unknown flag: $1"
    exit 1
    ;;
esac
done

sub_enum() {
  domain=$1
  #Subfinder
  main=$(subfinder -d $domain -all -cs -silent | tee -a main.txt)
  echo "$main" | cut -d ',' -f 1 > domains.txt

  #Sublist3r
  main=$(sublist3r -d $domain -o sublister.txt 2>&1)
  anew domains.txt < sublister.txt

  #crt.sh
  curl -s "https://crt.sh/?q=${domain}&output=json" | jq -r '.[].name_value' | grep -Po '(\w+\.\w+\.\w+)$' | sort -u | tee -a crt.txt >/dev/null
  anew domains.txt < crt.txt
  rm -f main.txt sublister.txt crt.txt
}
if $do_sub;then
echo "[+] Launching subdomain enumeration for: $domain"
sub_enum $domain
fi
if $do_gau;then
#Gau
echo "[+] Collecting historical URLs using gau for: $domain"
gau $domain | ~/go/bin/httpx -silent | anew urls.txt &>/dev/null 

fi
if $do_host;then
#Hosts
echo "[+] Running host lookup on targets from: $file"
cat $file | xargs -I{} host {} | tee -a host-out.txt
fi

if $do_subhost;then
echo "[+] Performing subdomain discovery and host lookup for: $domain"
sub_enum $domain
cat domains.txt | xargs -I{} host {} | tee -a host-out.txt
fi

if $do_probe;then
#Probe
    if [[ ! -f domains.txt ]]; then
        echo "[+] No domains.txt found — running subdomain enum first..."
        sub_enum $domain
    fi
echo "[+] Checking which hosts are alive and grabbing status/tech info"
cat domains.txt | ~/go/bin/httpx -title -sc -server | tee -a urls.txt
fi
                                                                                                                                                                                                                                            
