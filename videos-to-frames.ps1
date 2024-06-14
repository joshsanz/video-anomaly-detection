# videos-to-frames.ps1

$FPS = 1

if ($args.Count -eq 0) {
    Write-Host "Usage: $PSCommandPath VIDEO_DIR [FPS]"
    exit
}

$work_dir = $args[0]
if ($args.Count -eq 2) {
    $FPS = $args[1]
}
elseif ($args.Count -eq 1) {
    Write-Host "Using FPS=$FPS"
}
else {
    Write-Host "Too many args!"
    Write-Host "Usage: $PSCommandPath VIDEO_DIR [FPS]"
    exit
}

$videos = Get-ChildItem -Path $work_dir -Recurse -Include @("*.mp4", "*.MP4", "*.avi", "*.AVI")

foreach ($vid in $videos) {
    Write-Host $vid.FullName
    $extension = $vid.Extension
    $filename = [System.IO.Path]::GetFileNameWithoutExtension($vid.Name)
    $outdir = Join-Path $vid.DirectoryName $filename
    if (-Not (Test-Path $outdir)) {
        New-Item -ItemType Directory -Path $outdir | Out-Null
    }
    # Clear existing files to prevent stale data
    Get-ChildItem -Path $outdir | Remove-Item -Force

    # Extract frames to folder
    $ffmpegCmd = "ffmpeg -i `"$($vid.FullName)`" -vf fps=$FPS `"$outdir\frame%03d-fps$FPS.jpg`""
    Invoke-Expression $ffmpegCmd > $null 2>&1
}