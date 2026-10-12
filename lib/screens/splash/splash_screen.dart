import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/paykas_logo.dart';
import '../../widgets/custom_button.dart';
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.splashGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 20),
                // Center Branding
                const Expanded(
                  child: Center(
                    child: PayKasLogo(
                      size: 110,
                      isDark: true,
                      showText: true,
                      showTagline: true,
                    ),
                  ),
                ),

                // Bottom Buttons
                Column(
                  children: [
                    CustomButton(
                      text: 'Masuk',
                      variant: ButtonVariant.white,
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: 'Daftar',
                      variant: ButtonVariant.outlineWhite,
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
