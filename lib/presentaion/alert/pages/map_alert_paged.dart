import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_cubit.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_state.dart';
import 'package:latlong2/latlong.dart'; 
import 'package:flutter_map/flutter_map.dart';


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
            incidentPos = LatLng(state.alert.latitude, state.alert.longitude);
          }

          return Stack(
            children: [
              // 1. IMPROVED MAP BACKGROUND
              _buildMapBackground(incidentPos),

              // 2. CINEMATIC OVERLAYS
              _buildGradientOverlay(),

              // 3. MODERN HEADER
              _buildHeader(),

              // 4. BEAUTIFIED STATUS AREA (Glassmorphism)
              _buildActionStatusArea(),

              // 5. CONTROL AREA
              _buildControlArea(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMapBackground(LatLng pos) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: pos,
        initialZoom: 15,
        minZoom: 3,
        maxZoom: 18,
        // ENABLE ZOOM & PAN HERE
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all, 
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          // IMPROVED DARK FILTER (Tighter contrast)
          tileBuilder: (context, tileWidget, tile) {
            return ColorFiltered(
              colorFilter: const ColorFilter.matrix([
                -0.9, 0, 0, 0, 255,
                0, -0.9, 0, 0, 255,
                0, 0, -0.9, 0, 255,
                0, 0, 0, 1, 0,
              ]),
              child: tileWidget,
            );
          },
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: pos,
              width: 120,
              height: 120,
              child: _buildPulsingMarker(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPulsingMarker() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulsing Ring Effect
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.withOpacity(0.2),
            border: Border.all(color: Colors.redAccent, width: 2),
          ),
        ),
        const Icon(Icons.location_on, color: Colors.redAccent, size: 45),
      ],
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kolkata, India • LIVE SIGNAL",
                  style: TextStyle(
                    color: Colors.redAccent.withOpacity(0.8),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const Text(
                  "VANGUARD OPS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24),
              ),
              child: const CircleAvatar(
                backgroundColor: Color(0xFF1A1A1A),
                child: Icon(Icons.security, color: Colors.white, size: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionStatusArea() {
    return Positioned(
      bottom: 180,
      left: 20,
      right: 20,
      child: Row(
        children: [
          Expanded(child: _statusCard("GPS", "ACTIVE", Icons.gps_fixed, Colors.greenAccent)),
          const SizedBox(width: 12),
          Expanded(child: _statusCard("VIDEO", "RECORDING", Icons.videocam, Colors.redAccent)),
        ],
      ),
    );
  }

  Widget _statusCard(String title, String status, IconData icon, Color accent) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Glassmorphism effect
        color: const Color(0xFF1E1E1E).withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
          Text(status, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildControlArea(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.red.withOpacity(0.5), blurRadius: 25, spreadRadius: 2)
                  ],
                ),
                child: const Icon(Icons.power_settings_new, color: Colors.white, size: 35),
              ),
            ),
            const SizedBox(height: 15),
            const Text("HOLD TO CANCEL", style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 2)),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.transparent,
              Colors.transparent,
              Colors.black.withOpacity(0.8)
            ],
            stops: const [0.0, 0.2, 0.7, 1.0],
          ),
        ),
      ),
    );
  }
}