import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vanguard_ops/presentaion/alert/constants.dart';

/// Widget de carte pessimiste avec flutter_map
/// Style : Military Grade Dark Mode avec CartoDB Dark Matter
class MapWidget extends StatelessWidget {
  final LatLng position;
  final bool isInteractive;

  const MapWidget({
    required this.position,
    this.isInteractive = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: position,
        initialZoom: 15,
        minZoom: 3,
        maxZoom: 18,
        interactionOptions: InteractionOptions(
          flags: isInteractive ? InteractiveFlag.all : InteractiveFlag.none,
        ),
      ),
      children: [
        // Couche de tuiles CartoDB Dark Matter
        TileLayer(
          urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.vanguard.ops',
          // Filtre de couleur personnalisé pour un look encore plus sombre
          tileBuilder: (context, tileWidget, tile) {
            return ColorFiltered(
              colorFilter: const ColorFilter.matrix([
                -0.8, 0, 0, 0, 200,
                0, -0.8, 0, 0, 200,
                0, 0, -0.8, 0, 200,
                0, 0, 0, 1, 0,
              ]),
              child: tileWidget,
            );
          },
        ),
        // Couche de marqueurs avec pulsation
        MarkerLayer(
          markers: [
            Marker(
              point: position,
              width: 120,
              height: 120,
              child: _buildPulsingMarker(),
            ),
          ],
        ),
      ],
    );
  }

  /// Construit le marqueur avec effet de pulsation
  static Widget _buildPulsingMarker() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Anneau extérieur pulsant
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AlertColors.redAccent.withOpacity(0.1),
            border: Border.all(
              color: AlertColors.redAccent.withOpacity(0.6),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AlertColors.redAccent.withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        // Icône de localisation au centre
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Icon(
            Icons.location_on,
            color: AlertColors.redAccent,
            size: AlertDimensions.iconXL,
          ),
        ),
      ],
    );
  }
}
