param (
    [Parameter(mandatory)]
    $url,
    [Parameter()]
    $version
)

$publisher = [Regex]::Match($url, "itemName=(.*)\.").Groups[1].value
$extensionName = [Regex]::Match($url, "\.([\S][^.]*)$").Groups[1].value

if ($null -eq $version) {
    $version = [regex]::match(((Invoke-WebRequest -uri $url -UseBasicParsing).rawcontent),'"version":"(7.4.2)"').Groups[1].Value
}

$vsixUrl = "https://$publisher.gallery.vsassets.io/_apis/public/gallery/publisher/$publisher/extension/$extensionName/$version/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
Invoke-WebRequest -uri $vsixUrl -OutFile ".\$publisher.$extensionName.$version.vsix"
