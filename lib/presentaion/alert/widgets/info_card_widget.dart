import 'package:flutter/material.dart';
import 'package:vanguard_ops/presentaion/alert/constants.dart';

class InfoCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onEditTap;
  final bool isEditable;

  const InfoCardWidget({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onEditTap,
    this.isEditable = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AlertDimensions.paddingM),
      decoration: BoxDecoration(
        color: AlertColors.darkSurface,
        borderRadius: BorderRadius.circular(AlertDimensions.radiusM),
        border: AlertBorders.subtle,
        boxShadow: AlertShadows.subtle,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AlertColors.textSecondary,
            size: AlertDimensions.iconS,
          ),
          const SizedBox(width: AlertDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AlertColors.textPrimary,
                    fontSize: AlertTypography.sizeM,
                    fontWeight: AlertTypography.weightSemiBold,
                  ),
                ),
                const SizedBox(height: AlertDimensions.paddingS),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AlertColors.textSecondary,
                    fontSize: AlertTypography.sizeS,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (isEditable)
            GestureDetector(
              onTap: onEditTap,
              child: Icon(
                Icons.edit_outlined,
                color: AlertColors.textTertiary,
                size: AlertDimensions.iconXS,
              ),
            ),
        ],
      ),
    );
  }
}
