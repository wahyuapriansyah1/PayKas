import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/transaction_item.dart';
import '../../state/kas_provider.dart';
import 'detail_pemasukan_screen.dart';
import 'detail_pengeluaran_screen.dart';
import '../members/anggota_kelas_screen.dart';
import '../payment/admin_pemasukan_screen.dart';
import '../payment/admin_pengeluaran_screen.dart';
import '../settings/detail_profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  final KasProvider provider;
  final Function(int)? onTabChangeRequested;

  const DashboardScreen({
    super.key,
    required this.provider,
    this.onTabChangeRequested,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) {
        final user = provider.currentUser;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            titleSpacing: 20,
            centerTitle: false,
            title: Text(
              'PayKas',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                letterSpacing: -0.5,
              ),
            ),
            actions: [
              // Notification Bell
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                    onPressed: () {
                      _showNotifications(context);
                    },
                  ),
                  Positioned(
                    top: 13,
                    right: 14,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.expenseRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              // User Avatar Pill "W"
              Padding(
                padding: const EdgeInsets.only(right: 18, left: 2),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProfileScreen(provider: provider),
                      ),
                    );
                  },
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : 'W',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 400));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CARD 1: Total Kas
                  TotalKasCard(totalAmount: provider.totalKas),
                  const SizedBox(height: 14),

                  // ROW: Pemasukan & Pengeluaran Cards
                  Row(
                    children: [
                      Expanded(
                        child: SummaryMiniCard(
                          title: 'Pemasukan',
                          amount: provider.totalPemasukan,
                          isIncome: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPemasukanScreen(provider: provider),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SummaryMiniCard(
                          title: 'Pengeluaran',
                          amount: provider.totalPengeluaran,
                          isIncome: false,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPengeluaranScreen(provider: provider),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // 4 Quick Action Circular Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildQuickAction(
                        icon: Icons.payments_outlined,
                        label: 'Pemasukan',
                        iconColor: AppColors.incomeGreen,
                        bgColor: AppColors.incomeBg,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdminPemasukanScreen(provider: provider),
                            ),
                          );
                        },
                      ),
                      _buildQuickAction(
                        icon: Icons.receipt_long_outlined,
                        label: 'Pengeluaran',
                        iconColor: AppColors.expenseRed,
                        bgColor: AppColors.expenseBg,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdminPengeluaranScreen(provider: provider),
                            ),
                          );
                        },
                      ),
                      _buildQuickAction(
                        icon: Icons.groups_outlined,
                        label: 'Anggota Kelas',
                        iconColor: const Color(0xFF0284C7),
                        bgColor: const Color(0xFFE0F2FE),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AnggotaKelasScreen(provider: provider),
                            ),
                          );
                        },
                      ),
                      _buildQuickAction(
                        icon: Icons.history_rounded,
                        label: 'Riwayat',
                        iconColor: const Color(0xFF7C3AED),
                        bgColor: const Color(0xFFEDE9FE),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPemasukanScreen(provider: provider),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),

                  // SECTION: Aktivitas Terbaru (Recent Activities)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Aktivitas Terbaru',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPemasukanScreen(provider: provider),
                            ),
                          );
                        },
                        child: Text(
                          'Lihat Semua',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Recent Transactions List
                  ...provider.recentTransactions.map(
                    (tx) => Column(
                      children: [
                        TransactionListItem(
                          transaction: tx,
                          onTap: () {
                            _showTransactionDetailModal(context, tx);
                          },
                        ),
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // PayKas Features Banner (from bottom of screenshot)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        _buildFeaturePoint(
                          icon: Icons.check_circle_outline_rounded,
                          title: 'Mudah Digunakan',
                          subtitle: 'Tampilan sederhana dan intuitif',
                        ),
                        const SizedBox(height: 12),
                        _buildFeaturePoint(
                          icon: Icons.shield_outlined,
                          title: 'Aman & Terpercaya',
                          subtitle: 'Data tersimpan dengan aman',
                        ),
                        const SizedBox(height: 12),
                        _buildFeaturePoint(
                          icon: Icons.dashboard_customize_outlined,
                          title: 'Fitur Lengkap',
                          subtitle: 'Untuk admin dan user kelas',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePoint({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pemberitahuan',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.incomeBg,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: AppColors.incomeGreen, size: 18),
                ),
                title: Text(
                  'Iuran Andi terverifikasi',
                  style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '12 Mei 2025 • Rp 100.000 via Transfer Bank',
                  style: GoogleFonts.plusJakartaSans(fontSize: 11),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.expenseBg,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.receipt_outlined, color: AppColors.expenseRed, size: 18),
                ),
                title: Text(
                  'Pengeluaran ATK dicatat',
                  style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '11 Mei 2025 • Rp 75.000 untuk kertas dan spidol',
                  style: GoogleFonts.plusJakartaSans(fontSize: 11),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTransactionDetailModal(BuildContext context, dynamic tx) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Transaksi',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kategori', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSecondary)),
                  Text(tx.title, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nominal', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSecondary)),
                  Text(KasProvider.formatRupiah(tx.amount), style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tanggal', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSecondary)),
                  Text(KasProvider.formatDate(tx.date), style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pencatat / Pengirim', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSecondary)),
                  Text(tx.person, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Metode', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSecondary)),
                  Text(tx.method, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              if (tx.note != null) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Catatan', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSecondary)),
                    Text(tx.note!, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
