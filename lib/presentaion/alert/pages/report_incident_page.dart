import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/core/config/theme/app_colors.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_cubit.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_state.dart';
import 'package:vanguard_ops/presentaion/alert/pages/map_alert_paged.dart';

class ReportIncidentPage extends StatelessWidget {
  const ReportIncidentPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Formatage de la date comme sur ton UI
    //final String formattedDate = DateFormat('dd/MM/yyyy, hh:mm:ss a').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Back", style: TextStyle(color: Colors.white, fontSize: 16)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Kolkata, India - $formattedDate",
            //   style: TextStyle(color: Colors.grey[600], fontSize: 12),
            // ),
            const SizedBox(height: 8),
            const Text(
              "RDAPP",
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // 1. Bloc Localisation
            _buildInfoCard(
              title: "Kolkata, India",
              subtitle: "22°34'21.525\", 88°21'50.023\"",
              icon: Icons.fullscreen_exit,
            ),

            const SizedBox(height: 16),

            // 2. Bloc Date & Time
            // _buildInfoCard(
            //   title: "Date & Time",
            //   subtitle: formattedDate,
            //   icon: Icons.calendar_today_outlined,
            // ),

            const SizedBox(height: 16),

            // 3. Bloc Description
            _buildDescriptionField(),

            const SizedBox(height: 16),

            // 4. Row Footage & Picture
            Row(
              children: [
                Expanded(child: _buildMediaCard("Footage", "Record Live video", Icons.videocam_outlined)),
                const SizedBox(width: 12),
                Expanded(child: _buildMediaCard("Picture", "Upload Live photo", Icons.camera_alt_outlined)),
              ],
            ),

            const SizedBox(height: 40),

            // 5. SECTION LOGIQUE ALERTE (BlocConsumer)
            BlocConsumer<AlertCubit, AlertState>(
              listener: (context, state) {
                if (state is AlertSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Alert Sent Successfully!"), backgroundColor: Colors.green),
                  );
                    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MapAlertPage()),
      );                }
                if (state is AlertError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                  );
                }
              },
              builder: (context, state) {
                final isTimer = state is AlertTimerInProgress;
                final countdown = isTimer ? (state as AlertTimerInProgress).secondsLeft : 3;

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (isTimer) {
                          context.read<AlertCubit>().cancelAlert();
                        } else {
                          context.read<AlertCubit>().triggerEmergency("Emergency incident reported by user");
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          color: isTimer ? const Color(0xFF1A1A1A) : AppColors.primary,
                          borderRadius: BorderRadius.circular(35),
                          border: isTimer ? Border.all(color: Colors.red.withOpacity(0.5)) : null,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(isTimer ? Icons.close : Icons.warning_amber_rounded, color: Colors.white),
                              const SizedBox(width: 10),
                              Text(
                                isTimer ? "CANCEL ALERT" : "Report Incident",
                                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (isTimer) ...[
                      const SizedBox(height: 16),
                      Text(
                        "Emergency Alert triggered in ${countdown}s...",
                        style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS DE COMPOSANTS ---

  Widget _buildInfoCard({required String title, required String subtitle, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[400], size: 22),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
              Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
          const Spacer(),
          Icon(Icons.edit_outlined, color: Colors.grey[700], size: 18),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.grey, size: 18),
              SizedBox(width: 8),
              Text("Description", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          Text("Give a quick brief.", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 12),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Type Here...",
              hintStyle: TextStyle(color: Colors.grey[800]),
              filled: true,
              fillColor: const Color(0xFF262626),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaCard(String title, String desc, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[400]),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(desc, style: TextStyle(color: Colors.grey[600], fontSize: 10)),
        ],
      ),
    );
  }
}