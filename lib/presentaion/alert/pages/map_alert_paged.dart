import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_cubit.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_state.dart';



class MapAlertPage extends StatelessWidget {
  const MapAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<AlertCubit, AlertState>(
        builder: (context, state) {
          LatLng incidentPos = const LatLng(22.5726, 88.3639); // Default
          
          if (state is AlertSuccess) {
            incidentPos = LatLng(state.alert.latitude, state.alert.longitude);
          }

          return Stack(
            children: [
              // 1. LA CARTE (AVEC CHECK PLATEFORME)
              _buildMap(incidentPos),

              // 2. OVERLAY GRADIENT (Pour le look premium)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),

              // 3. EN-TÊTE (RDAPP)
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kolkata, India - 02/11/2024", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text("RDAPP", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Icon(Icons.person_pin, color: Colors.white, size: 40),
                  ],
                ),
              ),

              // 4. LES BOUTONS D'ACTION (Location / Live Footage)
              Positioned(
                bottom: 180,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(child: _buildStatusTile("Location", "Sharing Location...", Icons.location_on)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildStatusTile("Live Footage", "Recording Video...", Icons.videocam)),
                  ],
                ),
              ),

              // 5. BOUTON CANCEL
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<AlertCubit>().cancelAlert();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          child: const Icon(Icons.close, color: Colors.white, size: 35),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Cancel Alert", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const Text("Emergency Alert triggered in 3s...", style: TextStyle(color: Colors.red, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // GESTION DU SUPPORT PLATEFORME POUR LA CARTE
  Widget _buildMap(LatLng pos) {
    if (!kIsWeb && Platform.isWindows) {
      return Container(
        color: const Color(0xFF121212),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map_outlined, color: Colors.grey, size: 50),
              SizedBox(height: 10),
              Text("Map preview not available on Windows", style: TextStyle(color: Colors.grey)),
              Text("(Simulating GPS Signal...)", style: TextStyle(color: Colors.red, fontSize: 10)),
            ],
          ),
        ),
      );
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(target: pos, zoom: 16),
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      markers: {
        Marker(
          markerId: const MarkerId('me'),
          position: pos,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      },
    );
  }

  Widget _buildStatusTile(String title, String sub, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 10), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}