import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../state/kas_provider.dart';

class UbahPasswordScreen extends StatefulWidget {
  final KasProvider provider;

  const UbahPasswordScreen({super.key, required this.provider});

  @override
  State<UbahPasswordScreen> createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Konfirmasi password tidak cocok!'),
            backgroundColor: AppColors.expenseRed,
          ),
        );
        return;
      }

      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 500));

      widget.provider.updatePassword(
        _oldPasswordController.text,
        _newPasswordController.text,
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password berhasil diubah!'),
          backgroundColor: AppColors.incomeGreen,
        ),
      );

      Navigator.pop(context);
    }
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
        title: const Text('Ubah Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: 'Password Lama',
                  hintText: 'Masukkan password lama',
                  controller: _oldPasswordController,
                  isPassword: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  validator: (v) => v?.isEmpty ?? true ? 'Password lama wajib diisi' : null,
                ),
                const SizedBox(height: 18),

                CustomTextField(
                  label: 'Password Baru',
                  hintText: 'Masukkan password baru',
                  controller: _newPasswordController,
                  isPassword: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  validator: (v) => (v?.length ?? 0) < 6 ? 'Password baru minimal 6 karakter' : null,
                ),
                const SizedBox(height: 18),

                CustomTextField(
                  label: 'Konfirmasi Password',
                  hintText: 'Ulangi password baru',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  validator: (v) => v?.isEmpty ?? true ? 'Konfirmasi password wajib' : null,
                ),
                const SizedBox(height: 36),

                CustomButton(
                  text: 'Simpan',
                  isLoading: _isLoading,
                  onPressed: _handleSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
