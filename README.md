# ⚡ Wizz — il WhatsApp con anima MSN

App iOS + Android (Flutter) + anteprima web.

- `wizz/app-design.html` → grafica premium app (apri in browser o GitHub Pages)
- `wizz/index.html` → prototipo chat funzionante con TRILLO
- `wizz_app/` → codice Flutter nativo iOS + Android

## Prova web subito
Apri `wizz/app-design.html` oppure usa localhost:
```
python -m http.server 8080
# http://localhost:8080/wizz/app-design.html
```

## Prova app Flutter
```
cd wizz_app
flutter pub get
flutter run
```

## Pubblicare
- Web: GitHub → Settings → Pages → Deploy from branch → `/wizz`
- App: `flutter build apk` / `flutter build appbundle` per Play Store, `flutter build ipa` per App Store
