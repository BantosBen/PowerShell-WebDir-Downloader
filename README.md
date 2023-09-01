
# PowerShell-WebDir-Downloader

![License](https://img.shields.io/badge/license-MIT-blue)
![PowerShell Version](https://img.shields.io/badge/PowerShell-3.0+-green)

## Description

`PowerShell-WebDir-Downloader` is a PowerShell script designed to download all files and folders from an IIS (Internet Information Services) directory website. It's an easy-to-use tool that automates the process of downloading entire directories, making it ideal for backups, migrations, or even just grabbing some files you want.

## Features

- Downloads all files and folders recursively from a specified IIS web directory.
- Simple and clean code, easy to understand and modify.
- Efficient error-handling mechanisms.
- Validates and automatically creates download directories.

## Prerequisites

- Windows Operating System
- PowerShell 3.0+

## Usage

1. Clone this repository or download the `Download_IIS_WebDir.ps1` script.
2. Open PowerShell as an administrator.
3. Navigate to the directory where `Download_IIS_WebDir.ps1` is located.
4. Run the script with the following command, replacing `<DownloadURL>` and `<DownloadToFolder>` with your specific values:

    ```powershell
    .\Download_IIS_WebDir.ps1 -Downloadurl "<DownloadURL>" -DownloadToFolder "<DownloadToFolder>"
    ```

## Example

```powershell
.\Download_IIS_WebDir.ps1 -Downloadurl "http://example.com/files" -DownloadToFolder "C:\Downloads"
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Author

Created by Angatia Benson and updated for modern use by the community.

**Enjoy!**
