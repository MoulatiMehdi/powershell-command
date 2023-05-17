$fontFiles = Get-ChildItem -Filter *.otf -Recurse

$fontInstaller = New-Object -ComObject Shell.Application

foreach ($fontFile in $fontFiles) {
    $fontInstaller.Namespace(0x14).CopyHere($fontFile.FullName)
}
