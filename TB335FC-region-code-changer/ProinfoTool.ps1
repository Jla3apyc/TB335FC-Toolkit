# ProinfoTool.ps1 — patching tool for 'proinfo'
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("FindAddress", "GetCurrentRegion", "GetScatterInfo", "Patch")]
    [string]$Action,
    [string]$ScatterDir,
    [string]$InputFile,
    [string]$OutputFile,
    [string]$RegionCode,
    [string]$Lang = "RU"
)

function Find-Bytes {
    param([byte[]]$Data, [byte[]]$Pattern)
    for ($i = 0; $i -le $Data.Length - $Pattern.Length; $i++) {
        $match = $true
        for ($j = 0; $j -lt $Pattern.Length; $j++) {
            if ($Data[$i + $j] -ne $Pattern[$j]) { $match = $false; break }
        }
        if ($match) { return $i }
    }
    return -1
}

function Get-CurrentRegion {
    param([string]$InputFile)
    if (-not (Test-Path $InputFile)) {
        if ($Lang -eq "EN") { Write-Host "❌ File not found: $InputFile" -ForegroundColor Red }
        else { Write-Host "❌ Файл не найден: $InputFile" -ForegroundColor Red }
        return $false
    }
    try { $data = [System.IO.File]::ReadAllBytes($InputFile) }
    catch {
        if ($Lang -eq "EN") { Write-Host "❌ Read error: $_" -ForegroundColor Red }
        else { Write-Host "❌ Ошибка чтения: $_" -ForegroundColor Red }
        return $false
    }
    
    # Universal search: any 2 letters + "XX"
    for ($i = 0; $i -le $data.Length - 4; $i++) {
        if ([char]::IsLetter($data[$i]) -and [char]::IsLetter($data[$i+1]) -and 
            $data[$i+2] -eq 0x58 -and $data[$i+3] -eq 0x58) {
            
            $code = [System.Text.Encoding]::ASCII.GetString($data, $i, 2)
            $token = [System.Text.Encoding]::ASCII.GetString($data, $i, 4)
            
            if ($Lang -eq "EN") {
                Write-Host "🔍 Current region: $code" -ForegroundColor Cyan
                Write-Host "   Token: $token (offset: 0x$($i.ToString('X')))" -ForegroundColor DarkGray
            } else {
                Write-Host "🔍 Текущий регион: $code" -ForegroundColor Cyan
                Write-Host "   Токен: $token (смещение: 0x$($i.ToString('X')))" -ForegroundColor DarkGray
            }
            return $true
        }
    }
    
    if ($Lang -eq "EN") { Write-Host "⚠️  Failed to determine region (no valid token found)" -ForegroundColor Yellow }
    else { Write-Host "⚠️  Не удалось определить регион (токен не найден)" -ForegroundColor Yellow }
    return $false
}

