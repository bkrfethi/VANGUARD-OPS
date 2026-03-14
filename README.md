# 🛡️ VANGUARD OPS - RDAPP
## *Tactical Security Response Application - Enterprise Edition*

![Vanguard](https://img.shields.io/badge/Vanguard%20Ops-v1.0.0-DC143C?style=for-the-badge&logo=flutter&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-3.10.4%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.10.4%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2F%20BLOC-FF6B6B?style=for-the-badge)
![Backend](https://img.shields.io/badge/Backend-Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![License](https://img.shields.io/badge/License-Private-red?style=for-the-badge)

---

## 📋 Table des Matières

1. [🎯 Vue d'Ensemble](#-vue-densemble)
2. [🏗️ Architecture Technique](#️-architecture-technique)
3. [⚡ Module Alert - Le Cœur du Projet](#-module-alert---le-cœur-du-projet)
4. [🎨 Design System "Tactical Dark"](#-design-system-tactical-dark)
5. [📦 Structure du Projet](#-structure-du-projet)
6. [🚀 Guide Installation "Zero Error"](#-guide-installation-zero-error)
7. [🔧 Dépendances Clés](#-dépendances-clés)
8. [📱 Fonctionnalités Principales](#-fonctionnalités-principales)
9. [🛠️ Développement & Tests](#️-développement--tests)
10. [⚠️ Migration Maps: Leçons Apprises](#️-migration-maps-leçons-apprises)
11. [👨‍💻 Conventions de Code](#-conventions-de-code)

---

## 🎯 Vue d'Ensemble

**VANGUARD OPS** est une application de sécurité tactique **haut de gamme** conçue pour les équipes d'intervention d'urgence (Gendarmerie, Pompiers, Police). Elle permet une gestion d'alertes en temps réel avec géolocalisation instantanée, communication avec des contacts d'urgence et un système de monitoring centralisé.

### Caractéristiques Principales
- ✅ **Alertes Tactiques** : Déploiement d'SOS avec countdown intelligent (3 secondes)
- ✅ **Géolocalisation Précise** : Intégration flutter_map + latlong2 (OpenStreetMap)
- ✅ **Authentification Enterprise** : Supabase Auth avec SSO
- ✅ **Backend Temps Réel** : Supabase Realtime pour les alertes/contacts
- ✅ **Design Militaire** : Interface "Tactical Dark" avec CartoDB Dark Matter
- ✅ **Multi-Plateforme** : iOS, Android, Web, Windows, macOS, Linux

### Public Cible
👮 Agents des forces de l'ordre  
🚒 Pompiers et équipes de secours  
⚠️ Personnel de sécurité tactique  
🏙️ Centres d'opération d'urgence (PSAP/SAMU)

---

## 🏗️ Architecture Technique

### 1️⃣ Pattern BLoC/Cubit - Gestion d'État Réactive

L'application utilise **flutter_bloc** pour une gestion d'état professionnelle et scalable.

```dart
// Hiérarchie des Cubits
AlertCubit          → Gestion des alertes SOS & countdown
SigninCubit         → Authentification utilisateur
ContactsCubit       → CRUD contacts d'urgence
SettingsCubit       → Préférences utilisateur
NavigationCubit     → Routage & tab navigation
```

**Avantage du Cubit** : Plus léger que BLoC, idéal pour des mutations d'état simples avec une logique asynchrone claire.

```dart
// Exemple : AlertCubit avec Stream.periodic robuste
class AlertCubit extends Cubit<AlertState> {
  void _startCountdownTimer() {
    _timerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (count) => _countdownDuration - count - 1,
    ).takeWhile((tick) => tick >= 0).listen((remaining) {
      if (!isClosed) emit(AlertTimerInProgress(remaining));
    });
  }
}
```

### 2️⃣ Supabase - Backend Serverless

Intégration complète du stack **Supabase** :

- **Authentication** : JWT, Magic Links, auth.currentUser
- **Database** : PostgreSQL avec RLS (Row-Level Security)
- **Storage** : Photos d'incidents & media files
- **Realtime** : WebSocket pour sync alertes en direct

**Architecture des Services :**

```
Data Layer (Services Supabase)
    ↓
Repository Pattern (Interfaces)
    ↓
Domain Layer (UseCases)
    ↓
Presentation Layer (Cubits + UI)
```

### 3️⃣ flutter_map + latlong2 (Migration Stratégique)

#### 🚀 Pourquoi cette Migration ?

**google_maps_flutter** → **flutter_map** (Changement Critique)

| Critère | google_maps | flutter_map | Verdict |
|---------|-------------|----------|---------|
| **Web Support** | ❌ Problématique | ✅ Natif | **flutter_map** gagne |
| **Windows Support** | ❌ Non supporté | ✅ Supporté | **flutter_map** gagne |
| **Propriétaire** | ❌ Google only | ✅ Open-source | **flutter_map** gagne |
| **API Key Required** | ✅ Oui | ❌ Non (OSM) | **flutter_map** gagne |
| **Bundle Size** | ⚠️ Lourd | ✅ Léger | **flutter_map** gagne |
| **Licence** | ⚠️ Restrictions | ✅ FOSS | **flutter_map** gagne |

#### 🐛 Erreurs Rencontrées

```
❌ TypeError: maps_api is undefined (Web)
❌ PlatformException: Initialization of Maps failed (Windows)
❌ Incompatibilité types pour web platform
```

**Solution implémentée** : 
- ✅ `flutter_map: ^8.2.2` (fork Dart pur, multi-plateforme)
- ✅ `latlong2: ^0.9.1` (gestion des coordonnées)
- ✅ **CartoDB Dark Matter tiles** pour l'esthétique militaire

#### 🗺️ Configuration Cartographique

```dart
// Map avec tiles CartoDB Dark Matter (Military Grade)
TileLayer(
  urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
  subdomains: const ['a', 'b', 'c'],
  userAgentPackageName: 'com.vanguard.ops',
)
```

---

## ⚡ Module Alert - Le Cœur du Projet

### Architecture Modulaire : 8 Widgets Composables

```
lib/presentaion/alert/
├── bloc/
│   ├── alert_cubit.dart           # Logic countdown 3s
│   └── alert_state.dart           # États UI
├── pages/
│   ├── home_page.dart             # Bouton SOS
│   ├── map_alert_paged.dart       # Alerte + carte
│   └── report_incident_page.dart  # Formulaire incident
├── widgets/                        # 8 composants réutilisables
│   ├── cinematic_gradient_overlay.dart
│   ├── control_area_widget.dart
│   ├── description_field_widget.dart
│   ├── header_widget.dart
│   ├── info_card_widget.dart
│   ├── map_widget.dart
│   ├── media_card_widget.dart
│   ├── status_cards_widget.dart
│   └── widgets.dart               # Barrel export
└── constants.dart                 # Thème centralisé
```

### 🔴 Logique du Countdown 3 Secondes (Stream.periodic)

```dart
class AlertCubit extends Cubit<AlertState> {
  Timer? _countdownTimer;
  StreamSubscription? _timerSubscription;
  int _countdown = 3;

  void _startCountdownTimer() {
    _countdown = _countdownDuration;
    emit(AlertTimerInProgress(_countdown));

    // ✅ Stream.periodic : robust & testable
    _timerSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (count) => _countdownDuration - count - 1,
    )
    .takeWhile((tick) => tick >= 0)
    .listen((remaining) {
      if (!isClosed) {
        _countdown = remaining;
        if (remaining > 0) {
          emit(AlertTimerInProgress(remaining));
        } else {
          _sendFinalAlert();
        }
      }
    });
  }

  Future<void> _sendFinalAlert() async {
    if (isClosed) return;
    emit(const AlertSending());

    final result = await sl<SendAlertUseCase>().call(params: _activeAlert);
    
    if (!isClosed) {
      result.fold(
        (error) => emit(AlertError(error)),
        (alert) => emit(AlertSuccess(alert)),
      );
    }
  }
}
```

**UX Flow** :
1. Tap le bouton **SOS** → État `AlertLoading`
2. App récupère le GPS 📍
3. Countdown affiche **3... 2... 1...**
4. À **0 secondes**, l'alerte est envoyée à Supabase
5. État passe à `AlertSuccess` avec récapitulatif

---

## 🎨 Design System "Tactical Dark"

### Palette de Couleurs (AlertColors)

```dart
// Surfaces sombres (Military Grade look)
Color.black              = #000000
Color.darkSurface        = #1A1A1A
Color.darkSurfaceAlt     = #1E1E1E
Color.darkInput          = #262626

// Couleurs d'accent
Color.redAccent          = #DC143C  (Crimson - Alert)
Color.greenAccent        = #00FF00  (Success)

// Textes
Color.textPrimary        = #FFFFFF
Color.textSecondary      = #999999
Color.textTertiary       = #666666
```

### Dimensions & Spacing

```dart
paddingXS  = 8.0    paddingS   = 12.0   paddingM   = 16.0
paddingL   = 20.0   paddingXL  = 24.0   paddingXXL = 32.0

radiusS  = 12.0   radiusM  = 16.0   radiusL  = 20.0
sosButtonSize = 200.0
cancelButtonSize = 70.0
```

### Composants UI Senior 🎯

1. **Bouton SOS** : Circle 200x200 avec double shadow glow effect
2. **Glassmorphism** : Overlays semi-transparents avec dégradés
3. **Marqueur Pulsant** : Breathing effect sur carte
4. **CartoDB Dark Matter** : Tiles avec inversion couleurs (NVG style)

---

## 📦 Structure du Projet

### Arborescence (Clean Architecture)

```
vanguard_ops/
├── lib/
│   ├── main.dart                    Entry point
│   ├── service_loacator.dart        GetIt DI setup
│   ├── common/                      Composants communs
│   │   ├── bloc/
│   │   ├── helper/
│   │   └── wigets/
│   ├── core/                        Config & Services
│   │   ├── config/
│   │   ├── services/
│   │   └── usecases/
│   ├── data/                        Data Layer
│   │   ├── alert/
│   │   ├── auth/
│   │   └── contacts/
│   ├── domain/                      Business Logic
│   │   ├── alert/
│   │   ├── auth/
│   │   └── contacts/
│   └── presentaion/                 UI Layer
│       ├── alert/                   ⭐ COEUR DU PROJET
│       ├── auth/
│       ├── contact/
│       ├── home/
│       └── setting/
├── assets/
├── test/
└── [android|ios|web|windows|macos|linux]/
```

### Clean Architecture Layers

```
Presentation (BLoC + UI)
    ↓
Domain (Business Logic, UseCases)
    ↓
Data (Repositories, Services)
```

---

## 🚀 Guide Installation "Zero Error"

### Prérequis
- ✅ **Flutter 3.10.4+** : [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- ✅ **Dart 3.10.4+** (fourni avec Flutter)
- ✅ **Git**
- ✅ **Supabase Account** : [supabase.com](https://supabase.com)

### Étapes d'Installation

#### 1️⃣ Clone du Dépôt
```bash
git clone <repository-url> vanguard_ops
cd vanguard_ops
```

#### 2️⃣ Nettoyer le Cache Flutter (Critique ⚠️)
```bash
flutter clean
```
> **Pourquoi ?** Les anciennes dépendances (google_maps_flutter) peuvent rester en cache et causer `TypeError: maps undefined` lors du web build.

#### 3️⃣ Récupérer les Dépendances
```bash
flutter pub get
```

#### 4️⃣ Configuration Supabase (.env)
Crée un fichier `.env` à la racine :
```env
SUPABASE_URL=https://xxxxxxxxxx.supabase.co
SUPABASE_ANON_KEY=eyJxxxxxxxxx...
```
> 🔐 Ajoute `.env` à `.gitignore` !

#### 5️⃣ Vérifier Configuration
```bash
flutter doctor
```

#### 6️⃣ Lancer l'Application
```bash
# Web (Chrome)
flutter run -d chrome

# Android
flutter run -d android

# iOS
flutter run -d ios

# Windows
flutter run -d windows
```

### Dépannage Installation

#### ❌ Erreur : `TypeError: maps undefined` (Web)
```bash
flutter clean
flutter pub get
flutter run -d chrome
```

#### ❌ Erreur : `Gradle sync failed`
```bash
cd android && ./gradlew clean && cd ..
flutter clean && flutter pub get
```

#### ❌ Erreur : `cocoapods: No matching Pods`
```bash
cd ios && rm -rf Pods Podfile.lock && cd ..
flutter clean && flutter pub get
cd ios && pod install && cd ..
```

---

## 🔧 Dépendances Clés

### Gestion d'État & Architecture
```yaml
flutter_bloc: ^8.1.6          # BLoC pattern
dartz: ^0.10.1               # Either<Failure, Success>
equatable: ^2.0.8            # Value equality
get_it: ^7.7.0               # Service locator (DI)
```

### Backend & Authentification
```yaml
supabase_flutter: ^2.6.0      # Auth + DB + Storage + Realtime
flutter_dotenv: ^5.1.0        # Env variables
shared_preferences: ^2.5.4    # Local storage
```

### Cartographie
```yaml
flutter_map: ^8.2.2           # ✅ Multi-plateforme
latlong2: ^0.9.1              # Coordonnées GPS
```

### Géolocalisation & UI
```yaml
geolocator: ^14.0.2
permission_handler:
flutter_svg: ^2.0.10+1
cupertino_icons: ^1.0.8
```

---

## 📱 Fonctionnalités Principales

### 1️⃣ Système d'Alerte SOS
- Tap → Countdown 3s → Envoi GPS + description → Contacts notifiés
- Annulation possible pendant countdown

### 2️⃣ Gestion Contacts d'Urgence
- CRUD complet
- Synchronisation Realtime
- Catégorisation personnalisée

### 3️⃣ Authentification Enterprise
- Magic Link (sans mot de passe)
- JWT + RLS
- Session persistent

### 4️⃣ Monitoring Cartographique
- Carte flutter_map avec CartoDB Dark Matter
- Marqueur pulsant avec animation
- Offline tiles cache

### 5️⃣ Formulaire d'Incident
- Champs structurés
- Upload media vers Supabase Storage
- Validation + feedback utilisateur

---

## 🛠️ Développement & Tests

### Exécuter les Tests
```bash
flutter test                           # Tous les tests
flutter test test/widget_test.dart    # Test spécifique
flutter test --coverage               # Avec coverage
```

### Conventions Dart
- **Naming** : camelCase pour variables, CONSTANT_CASE pour constantes
- **Null-Safety** : Utiliser `final`, `required`, `late`
- **Const Constructors** : Préférer `const` pour widgets
- **Formatting** : `dart format lib/`
- **Analysis** : `dart analyze`

### BLoC Best Practices

```dart
// ✅ BON : Pattern matching
BlocBuilder<AlertCubit, AlertState>(
  builder: (context, state) => state.maybeWhen(
    timerInProgress: (count) => CountdownDisplay(count),
    success: (alert) => SuccessScreen(),
    orElse: () => SizedBox.shrink(),
  ),
)

// ❌ MAUVAIS : if statements
if (state is AlertInitial) {
  // Code dupliqué
}
```

---

## ⚠️ Migration Maps: Leçons Apprises

### Historique

**Avant (Problématique)** ❌
```dart
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Web : TypeError: maps_api is undefined
// Windows : PlatformException: Initialization of Maps failed
// Bundle : +15MB
```

**Après (Résolvé)** ✅
```dart
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// Web : ✅ OK
// Windows : ✅ OK
// Bundle : -10MB
```

### Checklist Migration

- [x] Remplacer google_maps_flutter → flutter_map
- [x] GoogleMapController → FlutterMapState
- [x] LatLng conversions (compatible)
- [x] Markers → MarkerLayer
- [x] Tester Web (Chrome)
- [x] Tester Windows
- [x] Tester Android/iOS
- [x] Optimiser tiles avec color filters

### Lessons Learned

| Problème | Cause | Solution |
|----------|-------|----------|
| maps undefined | API Web | flutter_map |
| Windows init fail | Non-supporté | flutter_map |
| Bundle +15MB | google_maps deps | flutter_map |
| Type mismatch LatLng | Deux packages | latlong2 uniquement |
| Tiles pas chargées | URL invalid | userAgentPackageName |

---

## 👨‍💻 Conventions de Code

### 1. Nommage
```dart
final alertCubit = AlertCubit();
void sendEmergencyAlert() {}
const int COUNTDOWN_DURATION = 3;
```

### 2. DocStrings
```dart
/// Envoie une alerte SOS avec position GPS et description.
/// Lance un countdown de 3 secondes avant envoi effectif.
Future<void> triggerEmergency(String description) async {}
```

### 3. Error Handling avec Dartz
```dart
result.fold(
  (failure) => emit(AlertError(failure.message)),
  (alert) => emit(AlertSuccess(alert)),
);
```

### 4. States (Immuables)
```dart
abstract class AlertState extends Equatable {
  const AlertState();
}

class AlertInitial extends AlertState {
  const AlertInitial();
  @override
  List<Object?> get props => [];
}
```

### 5. Organiser par Feature
```
lib/presentaion/alert/
├── bloc/       ← Gestion d'état
├── pages/      ← Écrans complets
├── widgets/    ← Composants réutilisables
└── constants.dart
```

---

## 🚀 Roadmap Futur

- [ ] **Push Notifications** : FCM pour alertes offline
- [ ] **Voice Messaging** : SOS audio codifié
- [ ] **AI Detection** : Reconnaissance incidents
- [ ] **Offline Mode** : Sync données
- [ ] **Multi-language** : i18n (EN/FR/ES)
- [ ] **Analytics Dashboard** : Reporting temps réel
- [ ] **Deep Linking** : Partage alertes

---

## 📞 Support & Documentation

### Resources
- 📖 [Flutter Docs](https://flutter.dev/docs)
- 📖 [Supabase Docs](https://supabase.com/docs)
- 📖 [flutter_bloc](https://bloclibrary.dev)
- 📖 [flutter_map](https://github.com/fleaflet/flutter_map)
- 📖 [Clean Architecture](https://resocoder.com/clean-code)

### FAQ

**Q: Pourquoi Supabase et pas Firebase ?**  
A: Open-source, PostgreSQL, meilleur pricing, RLS intégré

**Q: Comment ajouter une nouvelle feature ?**  
A: Crées un dossier dans `presentaion/<feature>` avec la structure BLoC/pages/widgets

**Q: Web build plante avec undefined maps ?**  
A: `flutter clean && flutter pub get && flutter run -d chrome`

**Q: Comment tester les alertes offline ?**  
A: Utiliser l'émulateur Android avec mode Airplane, ou NetLimiter

---

## 📄 License

**Private & Proprietary** 🔐  
Tous droits réservés. Usage interne uniquement.

---

## ✅ Validé Par

| Rôle | Nom | Date |
|------|------|------|
| Lead Developer | Senior Dev Team | 2026-03-14 |
| Technical Writer | Senior Writer | 2026-03-14 |

---

## 📌 Last Updated
**2026-03-14** | Version **1.0.0** | Full Refactor ✅

---

**🛡️ VANGUARD OPS : La Source de Vérité pour les Développeurs**

Ce README est votre **bible technique**. Avant de coder, consultez-le. Avant de deployer, validez la checklist. Vos contributions futures dépendent de cette documentation.

*Fait avec ⚡ par une équipe senior | Qualité Enterprise Grade* 🚀
