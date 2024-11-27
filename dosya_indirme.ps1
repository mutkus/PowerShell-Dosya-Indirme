#Kim: Mustafa Utku SEYITHANOGLU
#Blog: mutkus.com
#Kişisel: mutk.us
#LinkedIn: linkedin.com/in/mutkus
#GitHub: github.com/mutkus

# Kullanıcıdan URL ve Uzantı Bilgisi
$URL = Read-Host "Lütfen indirmek istediğiniz URL'yi girin (örneğin: https://downloads.abc.com/)"
$Extension = Read-Host "İndirmek istediğiniz dosya uzantısını girin (Örn: pdf / xlsx vb. Not: Boş bırakılırsa tüm dosyalar indirilir)"
$Extension = $Extension.TrimStart('.')

# TargetFolder Belirle
$TargetFolder = Read-Host "Dosyaların kaydedileceği hedef klasörü girin (Boş bırakılırsa script'in bulunduğu dizin kullanılır)"
if (-not $TargetFolder) {
    $ScriptPath = $MyInvocation.MyCommand.Path
    if ($ScriptPath) {
        $TargetFolder = Split-Path -Parent $ScriptPath
    } else {
        $TargetFolder = Get-Location
    }
    Write-Host "Hedef klasör olarak script'in bulunduğu dizin kullanılacak: $TargetFolder" -ForegroundColor Green
}

# Hedef klasör yoksa oluşturulur
if (-not (Test-Path -Path $TargetFolder)) {
    New-Item -ItemType Directory -Path $TargetFolder | Out-Null
    Write-Host "Hedef klasör oluşturuldu: $TargetFolder" -ForegroundColor Green
}

try {
    Write-Host "URL'deki içerikler taranıyor: $URL" -ForegroundColor Cyan
    # Web sayfasını al
    $Response = Invoke-WebRequest -Uri $URL -UseBasicParsing

    # Tüm linkleri al
    $Links = $Response.Links

    # Eğer uzantı belirtilmemişse, tüm linkleri kullan
    if ([string]::IsNullOrEmpty($Extension)) {
        $Matches = $Links
    } else {
        # Belirtilen uzantıya sahip dosyaları filtrele
        $Matches = $Links | Where-Object {
            $_.href -match "\.$Extension($|\?)"
        }
    }

    if ($Matches.Count -eq 0) {
        Write-Host "Belirtilen uzantıya sahip dosya bulunamadı." -ForegroundColor Yellow
        return
    }

    Write-Host "$($Matches.Count) dosya bulundu. İndirme başlıyor..." -ForegroundColor Green

    foreach ($Link in $Matches) {
        $Href = $Link.href

        # URL'leri tam URL'ye dönüştür
        if ($Href -notlike "http*") {
            $Uri = New-Object System.Uri($Response.BaseResponse.ResponseUri, $Href)
            $Href = $Uri.AbsoluteUri
        }

        $FileName = Join-Path -Path $TargetFolder -ChildPath ([System.IO.Path]::GetFileName($Href))

        try {
            Write-Host "İndiriliyor: $Href" -ForegroundColor Yellow
            Invoke-WebRequest -Uri $Href -OutFile $FileName -UseBasicParsing
            Write-Host "Başarıyla indirildi: $FileName" -ForegroundColor Green
        } catch {
            Write-Host "İndirilemedi: $Href" -ForegroundColor Red
        }
    }

} catch {
    Write-Host "Hata oluştu: $_" -ForegroundColor Red
}

Write-Host "İşlem tamamlandı." -ForegroundColor Cyan

# Script'in kapanmasını engellemek için
Read-Host "Kapatmak için ENTER tuşuna basın..."
