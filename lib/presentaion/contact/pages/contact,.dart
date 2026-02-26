import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/presentaion/contact/bloc/contacts_bloc.dart' show ContactsCubit;
import 'package:vanguard_ops/presentaion/contact/bloc/contacts_state.dart';
import '../widgets/contact_card.dart';
import '../../../../common/helper/appbar/app_bar..dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const RdAppBar(), // Ton AppBar personnalisée
          Expanded(
            child: BlocBuilder<ContactsCubit, ContactsState>(
              builder: (context, state) {
                if (state is ContactsLoading) {
                  return const Center(child: CircularProgressIndicator(color: Colors.red));
                }
                
                if (state is ContactsError) {
                  return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
                }

                if (state is ContactsLoaded) {
                  final police = state.contacts.where((c) => c.type == 'police').toList();
                  final personal = state.contacts.where((c) => c.type == 'personal').toList();

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildHeader("Nearby Police Stations", Icons.wifi),
                      ...police.map((c) => ContactCard(contact: c)),
                      const SizedBox(height: 24),
                      _buildHeader("My Contacts", Icons.refresh),
                      ...personal.map((c) => ContactCard(contact: c)),
                      const SizedBox(height: 24),
                      _buildAddButton(),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
          Icon(icon, color: Colors.red, size: 20),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFB71C1C), // Rouge sombre
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Center(
        child: Text("+ Add New Contact", 
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}