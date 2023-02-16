cd /workspaces/

# Bypass ssh fingerprint prompt
ssh -o StrictHostKeyChecking=no git@github.com

# Clone app-ethereum and plugin-tools
git clone https://github.com/LedgerHQ/app-ethereum.git
git clone https://github.com/LedgerHQ/plugin-tools.git

# Replace submodule with https url instead of ssh
cd /workspaces/app-ethereum/
git rm -r ethereum-plugin-sdk
git rm .gitmodules
git submodule add https://github.com/LedgerHQ/ethereum-plugin-sdk.git ethereum-plugin-sdk
git submodule update --init --recursive

# Pull ledger-builder image
cd /workspaces/plugin-tools
docker compose -f builder.docker-compose.yml pull builder

echo "onCreate done"