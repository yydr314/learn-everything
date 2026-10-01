[CmdletBinding()]
param(
    [string]$SkillsDir = (Join-Path ([Environment]::GetFolderPath('UserProfile')) '.agents/skills')
)

$ErrorActionPreference = 'Stop'
$stage = $null
try {
    $source = $PSScriptRoot
    $required = @('SKILL.md', 'README.md', 'agents', 'assets', 'references')
    foreach ($name in $required) {
        if (-not (Test-Path -LiteralPath (Join-Path $source $name))) {
            throw "Incomplete download: missing $name. Extract the entire repository first."
        }
    }
    $parent = [IO.Path]::GetFullPath($SkillsDir)
    $target = Join-Path $parent 'study-system'
    if (Test-Path -LiteralPath $target) {
        throw "Already exists: $target. Back up and move the existing skill before installing again."
    }
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
    $stage = Join-Path $parent ('.study-system-install-' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $stage | Out-Null
    foreach ($name in $required) {
        Copy-Item -LiteralPath (Join-Path $source $name) -Destination $stage -Recurse
    }
    # Directory.Move fails if another installer created the destination meanwhile.
    [IO.Directory]::Move($stage, $target)
    $stage = $null
    Write-Host "Installed: $target"
    Write-Host 'Open a new Codex chat and use $study-system. Restart the app if needed.'
    exit 0
} catch {
    [Console]::Error.WriteLine($_.Exception.Message)
    if ($stage -and (Test-Path -LiteralPath $stage)) {
        # Keep partial files for inspection; never recursively remove a computed path.
        [Console]::Error.WriteLine("Incomplete staging folder retained: $stage")
    }
    exit 1
}
