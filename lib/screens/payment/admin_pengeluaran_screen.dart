import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../state/kas_provider.dart';

class AdminPengeluaranScreen extends StatefulWidget {
  final KasProvider provider;

  const AdminPengeluaranScreen({super.key, required this.provider});

  @override
  State<AdminPengeluaranScreen> createState() => _AdminPengeluaranScreenState();
}

class _AdminPengeluaranScreenState extends State<AdminPengeluaranScreen> {
  final _nominalController = TextEditingController();
  final _keteranganController = TextEditingController();
  DateTime _selectedDate = DateTime(2025, 5, 12);
  String? _selectedMethod = 'Tunai';
  final List<String> _methods = ['Tunai', 'Transfer Bank', 'QRIS', 'E-Wallet'];
  bool _isLoading = false;

  @override
  void dispose() {
    _nominalController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _handleSave() async {
    final rawNominal = _nominalController.text
        .split('')
        .where((c) => '0123456789'.contains(c))
        .join();
    final amount = int.tryParse(rawNominal);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nominal pengeluaran yang valid'),
          backgroundColor: AppColors.expenseRed,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));

    widget.provider.addPengeluaran(
      amount: amount,
      category: _keteranganController.text.trim().isNotEmpty
          ? _keteranganController.text.trim()
          : 'Lainnya',
      note: _keteranganController.text.trim(),
      date: _selectedDate,
      method: _selectedMethod ?? 'Tunai',
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengeluaran kas berhasil disimpan!'),
        backgroundColor: AppColors.incomeGreen,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = KasProvider.formatDate(_selectedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Admin - Pengeluaran'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nominal Field
              CustomTextField(
                label: 'Nominal',
                hintText: 'Rp 0',
                controller: _nominalController,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(
                  Icons.payments_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // Keterangan Field
              CustomTextField(
                label: 'Keterangan',
                hintText: 'Contoh: Pembelian ATK, konsumsi, dll',
                controller: _keteranganController,
                prefixIcon: const Icon(
                  Icons.receipt_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // Tanggal Field
              Text(
                'Tanggal',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dateStr,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Metode Dropdown
              Text(
                'Metode',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedMethod,
                decoration: InputDecoration(
                  hintText: 'Pilih metode',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
                items: _methods.map((method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(
                      method,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() => _selectedMethod = val);
                },
              ),
              const SizedBox(height: 36),

              // Simpan Button
              CustomButton(
                text: 'Simpan',
                isLoading: _isLoading,
                onPressed: _handleSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
