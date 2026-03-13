import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard_ops/common/helper/navigator/app_navigator.dart';
import 'package:vanguard_ops/core/config/theme/app_colors.dart';
import 'package:vanguard_ops/data/auth/models/user_sognin_req.dart';
import 'package:vanguard_ops/presentaion/auth/bloc/signin_cubit.dart';
import 'package:vanguard_ops/presentaion/auth/bloc/signin_state.dart';
import 'package:vanguard_ops/presentaion/main_wrapper.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state is SigninSuccess) {
            AppNavigator.pushAndRemove(context, MainWrapper() );
          }
          if (state is SigninFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Connexion",
                  style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                
                _buildTextField(
                  controller: _emailCon,
                  hintText: "Email d'agent",
                  isPassword: false,
                ),
                
                const SizedBox(height: 16),
                
                _buildTextField(
                  controller: _passwordCon,
                  hintText: "Mot de passe",
                  isPassword: true,
                ),
                
                const SizedBox(height: 30),

                BlocBuilder<SigninCubit, SigninState>(
                  builder: (context, state) {
                    bool isActive = state is SigninLoading || state is SigninSuccess;
                    
                    return SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: state is SigninLoading 
                            ? null 
                            : () {
                                context.read<SigninCubit>().execute(
                                  UserSigninReq(
                                    email: _emailCon.text.trim(),
                                    password: _passwordCon.text.trim(),
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isActive ? AppColors.primary : Colors.grey[800],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: state is SigninLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                "SE CONNECTER",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isPassword,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xff2D4B5E), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}