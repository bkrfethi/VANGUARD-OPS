import 'package:flutter/material.dart';
import 'package:vanguard_ops/presentaion/alert/constants.dart';


class ControlAreaWidget extends StatelessWidget {
  final VoidCallback onCancelTap;
  final bool isEnabled;

  const ControlAreaWidget({
    required this.onCancelTap,
    this.isEnabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AlertColors.black.withOpacity(0.7),
              AlertColors.black.withOpacity(0.95),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bouton d'annulation circulaire
            GestureDetector(
              onTap: isEnabled ? onCancelTap : null,
              child: AnimatedContainer(
                duration: AlertAnimations.fast,
                height: AlertDimensions.cancelButtonSize,
                width: AlertDimensions.cancelButtonSize,
                decoration: BoxDecoration(
                  color: AlertColors.redPrimary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AlertColors.redPrimary.withOpacity(0.6),
                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: AlertColors.redPrimary.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 8,
                    ),
                  ],
                 // opacity: isEnabled ? 1.0 : 0.6,
                ),
                child: const Icon(
                  Icons.power_settings_new,
                  color: AlertColors.textPrimary,
                  size: AlertDimensions.iconL,
                ),
              ),
            ),
            const SizedBox(height: AlertDimensions.paddingXL),
            // Texte d'instruction
            Text(
              AlertTexts.actionHoldToCancel,
              style: TextStyle(
                color: AlertColors.textPrimary.withOpacity(0.7),
                fontSize: AlertTypography.sizeS,
                fontWeight: AlertTypography.weightBold,
                letterSpacing: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
