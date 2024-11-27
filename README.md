# PowerShell ile Belirtilen URL'deki Dosyaları İndirme Script'i

Bu PowerShell script'i, kullanıcı tarafından belirtilen bir URL'deki dosyaları kolayca indirmenizi sağlar. İster belirli bir dosya uzantısına sahip dosyaları seçerek indirin, ister tüm dosyaları tek bir komutla bilgisayarınıza kaydedin.

## Özellikler

- **Belirli Dosya Uzantılarını İndirme:** İstediğiniz dosya türlerini (örneğin `.txt`, `.jpg`, `.c`) belirterek sadece bu dosyaları indirebilirsiniz.
- **Tüm Dosyaları İndirme:** Dosya uzantısı belirtmezseniz, script URL'deki tüm dosyaları indirmeye çalışır.
- **Hedef Klasör Seçimi:** Dosyaların kaydedileceği klasörü belirtebilir veya varsayılan olarak script'in bulunduğu dizini kullanabilirsiniz.
- **Göreli ve Mutlak URL Desteği:** Hem tam URL'leri hem de göreli URL'leri doğru bir şekilde işler.

## Kurulum

1. **Script'i İndirin veya Kopyalayın:**
   - `dosya_indirme.ps1` adlı script dosyasını bilgisayarınıza kaydedin.

2. **PowerShell Execution Policy Ayarı:**

   **Önemli:** Bu script'i çalıştırmak için PowerShell Execution Policy ayarlarınızı güncellemeniz gerekebilir. Varsayılan olarak, PowerShell güvenlik nedeniyle script'lerin çalıştırılmasını engelleyebilir.

   - **Execution Policy'yi Geçici Olarak Değiştirme:**

     ```powershell
     Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
     ```

     Bu komut, sadece mevcut PowerShell oturumu için geçerlidir ve PowerShell kapatıldığında eski haline döner.

   - **Güvenlik Uyarısı:**

     > **Dikkat:** Execution Policy'yi değiştirmek güvenlik riskleri oluşturabilir. Bu ayarı sadece güvenilir kaynaklardan gelen script'leri çalıştırırken kullanmanız önerilir. Ayarı değiştirdikten sonra eski haline getirmeyi unutmayın.

## Kullanım

1. **PowerShell'i Açın:**
   - PowerShell penceresini açın ve script'in bulunduğu dizine gidin.

2. **Script'i Çalıştırın:**

   ```powershell
   .\dosya_download.ps1
