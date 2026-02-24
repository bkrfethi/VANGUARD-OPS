import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vanguard_ops/core/config/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:vanguard_ops/core/config/assets/app_images.dart';

class RdAppBar extends StatelessWidget {
  const RdAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 20), // Padding pour l'encoche (status bar)
      decoration: const BoxDecoration(
        color: Color(0xff121212), // Fond noir profond
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Localisation et Date (Texte gris petit)
          const Text(
            "Kolkata, India - 02/11/2024, 07:30:59 PM",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          
          // Ligne principale : Titre + Icône + Image
          Row(
            children: [
              const Text(
                "RDAPP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              
              // Icône d'alerte/notification (Petite icône à côté de la photo)
              Image.asset(
                AppImages.notificationIcon, // Remplace par ton chemin exact
                width: 24,
                height: 24,
                color: Colors.white70,
              ),
              const SizedBox(width: 16),
              
              // Image de l'utilisateur (La fille)
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[800],
                backgroundImage: const AssetImage(AppImages.girl),
              ),
            ],
          ),
        ],
      ),
    );
  }
}