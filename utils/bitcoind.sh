# Login as root
sudo su
# Download Bicoin Core
wget https://bitcoincore.org/bin/bitcoin-core-22.0/bitcoin-22.0-x86_64-linux-gnu.tar.gz
# Download and verify shasums
wget https://bitcoincore.org/bin/bitcoin-core-22.0/SHA256SUMS
wget https://bitcoincore.org/bin/bitcoin-core-22.0/SHA256SUMS.asc
sha256sum --ignore-missing --check SHA256SUMS
# Download all the signatures from the builders and developers
# and add them to your gpg keys.
wget https://raw.githubusercontent.com/bitcoin/bitcoin/master/contrib/builder-keys/keys.txt
while read fingerprint keyholder_name; do gpg --keyserver hkps://keys.openpgp.org --recv-keys ${fingerprint}; done <./keys.txt
# Verify signatures
gpg --verify SHA256SUMS.asc

# Extract tarball
tar xzf bitcoin-22.0-x86_64-linux-gnu.tar.gz
# Install with permission mode 755, with root as owner
# and /usr/local/bin as target dir
install -m 0755 -o root -g root -t /usr/local/bin bitcoin-22.0/bin/*

# Allow ports 8332 and 8333
ufw allow 8332
ufw allow 8333

# Star bitcoind as a daemon
bitcoind -printtoconsole=0 -daemon
# Star bitcoind as a server
bitcoind -printtoconsole=0 -server
# Star bitcoind without connecting to the network
bitcoind -printtoconsole=0 -noconnect
# Show bitcoind help
bitcoind -help

# Interact with the bitcoind through bitcoin-cli
bitcoin-cli help
bitcoin-cli getblockchaininfo
bitcoin-cli getnetworkinfo
bitcoin-cli getnettotals
bitcoin-cli getwalletinfo
bitcoin-cli getconnectioncount
bitcoin-cli getpeerinfo
# Safely stop your node
bitcoin-cli stop

# Run bitcoind on startup
crontab -e
"
@reboot bitcoind -daemon
"
