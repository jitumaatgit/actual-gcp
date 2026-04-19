#!/bin/bash
set -e

GCLOUD_VERSION="565.0.0"
INSTALL_DIR="/c/google-cloud-sdk"
ZIP_FILE="google-cloud-sdk-${GCLOUD_VERSION}-windows-x86_64-bundled-python.zip"
DOWNLOAD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${ZIP_FILE}"

if scoop list 2>/dev/null | grep -q gcloud; then
  echo "Removing scoop gcloud installation..."
  scoop uninstall gcloud
fi

echo "Downloading Google Cloud SDK ${GCLOUD_VERSION}..."
curl -L -O "${DOWNLOAD_URL}"

echo "Extracting..."
unzip -o -q "${ZIP_FILE}" -d /c/

echo "Running install.sh..."
"${INSTALL_DIR}/install.sh" --path-update true --rc-path ~/.bashrc --bash-completion true --usage-reporting false

rm -f "${ZIP_FILE}"

source ~/.bashrc

echo ""
echo "Installation complete! Running: gcloud --version"
gcloud --version

echo ""
echo "Next step: run 'gcloud init' to configure your account and project."
