# ⚡ Wizz - App iOS + Android (Flutter)

Il WhatsApp innovativo con anima MSN. Un solo codice Dart = app nativa iOS + Android.

## Schermate incluse (lib/main.dart)
1. **Splash** blu MSN con logo ⚡
2. **Login telefono** + nickname MSN + OTP a 6 cifre (demo)
3. **Lista contatti MSN** con stati Online/Occupato/Non al PC + "Cosa sto ascoltando"
4. **Chat con TRILLO**: vibrazione aptica iOS + Android, shake animato, suono, winks 😘💃, temi, emoticon :) :( :D
5. **Profilo MSN**: nickname colorato, stato, musica

Design adattivo:
- su iOS usa CupertinoTabBar + stile iPhone
- su Android usa NavigationBar Material 3

## Come provarla sul telefono

### Opzione A - tuo PC (consigliata quando installi Flutter):
1. Installa Flutter: https://docs.flutter.dev/get-started/install/windows
2. Collega telefono Android con debug USB, oppure apri iPhone Simulator / Android Emulator
3. Da terminale in questa cartella:
```
flutter pub get
flutter run
```

### Opzione B - anteprima grafica subito (senza installare nulla):
Apri `../wizz/app-design.html` nel browser: vedi 3 telefoni (Login iOS, Contatti iOS, Chat Android).

### Opzione C - se vuoi QR Expo:
Dimmi "fammi versione Expo" e ti genero progetto React Native scansionabile con Expo Go.

## Prossimi passi per venderla a Zuckerberg
- Auth SMS reale (Firebase Auth)
- Backend realtime (Supabase / Firebase Firestore)
- Crittografia E2E + push notifications
- Store listing iOS App Store + Google Play
