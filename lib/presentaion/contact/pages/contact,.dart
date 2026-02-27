import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/core/config/assets/app_images.dart';
import 'package:vanguard_ops/core/config/theme/app_colors.dart';
import 'package:vanguard_ops/presentaion/contact/bloc/contacts_bloc.dart' show ContactsCubit;
import 'package:vanguard_ops/presentaion/contact/bloc/contacts_state.dart';
import '../widgets/contact_card.dart';
import '../../../../common/helper/appbar/app_bar..dart';

// class ContactsPage extends StatelessWidget {
//   const ContactsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [
//           const RdAppBar(), 
//           Expanded(
//             child: BlocBuilder<ContactsCubit, ContactsState>(
//               builder: (context, state) {
//                 if (state is ContactsLoading) {
//                   return const Center(child: CircularProgressIndicator(color: AppColors.primary));
//                 }
                
//                 if (state is ContactsError) {
//                   return Center(child: Text(state.message, style: const TextStyle(color:AppColors.secondBackground)));
//                 }

//                 if (state is ContactsLoaded) {
//                   final police = state.contacts.where((c) => c.type == 'police').toList();
//                   final personal = state.contacts.where((c) => c.type == 'personal').toList();

//                   return ListView(
//                     padding: const EdgeInsets.all(16),
//                     children: [
//                       _buildHeader("Nearby Police Stations", AppImages.signal),
//                       ...police.map((c) => ContactCard(contact: c)),
//                       const SizedBox(height: 24),
//                      _buildHeader("My Contacts", AppImages.reload),
//                       ...personal.map((c) => ContactCard(contact: c)),
//                       const SizedBox(height: 24),
//                       _buildAddButton(),
//                     ],
//                   );
//                 }
//                 return const SizedBox();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(String title, String imagePath ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: const TextStyle(color: AppColors.secondBackground, fontSize: 18, fontWeight: FontWeight.bold)),
//           Image.asset(
//           imagePath,
//           fit: BoxFit.contain,
//           colorBlendMode: BlendMode.srcIn,
//         ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddButton() {
//     return Container(
//       width: double.infinity,
//       height: 56,
//       decoration: BoxDecoration(
//         color: AppColors.primary, 
//         borderRadius: BorderRadius.circular(28),
//       ),
//       child: const Center(
//         child: Text("+ Add New Contact", 
//           style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
// }
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
                  return Center(
                    child: Text(state.message, style: const TextStyle(color: AppColors.secondBackground))
                  );
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
                      _buildAddButton(context), // On passe le context pour le BottomSheet
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

  Widget _buildHeader(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.secondBackground,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Effet Senior : Glow sur l'image
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Image.asset(
              imagePath,
              height: 24,
              width: 24,
              fit: BoxFit.contain,
              color: AppColors.primary, // Force la couleur primaire (ex: rouge)
              colorBlendMode: BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // Ouverture du formulaire professionnel
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // Pour que le clavier ne cache pas les champs
          backgroundColor: Colors.transparent,
          builder: (context) => AddContactForm(
            onSave: (name, phone, type) {
              // Création de l'entité
              final newContact = ContactEntity(
                name: name, 
                phone: phone, 
                type: type,
                hasAlert: false
              );
              
              // Fermeture du BottomSheet
              Navigator.pop(context);
              
              // Appel du Cubit pour ajouter (méthode à créer dans le Cubit)
              // context.read<ContactsCubit>().addContact(newContact);
            },
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(28),
        ),
        child: const Center(
          child: Text(
            "+ Add New Contact",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}