#!/bin/bash

rm -f raw.txt merged_clean.txt final.txt whitelist.txt

# ===== list =====
urls=(
# =========== IRN
# ===  🟢 Persian -PersianBlocker-Deprecated.txt :: Persian
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlocker-Deprecated.txt"
# ===  🟢 Persian -PersianBlockerAds-Domains.txt:: Persian
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAds-Domains.txt"
# ===  🟢 Persian -PersianBlockerAds-Hosts.txt:: Persian
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAds-Hosts.txt"
# ===  🟢 Persian -PersianBlockerAds.txt:: Persian
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerAds.txt"
# ===  🟢 Persian -PersianBlockerHosts.txt:: Persian
"https://github.com/MasterKia/PersianBlocker/raw/refs/heads/main/PersianBlockerHosts.txt"
# =========== END
)

# ===== download =====
for url in "${urls[@]}"; do
  curl -sL "$url" >> raw.txt
  echo -e "\n" >> raw.txt
done

# ===== clean basic =====
grep -vE '^\s*$' raw.txt | \
grep -vE 'localhost|localdomain|broadcasthost' > cleaned.txt

# ===== remove duplicate =====
sort -u cleaned.txt > merged_clean.txt

# ===== whitelist =====
cat <<EOF > whitelist.txt
# ==== WHITELIST ====
# remove # to enable
# dns.google.com
EOF

# ===== final =====
cat whitelist.txt merged_clean.txt > final.txt

mv final.txt merged.txt

# ===== clean =====
rm raw.txt cleaned.txt merged_clean.txt whitelist.txt
