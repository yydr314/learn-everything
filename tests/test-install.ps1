$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$testRoot = Join-Path $repo ('.test-output/ps-' + [guid]::NewGuid().ToString('N'))
$unicodeName = [string][char]0x5B78 + [char]0x7FD2
$destination = Join-Path $testRoot ("space $unicodeName/skills")
$shell = (Get-Process -Id $PID).Path
$installer = Join-Path $repo 'install.ps1'

& $shell -NoProfile -ExecutionPolicy Bypass -File $installer -SkillsDir $destination
if ($LASTEXITCODE -ne 0) { throw 'First installation failed' }
$installed = Join-Path $destination 'study-system'
$expected = @('SKILL.md', 'README.md', 'agents', 'assets', 'references')
foreach ($name in $expected) {
    $origin = Join-Path $repo $name
    $files = @(Get-Item -LiteralPath $origin)
    if (Test-Path -LiteralPath $origin -PathType Container) {
        $files = @(Get-ChildItem -LiteralPath $origin -File -Recurse)
    }
    foreach ($file in $files) {
        $relative = $file.FullName.Substring($repo.Length + 1)
        $copy = Join-Path $installed $relative
        if ((Get-FileHash -LiteralPath $file.FullName).Hash -ne (Get-FileHash -LiteralPath $copy).Hash) {
            throw "Content mismatch: $relative"
        }
    }
}
if ((Get-ChildItem -LiteralPath $installed -File -Recurse).Count -ne 10) {
    throw 'Unexpected installed payload'
}
$sentinel = Join-Path $installed 'keep.txt'
Set-Content -LiteralPath $sentinel -Value 'preserve-existing' -Encoding UTF8
& $shell -NoProfile -ExecutionPolicy Bypass -File $installer -SkillsDir $destination
if ($LASTEXITCODE -eq 0) { throw 'Duplicate installation should fail' }
if ((Get-Content -LiteralPath $sentinel -Raw).Trim() -ne 'preserve-existing') {
    throw 'Existing installation was modified'
}
$incomplete = Join-Path $testRoot 'incomplete'
New-Item -ItemType Directory -Path $incomplete -Force | Out-Null
Copy-Item -LiteralPath $installer -Destination $incomplete
& $shell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $incomplete 'install.ps1') -SkillsDir (Join-Path $testRoot 'rejected')
if ($LASTEXITCODE -eq 0) { throw 'Incomplete download should fail' }
if (Test-Path -LiteralPath (Join-Path $testRoot 'rejected')) { throw 'Invalid input changed destination' }
Write-Host 'PASS: first install, content hashes, Unicode/spaces, duplicate protection, incomplete download'
Write-Host "Isolated test artifacts: $testRoot"
exit 0
