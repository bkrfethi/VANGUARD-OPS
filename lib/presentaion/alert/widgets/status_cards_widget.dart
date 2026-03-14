import 'package:flutter/material.dart';
import 'package:vanguard_ops/presentaion/alert/constants.dart';


class StatusCardsWidget extends StatelessWidget {
  final List<_StatusCardData> cards;

  const StatusCardsWidget({
    required this.cards,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 180,
      left: AlertDimensions.paddingL,
      right: AlertDimensions.paddingL,
      child: Row(
        children: List.generate(
          cards.length,
          (index) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index < cards.length - 1 ? AlertDimensions.paddingM : 0,
              ),
              child: _StatusCard(data: cards[index]),
            ),
          ),
        ),
      ),
    );
  }

  static StatusCardsWidget gpsAndVideo() {
    return StatusCardsWidget(
      cards: [
        _StatusCardData(
          title: AlertTexts.labelGps,
          status: AlertTexts.statusActive,
          icon: Icons.gps_fixed,
          accentColor: AlertColors.greenAccent,
        ),
        _StatusCardData(
          title: AlertTexts.labelVideo,
          status: AlertTexts.statusRecording,
          icon: Icons.videocam,
          accentColor: AlertColors.redAccent,
        ),
      ],
    );
  }
}

class _StatusCardData {
  final String title;
  final String status;
  final IconData icon;
  final Color accentColor;

  const _StatusCardData({
    required this.title,
    required this.status,
    required this.icon,
    required this.accentColor,
  });
}

class _StatusCard extends StatelessWidget {
  final _StatusCardData data;

  const _StatusCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AlertDimensions.paddingM),
      decoration: BoxDecoration(
        color: AlertColors.darkSurfaceAlt.withOpacity(0.85),
        borderRadius: BorderRadius.circular(AlertDimensions.radiusL),
        border: AlertBorders.medium,
        boxShadow: AlertShadows.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            data.icon,
            color: data.accentColor,
            size: AlertDimensions.iconS,
          ),
          const SizedBox(height: AlertDimensions.paddingM),
          Text(
            data.title,
            style: TextStyle(
              color: AlertColors.textSecondary.withOpacity(0.6),
              fontSize: AlertTypography.sizeXS,
              fontWeight: AlertTypography.weightBold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AlertDimensions.paddingS),
          Text(
            data.status,
            style: const TextStyle(
              color: AlertColors.textPrimary,
              fontSize: AlertTypography.sizeL,
              fontWeight: AlertTypography.weightBold,
            ),
          ),
        ],
      ),
    );
  }
}
