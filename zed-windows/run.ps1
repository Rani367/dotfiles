# Zed Code Runner - runs current file based on extension (Windows)

param([string]$File)

if (-not $File) {
    Write-Host "Error: No file provided"
    exit 1
}

$Extension = [System.IO.Path]::GetExtension($File).TrimStart('.')
$BaseName = [System.IO.Path]::GetFileNameWithoutExtension($File)
$Directory = [System.IO.Path]::GetDirectoryName($File)

# Clear terminal
Clear-Host

switch ($Extension) {
    "py" {
        python $File
    }
    "c" {
        Push-Location $Directory
        try {
            # Find project root (look for CMakeLists.txt up to 3 levels up)
            $ProjectRoot = $Directory
            foreach ($rel in @(".", "..", "../..", "../../..")) {
                $cmakePath = Join-Path $Directory $rel "CMakeLists.txt"
                if (Test-Path $cmakePath) {
                    $ProjectRoot = (Resolve-Path (Join-Path $Directory $rel)).Path
                    break
                }
            }

            if (Test-Path (Join-Path $ProjectRoot "CMakeLists.txt")) {
                # CMake project
                Set-Location $ProjectRoot
                if (-not (Test-Path "build")) { New-Item -ItemType Directory -Name "build" | Out-Null }
                Set-Location "build"
                cmake .. && cmake --build .
                # Find and run the executable
                $exec = Get-ChildItem -File | Where-Object { $_.Extension -eq ".exe" } | Select-Object -First 1
                if ($exec) { & $exec.FullName }
            }
            elseif ((Test-Path "Makefile") -or (Test-Path "makefile")) {
                make
                $exeName = Split-Path $Directory -Leaf
                if (Test-Path "$exeName.exe") { & ".\$exeName.exe" }
                elseif (Test-Path "main.exe") { & ".\main.exe" }
            }
            else {
                # Single file compile with cl.exe (MSVC) or gcc
                $outPath = Join-Path $env:TEMP "$BaseName.exe"
                if (Get-Command cl -ErrorAction SilentlyContinue) {
                    cl /nologo /W4 /Fe:$outPath (Get-ChildItem *.c).FullName
                }
                else {
                    gcc -std=c11 -Wall -Wextra -o $outPath (Get-ChildItem *.c).FullName
                }
                if (Test-Path $outPath) { & $outPath }
            }
        }
        finally { Pop-Location }
    }
    { $_ -in @("cpp", "cc", "cxx") } {
        Push-Location $Directory
        try {
            # Find project root (look for CMakeLists.txt up to 3 levels up)
            $ProjectRoot = $Directory
            foreach ($rel in @(".", "..", "../..", "../../..")) {
                $cmakePath = Join-Path $Directory $rel "CMakeLists.txt"
                if (Test-Path $cmakePath) {
                    $ProjectRoot = (Resolve-Path (Join-Path $Directory $rel)).Path
                    break
                }
            }

            if (Test-Path (Join-Path $ProjectRoot "CMakeLists.txt")) {
                # CMake project
                Set-Location $ProjectRoot
                if (-not (Test-Path "build")) { New-Item -ItemType Directory -Name "build" | Out-Null }
                Set-Location "build"
                cmake .. && cmake --build .
                # Find and run the executable
                $exec = Get-ChildItem -File | Where-Object { $_.Extension -eq ".exe" } | Select-Object -First 1
                if ($exec) { & $exec.FullName }
            }
            elseif ((Test-Path "Makefile") -or (Test-Path "makefile")) {
                make
                $exeName = Split-Path $Directory -Leaf
                if (Test-Path "$exeName.exe") { & ".\$exeName.exe" }
                elseif (Test-Path "main.exe") { & ".\main.exe" }
            }
            else {
                # Single file compile
                $outPath = Join-Path $env:TEMP "$BaseName.exe"
                $sources = @(Get-ChildItem *.cpp, *.cc, *.cxx -ErrorAction SilentlyContinue).FullName
                if (Get-Command cl -ErrorAction SilentlyContinue) {
                    cl /nologo /W4 /EHsc /std:c++17 /Fe:$outPath $sources
                }
                else {
                    g++ -std=c++17 -Wall -Wextra -o $outPath $sources
                }
                if (Test-Path $outPath) { & $outPath }
            }
        }
        finally { Pop-Location }
    }
    "cs" {
        # C# - run via dotnet in project directory
        Push-Location $Directory
        try { dotnet run }
        finally { Pop-Location }
    }
    { $_ -in @("js", "mjs") } {
        node $File
    }
    { $_ -in @("ts", "mts") } {
        # TypeScript fallback chain
        if (Get-Command tsx -ErrorAction SilentlyContinue) {
            tsx $File
        }
        elseif (Get-Command ts-node -ErrorAction SilentlyContinue) {
            ts-node $File
        }
        elseif (Get-Command bun -ErrorAction SilentlyContinue) {
            bun $File
        }
        elseif (Get-Command deno -ErrorAction SilentlyContinue) {
            deno run --allow-all $File
        }
        else {
            npx tsx $File
        }
    }
    "go" {
        go run $File
    }
    "rs" {
        $outPath = Join-Path $env:TEMP "$BaseName.exe"
        rustc -o $outPath $File
        if (Test-Path $outPath) { & $outPath }
    }
    "ps1" {
        & $File
    }
    "rb" {
        ruby $File
    }
    "java" {
        # Compile to temp and run
        javac -d $env:TEMP $File
        Push-Location $env:TEMP
        try { java $BaseName }
        finally { Pop-Location }
    }
    default {
        Write-Host "Unsupported file type: .$Extension"
        exit 1
    }
}
