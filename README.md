# 📋 Günlük Takip

Flutter ile geliştirilmiş, günlük görevlerinizi kolayca takip edebileceğiniz bir yapılacaklar listesi uygulaması.

## Özellikler

- **Görev Ekleme** — Alt menüden yeni görev oluşturma
- **Görev Tamamlama** — Checkbox ile görevleri tamamlandı olarak işaretleme
- **Toplu Silme** — Tamamlanan görevleri kaydetme (silme) veya tüm görevleri temizleme
- **Karanlık / Aydınlık Tema** — Hızlı tema geçişi (Provider ile)
- **Yerel Depolama** — Görevler SharedPreferences ile cihazda saklanır


## Proje Yapısı

```
lib/
├── main.dart                # Uygulama giriş noktası ve rota tanımları
├── tema.dart                # Tema yönetimi (ChangeNotifier)
├── model/
│   └── gorev.dart           # Görev veri modeli (JSON serileştirme)
└── ekranlar/
    ├── giris_ekran.dart     # Karşılama / başlangıç ekranı
    └── ana_ekran.dart       # Ana görev yönetim ekranı
```

## Kullanılan Paketler

| Paket | Açıklama |
|-------|----------|
| [provider](https://pub.dev/packages/provider) | Tema için durum yönetimi |
| [shared_preferences](https://pub.dev/packages/shared_preferences) | Görevlerin yerel depolanması |
| [google_fonts](https://pub.dev/packages/google_fonts) | Özel yazı tipleri (Lato, Roboto) |
| [flutter_speed_dial](https://pub.dev/packages/flutter_speed_dial) | Çoklu seçenekli FAB menüsü |

## Kurulum

1. Depoyu klonlayın:
   ```bash
   git clone https://github.com/<kullanici-adi>/gunluktakip.git
   cd gunluktakip
   ```

2. Bağımlılıkları yükleyin:
   ```bash
   flutter pub get
   ```

3. Uygulamayı çalıştırın:
   ```bash
   flutter run
   ```

## Gereksinimler

- Flutter SDK ≥ 3.7.2
- Dart SDK ≥ 3.0.0

## Mimari

- **Durum yönetimi:** Provider (tema değişimi için)
- **Veri katmanı:** SharedPreferences üzerinde JSON serileştirme
- **UI:** Material Design, modal bottom sheet, Speed Dial FAB

## Lisans

Bu proje MIT Lisansı ile lisanslanmıştır.