function Find-Address {
    param([string]$ScatterDir, [string]$OutputFile)
    if (-not (Test-Path $ScatterDir)) {
        if ($Lang -eq "EN") { Write-Host "❌ Scatter folder not found: $ScatterDir" -ForegroundColor Red }
        else { Write-Host "❌ Папка scatter не найдена: $ScatterDir" -ForegroundColor Red }
        return $false
    }
    
    $scatter = Get-ChildItem $ScatterDir -Filter "*scatter*.xml" -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $scatter) { 
        $scatter = Get-ChildItem $ScatterDir -Filter "*scatter*.txt" -ErrorAction SilentlyContinue | Select-Object -First 1 
    }
    if (-not $scatter) {
        if ($Lang -eq "EN") { Write-Host "❌ Scatter file not found" -ForegroundColor Red }
        else { Write-Host "❌ Scatter-файл не найден" -ForegroundColor Red }
        return $false
    }
    
    if ($Lang -eq "EN") { Write-Host "📄 Found: $($scatter.Name)" -ForegroundColor DarkGray }
    else { Write-Host "📄 Найден: $($scatter.Name)" -ForegroundColor DarkGray }
    $content = Get-Content $scatter.FullName -Raw -Encoding UTF8
    
    $ufsSectionRegex = [regex]::new('(?s)<storage_type\s+name="UFS">(.+?)</storage_type>', 'IgnoreCase')
    $ufsMatch = $ufsSectionRegex.Match($content)
    
    $searchContent = if ($ufsMatch.Success) { $ufsMatch.Groups[1].Value } else { $content }
    
    $proinfoRegex = [regex]::new('(?s)<partition_name>\s*proinfo\s*</partition_name>.*?(?:<linear_start_addr>|linear_start_addr\s*:\s*)(0x[0-9A-Fa-f]+)', 'IgnoreCase')
    $proinfoMatch = $proinfoRegex.Match($searchContent)
    
    if ($proinfoMatch.Success) {
        $addr = $proinfoMatch.Groups[1].Value
        [System.IO.File]::WriteAllText($OutputFile, $addr)
        if ($Lang -eq "EN") {
            Write-Host "✅ 'proinfo' address: $addr" -ForegroundColor Green
            if ($ufsMatch.Success) { Write-Host "   Memory region: UFS_LU2 (detected from UFS section)" -ForegroundColor DarkGray }
        } else {
            Write-Host "✅ Адрес 'proinfo': $addr" -ForegroundColor Green
            if ($ufsMatch.Success) { Write-Host "   Регион памяти: UFS_LU2 (определено из UFS-секции)" -ForegroundColor DarkGray }
        }
        return $true
    }
    if ($Lang -eq "EN") { Write-Host "⚠️  'proinfo' not found in scatter file" -ForegroundColor Yellow }
    else { Write-Host "⚠️  'proinfo' не найден в scatter-файле" -ForegroundColor Yellow }
    return $false
}

