<!-- <!-- # 🛡️ VANGUARD OPS - RDAPP
## *Tactical Security Response Application - Enterprise Edition*

![Vanguard](https://img.shields.io/badge/Vanguard%20Ops-v1.0.0-DC143C?style=for-the-badge&logo=flutter&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-3.10.4%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.10.4%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2F%20BLOC-FF6B6B?style=for-the-badge)
![Backend](https://img.shields.io/badge/Backend-Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![License](https://img.shields.io/badge/License-Private-red?style=for-the-badge)

---

## 📋 Table of Contents

1. [🎯 Overview](#-overview)
2. [🏗️ Technical Architecture](#️-technical-architecture)
3. [⚡ Alert Module - Heart of the Project](#-alert-module---heart-of-the-project)
4. [🎨 Design System "Tactical Dark"](#-design-system-tactical-dark)
5. [📦 Project Structure](#-project-structure)
6. [🚀 Installation Guide "Zero Error"](#-installation-guide-zero-error)
7. [🔧 Key Dependencies](#-key-dependencies)
8. [📱 Main Features](#-main-features)
9. [🛠️ Development & Testing](#️-development--testing)
10. [⚠️ Maps Migration: Lessons Learned](#️-maps-migration-lessons-learned)
11. [👨‍💻 Code Conventions](#-code-conventions)

---

## 🎯 Overview

**VANGUARD OPS** is a **premium** tactical security application designed for emergency response teams (Police, Firefighters, Rescue Services). It enables real-time alert management with instant geolocation, emergency contact communication, and centralized monitoring system.

### Key Features
- ✅ **Tactical Alerts** : SOS deployment with intelligent countdown (3 seconds)
- ✅ **Precise Geolocation** : flutter_map + latlong2 integration (OpenStreetMap)
- ✅ **Enterprise Authentication** : Supabase Auth with SSO
- ✅ **Real-Time Backend** : Supabase Realtime for alerts/contacts
- ✅ **Military Design** : "Tactical Dark" interface with CartoDB Dark Matter
- ✅ **Multi-Platform** : iOS, Android, Web, Windows, macOS, Linux

### Target Audience
👮 Law Enforcement Agents  
🚒 Firefighters & Rescue Teams  
⚠️ Tactical Security Personnel  
🏙️ Emergency Operations Centers (PSAP/SAMU)

---

## 🏗️ Technical Architecture

### 1️⃣ BLoC/Cubit Pattern - Reactive State Management

The application uses **flutter_bloc** for professional and scalable state management.

```dart
// Cubits Hierarchy
AlertCubit          → SOS Alerts & countdown management
SigninCubit         → User Authentication
ContactsCubit       → Emergency Contacts CRUD
SettingsCubit       → User Preferences
NavigationCubit     → Routing & tab navigation
```

**Cubit Advantage** : Lighter than BLoC, ideal for simple state mutations with clear asynchronous logic.

```dart
// Example : AlertCubit with robust Stream.periodic
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

### 2️⃣ Supabase - Serverless Backend

Complete **Supabase** stack integration:

- **Authentication** : JWT, Magic Links, auth.currentUser
- **Database** : PostgreSQL with RLS (Row-Level Security)
- **Storage** : Incident photos & media files
- **Realtime** : WebSocket for real-time alert sync

**Services Architecture:**

```
Data Layer (Supabase Services)
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

#### 🐛 Errors Encountered

```
❌ TypeError: maps_api is undefined (Web)
❌ PlatformException: Initialization of Maps failed (Windows)
❌ Type incompatibility for web platform
```

**Implemented Solution**: 
- ✅ `flutter_map: ^8.2.2` (Pure Dart fork, multi-platform)
- ✅ `latlong2: ^0.9.1` (Coordinate management)
- ✅ **CartoDB Dark Matter tiles** for military aesthetics

#### 🗺️ Cartographic Configuration

```dart
// Map avec tiles CartoDB Dark Matter (Military Grade)
TileLayer(
  urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
  subdomains: const ['a', 'b', 'c'],
  userAgentPackageName: 'com.vanguard.ops',
)
```

---

## ⚡ Alert Module - Heart of the Project

### Modular Architecture: 8 Composable Widgets

```
lib/presentaion/alert/
├── bloc/
│   ├── alert_cubit.dart           # 3s countdown logic
│   └── alert_state.dart           # UI States
├── pages/
│   ├── home_page.dart             # SOS Button
│   ├── map_alert_paged.dart       # Alert + Map
│   └── report_incident_page.dart  # Incident form
├── widgets/                        # 8 reusable components
│   ├── cinematic_gradient_overlay.dart
│   ├── control_area_widget.dart
│   ├── description_field_widget.dart
│   ├── header_widget.dart
│   ├── info_card_widget.dart
│   ├── map_widget.dart
│   ├── media_card_widget.dart
│   ├── status_cards_widget.dart
│   └── widgets.dart               # Barrel export
└── constants.dart                 # Centralized theme
```

### 🔴 3-Second Countdown Logic (Stream.periodic)

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
1. Tap the **SOS** button → `AlertLoading` state
2. App retrieves GPS 📍
3. Countdown displays **3... 2... 1...**
4. At **0 seconds**, alert is sent to Supabase
5. State changes to `AlertSuccess` with summary

---

## 🎨 Design System "Tactical Dark"

### Color Palette (AlertColors)

```dart
// Dark surfaces (Military Grade look)
Color.black              = #000000
Color.darkSurface        = #1A1A1A
Color.darkSurfaceAlt     = #1E1E1E
Color.darkInput          = #262626

// Accent colors
Color.redAccent          = #DC143C  (Crimson - Alert)
Color.greenAccent        = #00FF00  (Success)

// Text colors
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

### Senior UI Components 🎯

1. **SOS Button** : Circle 200x200 with double shadow glow effect
2. **Glassmorphism** : semi-transparent overlays with gradients
3. **Pulsing Marker** : Breathing effect on map
4. **CartoDB Dark Matter** : Tiles with color inversion (NVG style)

---

## 📦 Project Structure

### Tree Structure (Clean Architecture)

```
vanguard_ops/
├── lib/
│   ├── main.dart                    Entry point
│   ├── service_loacator.dart        GetIt DI setup
│   ├── common/                      Common components
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
│       ├── alert/                   ⭐ HEART OF PROJECT
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

## 🚀 Installation Guide "Zero Error"

### Prerequisites
- ✅ **Flutter 3.10.4+** : [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- ✅ **Dart 3.10.4+** (provided with Flutter)
- ✅ **Git**
- ✅ **Supabase Account** : [supabase.com](https://supabase.com)

### Installation Steps

#### 1️⃣ Clone Repository
```bash
git clone <repository-url> vanguard_ops
cd vanguard_ops
```

#### 2️⃣ Clean Flutter Cache (Critical ⚠️)
```bash
flutter clean
```
> **Why?** Old dependencies (google_maps_flutter) can remain in cache and cause `TypeError: maps undefined` on web build.

#### 3️⃣ Get Dependencies
```bash
flutter pub get
```

#### 4️⃣ Supabase Configuration (.env)
Create a `.env` file at the root:
```env
SUPABASE_URL=https://xxxxxxxxxx.supabase.co
SUPABASE_ANON_KEY=eyJxxxxxxxxx...
```
> 🔐 Add `.env` to `.gitignore`!

#### 5️⃣ Verify Configuration
```bash
flutter doctor
```

#### 6️⃣ Launch Application
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

### Installation Troubleshooting

#### ❌ Error: `TypeError: maps undefined` (Web)
```bash
flutter clean
flutter pub get
flutter run -d chrome
```

#### ❌ Error: `Gradle sync failed`
```bash
cd android && ./gradlew clean && cd ..
flutter clean && flutter pub get
```

#### ❌ Error: `cocoapods: No matching Pods`
```bash
cd ios && rm -rf Pods Podfile.lock && cd ..
flutter clean && flutter pub get
cd ios && pod install && cd ..
```

---

## 🔧 Key Dependencies

### State Management & Architecture
```yaml
flutter_bloc: ^8.1.6          # BLoC pattern
dartz: ^0.10.1               # Either<Failure, Success>
equatable: ^2.0.8            # Value equality
get_it: ^7.7.0               # Service locator (DI)
```

### Backend & Authentication
```yaml
supabase_flutter: ^2.6.0      # Auth + DB + Storage + Realtime
flutter_dotenv: ^5.1.0        # Env variables
shared_preferences: ^2.5.4    # Local storage
```

### Mapping
```yaml
flutter_map: ^8.2.2           # ✅ Multi-platform
latlong2: ^0.9.1              # GPS Coordinates
```

### Geolocation & UI
```yaml
geolocator: ^14.0.2
permission_handler:
flutter_svg: ^2.0.10+1
cupertino_icons: ^1.0.8
```

---

## 📱 Main Features

### 1️⃣ SOS Alert System
- Tap → 3s Countdown → Send GPS + description → Contacts notified
- Cancellation possible during countdown

### 2️⃣ Emergency Contact Management
- Full CRUD
- Real-time synchronization
- Custom categorization

### 3️⃣ Enterprise Authentication
- Magic Link (no password)
- JWT + RLS
- Persistent session

### 4️⃣ Cartographic Monitoring
- flutter_map with CartoDB Dark Matter
- Pulsing marker with animation
- Offline tiles cache

### 5️⃣ Incident Form
- Structured fields
- Media upload to Supabase Storage
- Validation + user feedback

---

## 🛠️ Development & Testing

### Run Tests
```bash
flutter test                           # All tests
flutter test test/widget_test.dart    # Specific test
flutter test --coverage               # With coverage
```

### Dart Conventions
- **Naming** : camelCase for variables, CONSTANT_CASE for constants
- **Null-Safety** : Use `final`, `required`, `late`
- **Const Constructors** : Prefer `const` for widgets
- **Formatting** : `dart format lib/`
- **Analysis** : `dart analyze`

### BLoC Best Practices

```dart
// ✅ GOOD : Pattern matching
BlocBuilder<AlertCubit, AlertState>(
  builder: (context, state) => state.maybeWhen(
    timerInProgress: (count) => CountdownDisplay(count),
    success: (alert) => SuccessScreen(),
    orElse: () => SizedBox.shrink(),
  ),
)

// ❌ BAD : if statements
if (state is AlertInitial) {
  // Duplicated code
}
```

---

## ⚠️ Maps Migration: Lessons Learned

### History

**Before (Problematic)** ❌
```dart
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Web : TypeError: maps_api is undefined
// Windows : PlatformException: Initialization of Maps failed
// Bundle : +15MB
```

**After (Resolved)** ✅
```dart
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// Web : ✅ OK
// Windows : ✅ OK
// Bundle : -10MB
```

### Migration Checklist

- [x] Replace google_maps_flutter → flutter_map
- [x] GoogleMapController → FlutterMapState
- [x] LatLng conversions (compatible)
- [x] Markers → MarkerLayer
- [x] Test Web (Chrome)
- [x] Test Windows
- [x] Test Android/iOS
- [x] Optimize tiles with color filters

### Lessons Learned

| Problem | Root Cause | Solution |
|---------|-----------|----------|
| maps undefined | API Web | flutter_map |
| Windows init fail | Not supported | flutter_map |
| Bundle +15MB | google_maps deps | flutter_map |
| Type mismatch LatLng | Two packages | latlong2 only |
| Tiles not loading | Invalid URL | userAgentPackageName |

---

## 👨‍💻 Code Conventions

### 1. Naming
```dart
final alertCubit = AlertCubit();
void sendEmergencyAlert() {}
const int COUNTDOWN_DURATION = 3;
```

### 2. DocStrings
```dart
/// Sends an SOS alert with GPS position and description.
/// Launches a 3-second countdown before actual send.
Future<void> triggerEmergency(String description) async {}
```

### 3. Error Handling with Dartz
```dart
result.fold(
  (failure) => emit(AlertError(failure.message)),
  (alert) => emit(AlertSuccess(alert)),
);
```

### 4. States (Immutable)
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

### 5. Organize by Feature
```
lib/presentaion/alert/
├── bloc/       ← State management
├── pages/      ← Full screens
├── widgets/    ← Reusable components
└── constants.dart
```

---

## 🚀 Future Roadmap

- [ ] **Push Notifications** : FCM for offline alerts
- [ ] **Voice Messaging** : Coded audio SOS
- [ ] **AI Detection** : Incident recognition
- [ ] **Offline Mode** : Data sync
- [ ] **Multi-language** : i18n (EN/FR/ES)
- [ ] **Analytics Dashboard** : Real-time reporting
- [ ] **Deep Linking** : Share alerts

---

## 📞 Support & Documentation

### Resources
- 📖 [Flutter Docs](https://flutter.dev/docs)
- 📖 [Supabase Docs](https://supabase.com/docs)
- 📖 [flutter_bloc](https://bloclibrary.dev)
- 📖 [flutter_map](https://github.com/fleaflet/flutter_map)
- 📖 [Clean Architecture](https://resocoder.com/clean-code)

### FAQ

**Q: Why Supabase instead of Firebase?**  
A: Open-source, PostgreSQL, better pricing, integrated RLS

**Q: How to add a new feature?**  
A: Create a folder in `presentaion/<feature>` with BLoC/pages/widgets structure

**Q: Web build fails with undefined maps?**  
A: `flutter clean && flutter pub get && flutter run -d chrome`

**Q: How to test alerts offline?**  
A: Use Android emulator with Airplane mode, or NetLimiter

---

## 📄 License

**Private & Proprietary** 🔐  
All rights reserved. Internal use only.

---

## ✅ Validated By

| Role | Name | Date |
|------|------|------|
| Lead Developer | Senior Dev Team | 2026-03-14 |
| Technical Writer | Senior Writer | 2026-03-14 |

---

## 📌 Last Updated
**2026-03-14** | Version **1.0.0** | Full Refactor ✅

---

**🛡️ VANGUARD OPS : The Source of Truth for Developers**

This README is your **technical bible**. Before coding, consult it. Before deploying, validate the checklist. Your future contributions depend on this documentation.

*Made with ⚡ by a senior team | Enterprise Grade Quality*  -->