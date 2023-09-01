
<#
.SYNOPSIS
    Downloads all files and folders from an IIS directory website.

.DESCRIPTION
    The Download_IIS_WebDir cmdlet downloads a complete directory and its files from the web.

.PARAMETER Downloadurl
    Specifies the URL from which to download files and folders.

.PARAMETER DownloadToFolder
    Specifies the local folder where files and folders should be downloaded.

.EXAMPLE
    Start-DirDownload -Downloadurl "http://example.com/files" -DownloadToFolder "C:\Downloads"

.NOTES
    File Name      : Download_IIS_WebDir.ps1
    Author         : Angatia Benson
    Version        : 1.0
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$Downloadurl,

    [Parameter(Mandatory = $true)]
    [Alias("DownloadPath")]
    [string]$DownloadToFolder
)

# Validate DownloadToFolder and create it if it doesn't exist
if (-Not (Test-Path $DownloadToFolder)) {
    New-Item -Path $DownloadToFolder -ItemType Directory
}

# Function to download files and folders
function Download-Items {
    param (
        [string]$Url,
        [string]$Folder
    )
    try {
        $response = Invoke-WebRequest -Uri $Url -UserAgent "Mozilla/5.0"
    } catch {
        Write-Host "Failed to access $Url. Skipping... Error: $($_.Exception.Message)"
        return
    }
    $links = $response.Links | Where-Object {$_.href -ne "../" -and $_.innerText -ne "web.config"}

    foreach ($link in $links) {
        $itemUrl = "$Url/$($link.href)"
        $itemPath = Join-Path -Path $Folder -ChildPath $link.innerText

        if ($link.innerText.EndsWith("/")) {
            # It's a folder
            if (-Not (Test-Path $itemPath)) {
                New-Item -Path $itemPath -ItemType Directory
            }
            Download-Items -Url $itemUrl -Folder $itemPath
        } else {
            # It's a file
            try {
                if (Test-Path $itemPath) {
                    Write-Host "$itemPath already exists. Skipping..."
                } else {
                    Invoke-WebRequest -Uri $itemUrl -OutFile $itemPath -UserAgent "Mozilla/5.0"
                    Write-Host "Downloaded $itemPath"
                }
            } catch {
                Write-Host "Failed to download $itemUrl. Error: $($_.Exception.Message)"
            }
        }
    }
}

# Start the download process
Download-Items -Url $Downloadurl -Folder $DownloadToFolder

