import 'package:flutter/material.dart';
import 'package:vanguard_ops/presentaion/alert/constants.dart';

/// Carte pour les actions médias (vidéo, photo)
class MediaCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onTap;

  const MediaCardWidget({
    required this.title,
    required this.description,
    required this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AlertDimensions.paddingM),
        decoration: BoxDecoration(
          color: AlertColors.darkSurface,
          borderRadius: BorderRadius.circular(AlertDimensions.radiusM),
          border: AlertBorders.subtle,
          boxShadow: AlertShadows.subtle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icône
            Icon(
              icon,
              color: AlertColors.textSecondary,
              size: AlertDimensions.iconL,
            ),
            const SizedBox(height: AlertDimensions.paddingM),
            // Titre
            Text(
              title,
              style: const TextStyle(
                color: AlertColors.textPrimary,
                fontSize: AlertTypography.sizeM,
                fontWeight: AlertTypography.weightBold,
              ),
            ),
            const SizedBox(height: AlertDimensions.paddingS),
            // Description
            Text(
              description,
              style: const TextStyle(
                color: AlertColors.textSecondary,
                fontSize: AlertTypography.sizeXS,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
