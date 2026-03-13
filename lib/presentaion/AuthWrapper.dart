import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vanguard_ops/presentaion/auth/pages/signin.dart';
import 'package:vanguard_ops/presentaion/main_wrapper.dart';
import 'package:vanguard_ops/service_loacator.dart' show sl;

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: sl<SupabaseClient>().auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator(color: Colors.red)),
          );
        }

        final session = snapshot.data?.session;

        if (session != null) {
          return  MainWrapper(); 
        } else {
          return  LoginPage(); 
        }
      },
    );
  }
}