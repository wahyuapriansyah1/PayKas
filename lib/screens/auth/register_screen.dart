import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'login_screen.dart';
import '../main_navigation_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _classController = TextEditingController(text: 'Kelas X IPA 1');
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Konfirmasi password tidak cocok!'),
            backgroundColor: AppColors.expenseRed,
          ),
        );
        return;
      }

      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pendaftaran berhasil! Selamat datang di PayKas.'),
          backgroundColor: AppColors.incomeGreen,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _classController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Daftar PayKas',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Buat akun kas kelas Anda sekarang',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 28),

                CustomTextField(
                  label: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap',
                  controller: _nameController,
                  prefixIcon: const Icon(Icons.badge_outlined, size: 20, color: AppColors.textSecondary),
                  validator: (v) => v?.isEmpty ?? true ? 'Nama wajib diisi' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Username',
                  hintText: 'Pilih username',
                  controller: _usernameController,
                  prefixIcon: const Icon(Icons.alternate_email_rounded, size: 20, color: AppColors.textSecondary),
                  validator: (v) => v?.isEmpty ?? true ? 'Username wajib diisi' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Email',
                  hintText: 'Masukkan email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined, size: 20, color: AppColors.textSecondary),
                  validator: (v) => v?.isEmpty ?? true ? 'Email wajib diisi' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Kelas',
                  hintText: 'Contoh: Kelas X IPA 1',
                  controller: _classController,
                  prefixIcon: const Icon(Icons.school_outlined, size: 20, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Password',
                  hintText: 'Minimal 6 karakter',
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20, color: AppColors.textSecondary),
                  validator: (v) => (v?.length ?? 0) < 6 ? 'Password minimal 6 karakter' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Konfirmasi Password',
                  hintText: 'Ulangi password',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20, color: AppColors.textSecondary),
                  validator: (v) => v?.isEmpty ?? true ? 'Konfirmasi password wajib' : null,
                ),
                const SizedBox(height: 28),

                CustomButton(
                  text: 'Daftar Sekarang',
                  isLoading: _isLoading,
                  onPressed: _handleRegister,
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Masuk',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
