import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_state.dart';
import '../bloc/alert_cubit.dart';

class MapAlertPage extends StatelessWidget {
  const MapAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<AlertCubit, AlertState>(
        builder: (context, state) {
          if (state is AlertSuccess) {
            final alert = state.alert;
            final incidentPos = LatLng(alert.latitude, alert.longitude);

            return Stack(
              children: [
                // 1. La Carte avec le marqueur rouge
                GoogleMap(
                  initialCameraPosition: CameraPosition(target: incidentPos, zoom: 16),
                  // backgroundColor: Colors.black,
                  // mapType: MapType.dark, // Si tu as un style JSON Dark
                  markers: {
                    Marker(
                      markerId: const MarkerId('incident_marker'),
                      position: incidentPos,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    ),
                  },
                ),

                // 2. L'overlay d'infos (comme sur ton design)
                Positioned(
                  bottom: 40,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      _buildInfoTile("Status", "Incident Created (Open)", Icons.check_circle),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => context.read<AlertCubit>().cancelAlert(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                        ),
                        child: const Icon(Icons.close, size: 30, color: Colors.white),
                      ),
                      const Text("Cancel Alert", style: TextStyle(color: Colors.white, height: 2)),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator(color: Colors.red));
        },
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.8), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}