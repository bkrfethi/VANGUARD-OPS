import 'package:flutter/material.dart';
import 'package:vanguard_ops/core/config/assets/app_images.dart';
import 'package:vanguard_ops/core/config/theme/app_colors.dart';
import 'package:vanguard_ops/domain/contacts/entities/contact.dart';

class ContactCard extends StatelessWidget {
  final ContactEntity contact;
  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.name, style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                Text(contact.phone, style: const TextStyle(color: AppColors.greyfill, fontSize: 14)),
              ],
            ),
          ),
           Image.asset(AppImages.contactlogo),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert, color:AppColors.secondBackground),
        ],
      ),
    );
  }
}