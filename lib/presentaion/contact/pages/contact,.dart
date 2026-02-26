import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/core/config/assets/app_images.dart';
import 'package:vanguard_ops/core/config/theme/app_colors.dart';
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
          const RdAppBar(), 
          Expanded(
            child: BlocBuilder<ContactsCubit, ContactsState>(
              builder: (context, state) {
                if (state is ContactsLoading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                }
                
                if (state is ContactsError) {
                  return Center(child: Text(state.message, style: const TextStyle(color:AppColors.secondBackground)));
                }

                if (state is ContactsLoaded) {
                  final police = state.contacts.where((c) => c.type == 'police').toList();
                  final personal = state.contacts.where((c) => c.type == 'personal').toList();

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildHeader("Nearby Police Stations", AppImages.signal),
                      ...police.map((c) => ContactCard(contact: c)),
                      const SizedBox(height: 24),
                     _buildHeader("My Contacts", AppImages.reload),
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

  Widget _buildHeader(String title, String imagePath ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: AppColors.secondBackground, fontSize: 18, fontWeight: FontWeight.bold)),
          Image.asset(
          imagePath,
          fit: BoxFit.contain,
          colorBlendMode: BlendMode.srcIn,
        ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary, 
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Center(
        child: Text("+ Add New Contact", 
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}