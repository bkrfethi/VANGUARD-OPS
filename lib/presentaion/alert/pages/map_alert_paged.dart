import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_cubit.dart';



class MapAlertPage extends StatelessWidget {
  const MapAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. La Carte (Haut de l'écran)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: const GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(22.5726, 88.3639),
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                ),
              ),
            ),
          ),

          // 2. Les indicateurs de statut (Milieu)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(child: _buildActionTile("Location", "Sharing Location...", Icons.fullscreen_exit)),
                const SizedBox(width: 12),
                Expanded(child: _buildActionTile("Live Footage", "Recording Video...", Icons.videocam)),
              ],
            ),
          ),

          // 3. Bouton Annuler (Bas)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => context.read<AlertCubit>().cancelAlert(),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 40),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Cancel Alert",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Emergency Alert triggered in 3s...",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Méthode manquante définie ici
  Widget _buildActionTile(String title, String status, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red, size: 20),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                Text(status, style: TextStyle(color: Colors.grey[500], fontSize: 10), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}