import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/core/config/theme/app_colors.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_cubit.dart';
import 'package:vanguard_ops/presentaion/alert/bloc/alert_state.dart';
import 'package:vanguard_ops/presentaion/alert/pages/map_alert_paged.dart';
import 'package:vanguard_ops/presentaion/alert/widgets/widgets.dart';
class ReportIncidentPage extends StatefulWidget {
  const ReportIncidentPage({super.key});

  @override
  State<ReportIncidentPage> createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'RDAPP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            InfoCardWidget(
              title: 'Kolkata, India',
              subtitle: '22°34\'21.525", 88°21\'50.023"',
              icon: Icons.fullscreen_exit,
              onEditTap: () {
              },
            ),

            const SizedBox(height: 16),

            DescriptionFieldWidget(
              controller: _descriptionController,
              hintText: 'Describe the incident...',
              onChanged: (value) {
              },
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: MediaCardWidget(
                    title: 'Footage',
                    description: 'Record Live video',
                    icon: Icons.videocam_outlined,
                    onTap: () {
                      // Optionnel : déclencher l'enregistrement vidéo
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MediaCardWidget(
                    title: 'Picture',
                    description: 'Upload Live photo',
                    icon: Icons.camera_alt_outlined,
                    onTap: () {
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            BlocConsumer<AlertCubit, AlertState>(
              listener: (context, state) {
                if (state is AlertSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Alert Sent Successfully!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapAlertPage(),
                        ),
                      );
                    }
                  });
                }
                if (state is AlertError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppColors.primary,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isTimer = state is AlertTimerInProgress;
                final countdown =
                    isTimer ? (state as AlertTimerInProgress).secondsLeft : 3;

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isTimer) {
                          context.read<AlertCubit>().cancelAlert();
                        } else {
                          final description = _descriptionController.text.isNotEmpty
                              ? _descriptionController.text
                              : 'Emergency incident reported by user';
                          context
                              .read<AlertCubit>()
                              .triggerEmergency(description);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          color: isTimer
                              ? const Color(0xFF1A1A1A)
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(35),
                          border: isTimer
                              ? Border.all(
                                  color: AppColors.primary.withOpacity(0.5),
                                  width: 1,
                                )
                              : null,
                          boxShadow: isTimer
                              ? []
                              : [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.4),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isTimer ? Icons.close : Icons.warning_amber_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                isTimer ? 'CANCEL ALERT' : 'Report Incident',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    if (isTimer) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Emergency Alert triggered in ${countdown}s...',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
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
}
