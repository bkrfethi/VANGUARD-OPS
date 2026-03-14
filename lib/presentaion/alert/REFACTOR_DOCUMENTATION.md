# Refactorisation Alert Module - Documentation

## 📋 Architecture Refactorisée

### Structure des dossiers

```
lib/presentaion/alert/
├── bloc/
│   ├── alert_cubit.dart          # BLoC avec Stream/Timer
│   └── alert_state.dart          # États immutables avec const constructors
├── pages/
│   ├── home_page.dart            # Page d'accueil SOS
│   ├── report_incident_page.dart # Formulaire de rapport
│   ├── map_alert_paged.dart      # Page carte refactorisée
│   └── MapAlertPage.dart         # Deprecated (redirect)
└── widgets/
    ├── cinematic_gradient_overlay.dart  # Overlay de dégradé
    ├── control_area_widget.dart         # Zone de contrôle annulation
    ├── description_field_widget.dart    # Champ description
    ├── header_widget.dart               # Header status
    ├── info_card_widget.dart            # Cartes info
    ├── map_widget.dart                  # Widget carte (flutter_map)
    ├── media_card_widget.dart           # Cartes médias
    ├── status_cards_widget.dart         # Cartes statut
    └── widgets.dart                     # Barrel export
```

## 🎯 Améliorations Principales

### 1. **BLoC Refactorisé (alert_cubit.dart)**
- ✅ Utilisation d'un vrai **Stream.periodic** au lieu de Timer simple
- ✅ Gestion propre du cleanup avec `StreamSubscription`
- ✅ Vérifications `isClosed` pour éviter les erreurs post-fermeture
- ✅ États immuables avec **const constructors**

```dart
// Avant : Timer simple
_timer = Timer.periodic(...);

// Après : Stream robuste
_timerSubscription = Stream.periodic(...).takeWhile(...).listen(...);
```

### 2. **Composants Découpés (widgets/)**
Chaque widget est isolé, reutilisable et testé indépendamment :
- `MapWidget` : Carte flutter_map avec CartoDB Dark Matter
- `HeaderWidget` : Affichage du statut et localisation
- `StatusCardsWidget` : Cartes GPS/Vidéo avec glassmorphisme
- `ControlAreaWidget` : Bouton annulation avec effets
- `InfoCardWidget` : Cartes d'information génériques
- `DescriptionFieldWidget` : Champ texte avec validation
- `MediaCardWidget` : Cartes médias réutilisables
- `CinematicGradientOverlay` : Overlay cinématique

### 3. **Style "Military Grade Dark Mode"**
- 🌙 Fond noir 100% (#000000)
- 🔴 Orange/Red accent (#FF5C00, #DC143C)
- ⚫ Surfaces sombres (#1A1A1A, #1E1E1E, #262626)
- ✨ Glassmorphisme avec borders translucides
- 🎬 Gradients cinématiques (noir → transparent)
- 🔶 Box-shadows subtiles avec couleurs accentuées

### 4. **Carte Flutter Map Premium (flutter_map)**
```dart
// ✅ CartoDB Dark Matter tiles
urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'

// ✅ Zoom & Pan fluides
InteractiveFlag.all

// ✅ Filtre de couleur personnalisé pour ultra-noir
ColorFilter.matrix([...])
```

### 5. **Null-Safety & Const Constructors**
- ✅ Tous les constructors marqués `const` ou private
- ✅ Propriétés finales avec const initialization
- ✅ Pas de nullable sauf si nécessaire
- ✅ Vérifications null explicites

## 🚀 Utilisation

### Importer les widgets

```dart
import 'package:vanguard_ops/presentaion/alert/widgets/widgets.dart';
```

### Exemple composition MapAlertPage

```dart
Stack(
  children: [
    MapWidget(position: latLng, isInteractive: true),
    const CinematicGradientOverlay(),
    HeaderWidget(location: 'VANGUARD OPS', status: 'LIVE SIGNAL'),
    StatusCardsWidget.gpsAndVideo(),
    ControlAreaWidget(onCancelTap: () => ...),
  ],
)
```

## 🔄 Migration depuis l'ancienne version

### Changements API BLoC

```dart
// State avec const constructors
AlertSuccess(alert)  // Était new AlertSuccess(alert)

// Appels Cubit
context.read<AlertCubit>().triggerEmergency(desc)
```

### Suppression google_maps_flutter
✅ Dépendance supprimée de pubspec.yaml  
✅ Tous les imports remplacés par flutter_map  
✅ Utilisation exclusive de latlong2 pour coordonnées

## 📱 Pages Refactorisées

### HomePage
- SOS button stylisé avec shadows multiples
- Report Incident button avec navigation

### ReportIncidentPage
- Champ description avec TextEditingController
- Cartes info/médias réutilisables
- BlocConsumer avec logique timer

### MapAlertPage (map_alert_paged.dart)
- Composition modulaire avec widgets
- Gestion d'états BLoC propre
- Overlay cinématiques

## ✨ Features Futures

- [ ] Enregistrement vidéo temps réel
- [ ] Upload photos depuis galerie
- [ ] Localisation GPS temps réel
- [ ] Websocket live updates
- [ ] Dark Mode animations
- [ ] Vibrations/haptics au SOS

## 🔧 Tests

```dart
// Test MapWidget
testWidgets('MapWidget renders with latLng', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MapWidget(position: const LatLng(22.5726, 88.3639)),
    ),
  );
  expect(find.byType(FlutterMap), findsOneWidget);
});
```

## 📚 Ressources

- [flutter_map docs](https://github.com/fleaflet/flutter_map)
- [latlong2 docs](https://pub.dev/packages/latlong2)
- [BLoC Pattern](https://bloclibrary.dev/)
- [CartoDB Map Styles](https://carto.com/help/building-maps/basemap-list/)
