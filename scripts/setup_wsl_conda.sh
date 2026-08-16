#!/usr/bin/env bash
set -euo pipefail

PREFIX="${HOME}/miniforge3"
REPO_ROOT="/mnt/c/Users/aborr/dev/website_perso"
ENV_FILE="${REPO_ROOT}/environment.yml"

if [[ ! -x "${PREFIX}/bin/conda" ]]; then
  echo "Installing Miniforge into ${PREFIX}..."
  curl -fsSL -o /tmp/Miniforge3-Linux-x86_64.sh \
    "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"
  bash /tmp/Miniforge3-Linux-x86_64.sh -b -p "${PREFIX}"
fi

"${PREFIX}/bin/conda" init bash >/dev/null
# shellcheck disable=SC1091
source "${PREFIX}/etc/profile.d/conda.sh"

if conda env list | awk '{print $1}' | grep -qx 'website_perso'; then
  echo "Updating conda env website_perso..."
  conda env update -n website_perso -f "${ENV_FILE}" --prune
else
  echo "Creating conda env website_perso..."
  conda env create -f "${ENV_FILE}"
fi

echo
echo "Done. In WSL run:"
echo "  conda activate website_perso"
echo "  cd ${REPO_ROOT}"
echo "  mkdocs serve"
