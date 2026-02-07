import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../config/strings/app_strings.dart';
import '../../../config/theme/app_colors.dart';
import '../view_models/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Logo
              LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.asset(
                        'assets/images/logo-safe-house.png',
                        width: constraints.maxWidth * 0.6,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
              const Spacer(flex: 2),
              // Google Sign-In Button
              Consumer<AuthViewModel>(
                builder: (context, auth, _) {
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: auth.isLoading
                              ? null
                              : () => _handleSignIn(context, auth),
                          icon: auth.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.onBackground,
                                  ),
                                )
                              : Image.asset(
                                  'assets/images/google-icon.png',
                                  width: 20,
                                  height: 20,
                                ),
                          label: Text(
                            auth.isLoading
                                ? AppStrings.loginLoading
                                : AppStrings.loginContinueWithGoogle,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.onBackground,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.divider),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      if (auth.error != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          auth.error!,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignIn(BuildContext context, AuthViewModel auth) async {
    await auth.signInWithGoogle();
  }
}