function Get-ScatterInfo {
    param([string]$ScatterDir)
    if (-not (Test-Path $ScatterDir)) {
        if ($Lang -eq "EN") { Write-Host "❌ Scatter folder not found" -ForegroundColor Red }
        else { Write-Host "❌ Папка scatter не найдена" -ForegroundColor Red }
        return $false
    }
    
    $scatter = Get-ChildItem $ScatterDir -Filter "*scatter*.xml" -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $scatter) { 
        $scatter = Get-ChildItem $ScatterDir -Filter "*scatter*.txt" -ErrorAction SilentlyContinue | Select-Object -First 1 
    }
    if (-not $scatter) {
        if ($Lang -eq "EN") { Write-Host "❌ Scatter file not found" -ForegroundColor Red }
        else { Write-Host "❌ Scatter-файл не найден" -ForegroundColor Red }
        return $false
    }
    
    $content = Get-Content $scatter.FullName -Raw -Encoding UTF8
    
    if ($Lang -eq "EN") {
        $notDef = "Not defined"; $notFound = "Not found"
    } else {
        $notDef = "Не определено"; $notFound = "Не найден"
    }
    
    $platform = if ($content -match '(?:<platform>|platform\s*:\s*)([^<\s\r\n]+)') { $matches[1] } else { $notDef }
    $project = if ($content -match '(?:<project>|project\s*:\s*)([^<\s\r\n]+)') { $matches[1] } else { $notDef }
    $version = if ($content -match 'config_version[^"]*"?([^"<>\s]+)"?') { $matches[1] } else { $notDef }
    
    $storageType = if ($content -match '<storage_type\s+name="UFS">') { "UFS" } 
                   elseif ($content -match '<storage_type\s+name="EMMC">') { "EMMC" }
                   elseif ($content -match 'storage\s*:\s*HW_STORAGE_UFS') { "UFS" }
                   elseif ($content -match 'storage\s*:\s*HW_STORAGE_EMMC') { "EMMC" }
                   else { $notDef }
    
    $proinfoAddr = $notFound; $proinfoSize = $notFound; $proinfoRegion = $notDef
    
    $ufsRegex = [regex]::new('(?s)<storage_type\s+name="UFS">(.+?)</storage_type>', 'IgnoreCase')
    $ufsMatch = $ufsRegex.Match($content)
    $searchContent = if ($ufsMatch.Success) { $ufsMatch.Groups[1].Value } else { $content }
    
    $proinfoRegex = [regex]::new('(?s)<partition_name>\s*proinfo\s*</partition_name>.*?(?:<linear_start_addr>|linear_start_addr\s*:\s*)(0x[0-9A-Fa-f]+).*?(?:<partition_size>|partition_size\s*:\s*)(0x[0-9A-Fa-f]+).*?(?:<region>|region\s*:\s*)([A-Z_0-9]+)', 'IgnoreCase')
    $proinfoMatch = $proinfoRegex.Match($searchContent)
    
    if ($proinfoMatch.Success) {
        $proinfoAddr = $proinfoMatch.Groups[1].Value
        $proinfoSize = $proinfoMatch.Groups[2].Value
        $proinfoRegion = $proinfoMatch.Groups[3].Value
    }
    
    if ($Lang -eq "EN") {
        Write-Host "  File:         $($scatter.Name)" -ForegroundColor White
        Write-Host "  Version:      $version" -ForegroundColor White
        Write-Host "  Platform:     $platform" -ForegroundColor White
        Write-Host "  Project:      $project" -ForegroundColor White
        Write-Host "  Memory:       $storageType" -ForegroundColor White
        Write-Host ""
        Write-Host "  'proinfo' partition:" -ForegroundColor Yellow
        Write-Host "    • Address:  $proinfoAddr" -ForegroundColor White
        Write-Host "    • Size:     $proinfoSize" -ForegroundColor White
        Write-Host "    • Region:   $proinfoRegion" -ForegroundColor White
        Write-Host ""
        Write-Host "  Note:" -ForegroundColor Yellow
        Write-Host "    • Region change may activate Widevine L1" -ForegroundColor DarkGray
        Write-Host "    • OTA updates may stop coming" -ForegroundColor DarkGray
        Write-Host "    • Always backup before writing!" -ForegroundColor DarkGray
    } else {
        Write-Host "  Файл:         $($scatter.Name)" -ForegroundColor White
        Write-Host "  Версия:       $version" -ForegroundColor White
        Write-Host "  Платформа:    $platform" -ForegroundColor White
        Write-Host "  Проект:       $project" -ForegroundColor White
        Write-Host "  Память:       $storageType" -ForegroundColor White
        Write-Host ""
        Write-Host "  Раздел 'proinfo':" -ForegroundColor Yellow
        Write-Host "    • Адрес:    $proinfoAddr" -ForegroundColor White
        Write-Host "    • Размер:   $proinfoSize" -ForegroundColor White
        Write-Host "    • Region:   $proinfoRegion" -ForegroundColor White
        Write-Host ""
        Write-Host "  Примечание:" -ForegroundColor Yellow
        Write-Host "    • Смена региона может активировать Widevine L1" -ForegroundColor DarkGray
        Write-Host "    • OTA-обновления могут перестать приходить" -ForegroundColor DarkGray
        Write-Host "    • Всегда делайте бэкап перед записью!" -ForegroundColor DarkGray
    }
    Write-Host ""
    return $true
}

