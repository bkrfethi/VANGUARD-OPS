import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vanguard_ops/core/config/theme/app_colors.dart';
import 'package:vanguard_ops/core/config/assets/app_images.dart';

class RdAppBar extends StatelessWidget {
  const RdAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20), 
      decoration: const BoxDecoration(
        color: AppColors.background, 
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Kolkata, India - 02/11/2024, 07:30:59 PM",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          
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
              
              Image.asset(
                AppImages.notificationIcon, 
                width: 24,
                height: 24,
                color: Colors.white70,
              ),
              const SizedBox(width: 16),
              
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