import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/common/helper/appbar/app_bar..dart';
import 'package:vanguard_ops/presentaion/setting/bloc/settings_cubit.dart';
import 'package:vanguard_ops/presentaion/setting/bloc/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> settingsOptions = [
      "Customize Alert Actions",
      "Privacy Settings",
      "Location Settings",
      "Audio / Video Settings",
      "Accessibility Options",
      "Incident History",
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          String? currentSelection;
          if (state is SettingsUpdated) {
            currentSelection = state.selectedTitle;
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const RdAppBar(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBackButton(context),

                      const SizedBox(height: 15),

                      ...settingsOptions.map((title) {
                        final isSelected = title == currentSelection;
                        return _buildSettingTile(
                          title: title,
                          isHighlighted: isSelected,
                          onTap: () => context.read<SettingsCubit>().selectOption(title),
                        );
                      }),

                      const SizedBox(height: 35),

                      _buildHelpSection(),

                      const SizedBox(height: 50),

                      _buildFooter(),
                      
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildBackButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () => Navigator.maybePop(context),
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      icon: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 16),
      label: const Text(
        "Back",
        style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required VoidCallback onTap,
    bool isHighlighted = false,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xff1A1A1A) : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isHighlighted ? Colors.red.withOpacity(0.5) : Colors.transparent,
          width: 0.8,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        title: Text(
          title,
          style: TextStyle(
            color: isHighlighted ? Colors.red : Colors.grey[400],
            fontSize: 16,
            fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isHighlighted ? Colors.red : Colors.grey[800],
          size: 14,
        ),
      ),
    );
  }

  Widget _buildHelpSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xff0D0D0D),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          const Text(
            "Help & Guide",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 25),
          _helpBulletText("- How to use RDAPP ?"),
          _helpBulletText("- What to do during an emergency ?"),
          _helpBulletText("- Legal rights and support resources."),
        ],
      ),
    );
  }

  Widget _helpBulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        textAlign: TextAlign.center, 
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Text(
        "All Rights reserved @RDAPP2024",
        style: TextStyle(
          color: Colors.white12,
          fontSize: 11,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}