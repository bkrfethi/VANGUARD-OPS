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
          // Coordonnées par défaut (Kolkata comme sur ton screen)
          LatLng incidentPos = const LatLng(22.5726, 88.3639);
          
          if (state is AlertSuccess) {
            incidentPos = LatLng(state.alert.latitude, state.alert.longitude);
          }

          return Stack(
            children: [
              // 1. FOND : Carte ou Placeholder Windows
              _buildMapBackground(incidentPos),

              // 2. OVERLAY GRADIENT (Assombrit le haut et le bas)
              _buildGradientOverlay(),

              // 3. EN-TÊTE (Localisation et Logo)
              _buildHeader(),

              // 4. BOUTONS D'ÉTAT (Location / Live Footage)
              _buildActionStatusArea(),

              // 5. ZONE DE CONTRÔLE (Bouton Annuler + Timer)
              _buildControlArea(context),
            ],
          );
        },
      ),
    );
  }

  // Header avec Date et Nom de l'App
  Widget _buildHeader() {
    return Positioned(
      top: 60,
      left: 25,
      right: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kolkata, India - 02/11/2024",
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
              ),
              Text(
                "RDAPP",
                style: TextStyle(color: Colors.white, fontSize: 28,  letterSpacing: 1.2),
              ),
            ],
          ),
          const CircleAvatar(
            backgroundColor: Color(0xFF1A1A1A),
            child: Icon(Icons.person, color: Colors.white),
          )
        ],
      ),
    );
  }

  // Zone des boutons Location et Footage
  Widget _buildActionStatusArea() {
    return Positioned(
      bottom: 160,
      left: 20,
      right: 20,
      child: Row(
        children: [
          Expanded(child: _statusCard("Location", "Sharing Location...", Icons.location_on)),
          const SizedBox(width: 12),
          Expanded(child: _statusCard("Live Footage", "Recording Video...", Icons.videocam)),
        ],
      ),
    );
  }

  // Widget de carte de statut (Style sombre)
  Widget _statusCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF121212).withOpacity(0.9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bouton d'annulation et Timer
  Widget _buildControlArea(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const  EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 80, width: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 20, spreadRadius: 5)],
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 40),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Cancel Alert", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text("Emergency Alert triggered in 3s...", style: TextStyle(color: Colors.redAccent, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  // Gestion de la carte vs Windows
  Widget _buildMapBackground(LatLng pos) {
    if (!kIsWeb && Platform.isWindows) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF0A0A0A),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map_outlined, color: Colors.white.withOpacity(0.1), size: 100),
              const SizedBox(height: 10),
              Text("MAP PREVIEW NOT AVAILABLE ON WINDOWS", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10, letterSpacing: 1.5)),
            ],
          ),
        ),
      );
    }
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: pos, zoom: 16),
      mapType: MapType.normal, 
      zoomControlsEnabled: false,
      markers: { Marker(markerId: const MarkerId('sos'), position: pos) },
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withOpacity(0.8), Colors.transparent, Colors.transparent, Colors.black],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
      ),
    );
  }
}