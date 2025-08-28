 curl -s -X POST \
  -H "Accept: application/json;api-version=3.0-preview.1" \
  -H "Content-Type: application/json" \
  -d '{"filters":[{"criteria":[{"filterType":7,"value":"JuanBlanco.solidity"}]}],"flags":31}' \
  https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery \
| jq -r '
  .results[0].extensions[0].versions[]
  | . as $v
  | ($v.properties[]? | select(.key=="Microsoft.VisualStudio.Code.Engine").value) as $engine
  | ($v.files[] | select(.assetType=="Microsoft.VisualStudio.Services.VSIXPackage").source) as $vsix
  | "\($v.version),\($v.lastUpdated|split("T")[0]),\($engine),\($vsix)"
' > metadata.csv