function Patch-Proinfo {
    param([string]$InputFile, [string]$OutputFile, [string]$RegionCode)
    
    $RegionCode = $RegionCode.Trim().ToUpper()
    if ($RegionCode.Length -ne 2 -or $RegionCode -notmatch '^[A-Z]{2}$') {
        if ($Lang -eq "EN") { Write-Host "❌ Region code must be exactly 2 Latin letters" -ForegroundColor Red }
        else { Write-Host "❌ Код региона должен состоять из 2 латинских букв" -ForegroundColor Red }
        return $false
    }
    if (-not (Test-Path $InputFile)) {
        if ($Lang -eq "EN") { Write-Host "❌ File not found: $InputFile" -ForegroundColor Red }
        else { Write-Host "❌ Файл не найден: $InputFile" -ForegroundColor Red }
        return $false
    }
    
    try { $data = [System.IO.File]::ReadAllBytes($InputFile) }
    catch {
        if ($Lang -eq "EN") { Write-Host "❌ Read error: $_" -ForegroundColor Red }
        else { Write-Host "❌ Ошибка чтения: $_" -ForegroundColor Red }
        return $false
    }
    
    if ($data.Length -lt 50000 -or $data.Length -gt 10000000) {
        if ($Lang -eq "EN") { Write-Host "⚠️  Size: $($data.Length) bytes (expected ~3 MB)" -ForegroundColor Yellow }
        else { Write-Host "⚠️  Размер: $($data.Length) байт (ожидалось ~3 MB)" -ForegroundColor Yellow }
        if ($Lang -eq "EN") { $c = Read-Host "Continue? (y/N)" }
        else { $c = Read-Host "Продолжить? (y/N)" }
        if ($c -ne 'y') { return $false }
    }
    
    # Search for any token in the XXYY format (2 letters + "XX")
    $found = $false; $patchIdx = -1
    for ($i = 0; $i -le $data.Length - 4; $i++) {
        if ([char]::IsLetter($data[$i]) -and [char]::IsLetter($data[$i+1]) -and 
            $data[$i+2] -eq 0x58 -and $data[$i+3] -eq 0x58) {
            $found = $true
            $patchIdx = $i
            break
        }
    }
    
    if (-not $found) {
        if ($Lang -eq "EN") { Write-Host "❌ Region token not found in file" -ForegroundColor Red }
        else { Write-Host "❌ Токен региона не найден в файле" -ForegroundColor Red }
        return $false
    }
    
    $newBytes = [System.Text.Encoding]::ASCII.GetBytes("${RegionCode}XX")
    $patched = $data.Clone()
    for ($i = 0; $i -lt 4; $i++) { $patched[$patchIdx + $i] = $newBytes[$i] }
    
    $diffs = 0
    for ($i = 0; $i -lt $data.Length; $i++) { if ($data[$i] -ne $patched[$i]) { $diffs++ } }
    if ($diffs -ge 2 -and $diffs -le 4) {
        if ($Lang -eq "EN") { Write-Host "✅ Validation: changed $diffs bytes (normal)" -ForegroundColor Green }
        else { Write-Host "✅ Валидация: изменено $diffs байт (норма)" -ForegroundColor Green }
    } else {
        if ($Lang -eq "EN") { Write-Host "⚠️  Changed bytes: $diffs (check file)" -ForegroundColor Yellow }
        else { Write-Host "⚠️  Изменено байт: $diffs (проверьте файл)" -ForegroundColor Yellow }
    }
    
    [System.IO.File]::WriteAllBytes($OutputFile, $patched)
    if ($Lang -eq "EN") { Write-Host "💾 Done: $([System.IO.Path]::GetFileName($OutputFile))" -ForegroundColor Green }
    else { Write-Host "💾 Готово: $([System.IO.Path]::GetFileName($OutputFile))" -ForegroundColor Green }
    return $true
}

try {
    switch ($Action) {
        "FindAddress" { if (Find-Address -ScatterDir $ScatterDir -OutputFile $OutputFile) { exit 0 } else { exit 1 } }
        "GetCurrentRegion" { if (Get-CurrentRegion -InputFile $InputFile) { exit 0 } else { exit 1 } }
        "GetScatterInfo" { if (Get-ScatterInfo -ScatterDir $ScatterDir) { exit 0 } else { exit 1 } }
        "Patch" { if (Patch-Proinfo -InputFile $InputFile -OutputFile $OutputFile -RegionCode $RegionCode) { exit 0 } else { exit 1 } }
    }
} catch {
    if ($Lang -eq "EN") { Write-Host "❌ Error: $_" -ForegroundColor Red }
    else { Write-Host "❌ Ошибка: $_" -ForegroundColor Red }
    exit 1
}