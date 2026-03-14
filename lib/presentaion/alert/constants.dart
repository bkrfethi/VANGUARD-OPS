/// Constantes de style pour le module Alert
/// Thème : Military Grade Dark Mode
library alert_constants;

import 'package:flutter/material.dart';

/// Palettes de couleurs
class AlertColors {
  // Couleurs principales
  static const Color black = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkSurfaceAlt = Color(0xFF1E1E1E);
  static const Color darkInput = Color(0xFF262626);

  // Couleurs d'accent
  static const Color redAccent = Color(0xFFDC143C);
  static const Color redPrimary = Colors.red;
  static const Color greenAccent = Color(0xFF00FF00);

  // Couleurs texte
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF999999);
  static const Color textTertiary = Color(0xFF666666);
}

/// Constantes de spacing et sizes
class AlertDimensions {
  // Padding/Margin standards
  static const double paddingXS = 8.0;
  static const double paddingS = 12.0;
  static const double paddingM = 16.0;
  static const double paddingL = 20.0;
  static const double paddingXL = 24.0;
  static const double paddingXXL = 32.0;

  // Border radius
  static const double radiusS = 12.0;
  static const double radiusM = 16.0;
  static const double radiusL = 20.0;
  static const double radiusXL = 35.0;

  // Icon sizes
  static const double iconXS = 18.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 40.0;
  static const double iconGiant = 50.0;

  // Button sizes
  static const double buttonHeight = 65.0;
  static const double buttonHeightSmall = 50.0;
  static const double sosButtonSize = 200.0;
  static const double cancelButtonSize = 70.0;
}

/// Constantes de typographie
class AlertTypography {
  // Weights
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemiBold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightBlack = FontWeight.w900;

  // Font sizes
  static const double sizeXS = 10.0;
  static const double sizeS = 12.0;
  static const double sizeM = 14.0;
  static const double sizeL = 16.0;
  static const double sizeXL = 18.0;
  static const double sizeXXL = 24.0;
  static const double sizeTitle = 32.0;
}

/// Constantes d'animation
class AlertAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(seconds: 1);
}

/// Constantes de shadow/elevation
class AlertShadows {
  static final List<BoxShadow> subtle = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static final List<BoxShadow> medium = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> prominent = [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
}

/// Constantes de border
class AlertBorders {
  static final Border subtle = Border.all(
    color: Colors.white.withOpacity(0.05),
    width: 1,
  );

  static final Border medium = Border.all(
    color: Colors.white.withOpacity(0.1),
    width: 1,
  );

  static final Border prominent = Border.all(
    color: Colors.white.withOpacity(0.2),
    width: 1,
  );
}

/// Constantes de durée du compte à rebours
class AlertTimerConstants {
  static const int countdownDuration = 3; // secondes
  static const int maxCountdownDuration = 60; // limite max du timer
}

/// Constantes de textes
class AlertTexts {
  // Labels
  static const String labelGps = 'GPS';
  static const String labelVideo = 'VIDEO';
  static const String labelLocation = 'Location';
  static const String labelDescription = 'Description';
  static const String labelFootage = 'Footage';
  static const String labelPicture = 'Picture';

  // Statuts
  static const String statusActive = 'ACTIVE';
  static const String statusRecording = 'RECORDING';
  static const String statusLiveSignal = 'LIVE SIGNAL';
  static const String statusVanguardOps = 'VANGUARD OPS';

  // Actions
  static const String actionReport = 'Report Incident';
  static const String actionCancel = 'CANCEL ALERT';
  static const String actionHoldToCancel = 'HOLD TO CANCEL';
  static const String actionBack = 'Back';
  static const String actionEdit = 'Edit';

  // Messages
  static const String msgDescribeBriefly = 'Give a quick brief.';
  static const String msgRecordLiveVideo = 'Record Live video';
  static const String msgUploadLivePhoto = 'Upload Live photo';
}
