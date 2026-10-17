import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../state/kas_provider.dart';
import '../payment/admin_pemasukan_screen.dart';

class DetailPemasukanScreen extends StatefulWidget {
  final KasProvider provider;

  const DetailPemasukanScreen({super.key, required this.provider});

  @override
  State<DetailPemasukanScreen> createState() => _DetailPemasukanScreenState();
}

class _DetailPemasukanScreenState extends State<DetailPemasukanScreen> {
  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'Iuran Kelas', 'Bonus', 'Lainnya'];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.provider,
      builder: (context, _) {
        final allIncomes = widget.provider.incomes;
        final filteredList = _selectedFilter == 'Semua'
            ? allIncomes
            : allIncomes.where((item) => item.category == _selectedFilter).toList();

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Detail Pemasukan'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Chips Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: _filters.map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        backgroundColor: Colors.white,
                        labelStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 12.5,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                        ),
                        side: BorderSide(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        showCheckmark: false,
                        onSelected: (val) {
                          if (val) {
                            setState(() => _selectedFilter = filter);
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Divider(height: 1, color: AppColors.border),

              // Total income summary banner
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.incomeBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.incomeGreen.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Pemasukan Tercatat',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          KasProvider.formatRupiah(widget.provider.totalPemasukan),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            color: AppColors.incomeGreen,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 30),
                      tooltip: 'Tambah Pemasukan',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminPemasukanScreen(provider: widget.provider),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Incomes List
              Expanded(
                child: filteredList.isEmpty
                    ? Center(
                        child: Text(
                          'Belum ada pemasukan pada kategori ini',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        itemCount: filteredList.length,
                        separatorBuilder: (context, i) => const Divider(
                          color: Color(0xFFF1F5F9),
                          height: 16,
                        ),
                        itemBuilder: (context, index) {
                          final item = filteredList[index];
                          final dateStr = KasProvider.formatDate(item.date);
                          final amountFormatted = KasProvider.formatRupiah(item.amount);

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: AppColors.incomeBg,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_upward_rounded,
                                    color: AppColors.incomeGreen,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '$amountFormatted\n$dateStr • ${item.person}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11.5,
                                          height: 1.3,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.incomeBg,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    amountFormatted,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.incomeGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
