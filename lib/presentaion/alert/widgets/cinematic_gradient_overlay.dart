import 'package:flutter/material.dart';
import 'package:vanguard_ops/presentaion/alert/constants.dart';


class CinematicGradientOverlay extends StatelessWidget {
  final bool ignorePointer;

  const CinematicGradientOverlay({
    this.ignorePointer = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ignorePointer,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AlertColors.black.withOpacity(0.6),
              Colors.transparent,
              Colors.transparent,
              AlertColors.black.withOpacity(0.8),
            ],
            stops: const [0.0, 0.2, 0.7, 1.0],
          ),
        ),
      ),
    );
  }
}
