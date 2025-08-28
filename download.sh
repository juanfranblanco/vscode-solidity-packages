#!/usr/bin/env bash
set -euo pipefail

PUBLISHER="JuanBlanco"
NAME="solidity"
OUTDIR="./vsix"

mkdir -p "$OUTDIR"

for i in $(seq 1 185); do
  VER="0.0.$i"
  FILE="$OUTDIR/${PUBLISHER}.${NAME}-${VER}.vsix"
  if [[ -f "$FILE" ]]; then
    echo "[skip] $VER already exists"
    continue
  fi
  URL="https://${PUBLISHER,,}.gallery.vsassets.io/_apis/public/gallery/publisher/${PUBLISHER,,}/extension/${NAME,,}/${VER}/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
  echo "[try ] $VER"
  if curl -L --fail -o "$FILE" "$URL" 2>/dev/null; then
    echo "[done] $VER"
  else
    echo "[fail] $VER"
    rm -f "$FILE"
  fi
done

echo "Finished. VSIX files in $OUTDIR"