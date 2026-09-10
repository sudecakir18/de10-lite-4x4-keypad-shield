# ⌨️ DE10-Lite FPGA 4x4 Keypad Shield & Verilog Controller

Bu proje, **Intel MAX 10 (DE10-Lite) FPGA** geliştirme kartı ile uyumlu özel bir **4x4 Matris Tuş Takımı (Keypad Shield)** donanım tasarımı ve bu tuş takımını kontrol eden **Verilog HDL** sürücü mantığını içermektedir[cite: 4].

---

## 📌 Proje Özeti ve Temel Özellikler

- **Donanım Tasarımı:** KiCad ile tasarlanmış, DE10-Lite kartının $2\times20$ GPIO genişleme portuna doğrudan takılabilen 2 katmanlı özel PCB shield kartı[cite: 4].
- **Sayısal Tasarım (HDL):** Tuş takımı matrisini sürekli tarayan, basılan tuşu tespit eden ve sonucu DE10-Lite üzerindeki 7-segment display biriminde gösteren Verilog HDL modülü[cite: 4].
- **Üretim ve Doğrulama:** JLCPCB üzerinde çift katmanlı PCB üretimi gerçekleştirilmiş, lehimleme ve montaj sonrası FPGA laboratuvarında test edilerek doğrulanmıştır[cite: 4].

---

## 🛠️ Donanım Mimarisi & Şematik

- **Tuş Matrisi:** 16 adet SMD buton (DS1042) ile oluşturulmuş $4\times4$ satır/sütun matris yapısı[cite: 4].
- **Arayüz Bağlantısı:** DE10-Lite kartının $2\times20$ dişi header pin yapısına (SFH11-PBPC-D20-ST-BK) tam uyumlu pin eşlemesi[cite: 4].
- **Direnç Ağı:** Kararlı lojik okuma için pull-down direnç bağlantıları[cite: 4].

---
1. **Satır Tarama (Row Scanning):** Sayaç mantığı ile `row` çıkışlarına sırasıyla `0001`, `0010`, `0100`, `1000` sinyalleri uygulanır[cite: 4].
2. **Sütun Dinleme (Column Reading):** Aktif olan satırdaki buton basımı, `col` girişlerinden okunarak basılan tuşun hex değeri (`0-F`) belirlenir[cite: 4].
3. **Display Sürüşü:** Tespit edilen değer, 7-segment kod çözücü üzerinden anlık olarak görselleştirilir[cite: 4].

---
