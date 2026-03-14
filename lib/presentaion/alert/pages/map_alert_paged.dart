import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_cubit.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_state.dart';
import 'package:vanguard_ops/presentaion/alert/widgets/widgets.dart';


class MapAlertPage extends StatelessWidget {
  const MapAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<AlertCubit, AlertState>(
        builder: (context, state) {

          LatLng incidentPos = const LatLng(22.5726, 88.3639);

          if (state is AlertSuccess) {
            incidentPos = LatLng(
              state.alert.latitude,
              state.alert.longitude,
            );
          }

          return Stack(
            children: [
              MapWidget(
                position: incidentPos,
                isInteractive: state is AlertSuccess,
              ),

              const CinematicGradientOverlay(),

              // 3. Header avec localisation et statut
              HeaderWidget(
                location: 'VANGUARD OPS',
                status: 'LIVE SIGNAL',
                onSecurityIconTap: () {
                  // Action optionnelle au tap sur l'icône sécurité
                },
              ),

              // 4. Cartes de statut (GPS, Vidéo)
              if (state is AlertSuccess)
                StatusCardsWidget.gpsAndVideo(),

              // 5. Zone de contrôle avec bouton d'annulation
              if (state is AlertSuccess)
                ControlAreaWidget(
                  onCancelTap: () =>
                      context.read<AlertCubit>().cancelAlert(),
                ),
            ],
          );
        },
      ),
    );
  }
}
