import 'package:flutter/material.dart';
import 'package:vanguard_ops/presentaion/alert/constants.dart';

/// Header widget pour les pages d'alerte
/// Style : Military Grade Dark Mode avec gradients et effets de flou
class HeaderWidget extends StatelessWidget {
  final String location;
  final String status;
  final VoidCallback? onSecurityIconTap;

  const HeaderWidget({
    required this.location,
    required this.status,
    this.onSecurityIconTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AlertDimensions.paddingL,
          vertical: AlertDimensions.paddingXL,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AlertColors.black.withOpacity(0.95),
              AlertColors.black.withOpacity(0.8),
              Colors.transparent,
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Section gauche : Location & Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label de statut avec underscore
                  Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: AlertColors.redAccent.withOpacity(0.8),
                      fontSize: AlertTypography.sizeXS,
                      fontWeight: AlertTypography.weightBold,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: AlertDimensions.paddingS),
                  // Titre principal
                  Text(
                    location,
                    style: const TextStyle(
                      color: AlertColors.textPrimary,
                      fontSize: AlertTypography.sizeTitle,
                      fontWeight: AlertTypography.weightBlack,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              // Section droite : Security icon
              GestureDetector(
                onTap: onSecurityIconTap,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: AlertDimensions.paddingM,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: AlertColors.darkSurface,
                    child: Icon(
                      Icons.security,
                      color: Colors.white.withOpacity(0.9),
                      size: AlertDimensions.iconS,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
