import 'package:flutter/material.dart';
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
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                Text(contact.phone, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
          const Icon(Icons.person_pin_circle, color: Colors.red),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert, color: Colors.grey),
        ],
      ),
    );
  }
}