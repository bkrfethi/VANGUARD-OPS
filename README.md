<! 🛡️ VANGUARD OPS - RDAPP
 *Tactical Security Response Application - Enterprise Edition*

![Vanguard](https://img.shields.io/badge/Vanguard%20Ops-v1.0.0-DC143C?style=for-the-badge&logo=flutter&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-3.10.4%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.10.4%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2F%20BLOC-FF6B6B?style=for-the-badge)
![Backend](https://img.shields.io/badge/Backend-Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![License](https://img.shields.io/badge/License-Private-red?style=for-the-badge)

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
│       ├── alert/                   
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
git clone https://github.com/bkrfethi/VANGUARD-OPS.git
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
flutter_map: ^8.2.2           #  Multi-platform
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

## 🚀 Future Roadmap

- [ ] **Push Notifications** : FCM for offline alerts
- [ ] **Voice Messaging** : Coded audio SOS
- [ ] **AI Detection** : Incident recognition
- [ ] **Offline Mode** : Data sync
- [ ] **Multi-language** : i18n (EN/FR/ES)
- [ ] **Analytics Dashboard** : Real-time reporting
- [ ] **Deep Linking** : Share alerts

---