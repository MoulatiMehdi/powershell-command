$fontFiles = Get-ChildItem -Filter *.otf -Recurse

foreach ($fontFile in $fontFiles) {
    $fontPath = $fontFile.FullName
    $fontName = [System.IO.Path]::GetFileNameWithoutExtension($fontFile.Name)
    $fontCopyPath = "$env:SystemRoot\Fonts\$fontName$($fontFile.Extension)"

    Copy-Item -Path $fontPath -Destination $fontCopyPath -Force
    Write-Host "Installing font: $fontName"
}

Write-Host "Font installation completed."
