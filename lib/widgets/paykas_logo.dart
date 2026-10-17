import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class PayKasLogo extends StatelessWidget {
  final double size;
  final bool isDark;
  final bool showText;
  final bool showTagline;

  const PayKasLogo({
    super.key,
    this.size = 110,
    this.isDark = false,
    this.showText = true,
    this.showTagline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Wallet Emblem Icon or Asset Logo
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.12) : AppColors.primary,
            borderRadius: BorderRadius.circular(size * 0.28),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.25)
                    : AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: isDark
                ? Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.5)
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet_rounded,
                size: size * 0.52,
                color: Colors.white,
              ),
              // "Rp" Badge on bottom right of the icon
              Positioned(
                right: size * 0.16,
                bottom: size * 0.20,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size * 0.07,
                    vertical: size * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBBF24), // Gold accent
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Rp',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: size * 0.14,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF78350F),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showText) ...[
          SizedBox(height: size * 0.18),
          Text(
            'PayKas',
            style: GoogleFonts.plusJakartaSans(
              fontSize: size * 0.28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ],
        if (showTagline) ...[
          const SizedBox(height: 8),
          Text(
            'Kelola Kas Kelas\nLebih Mudah, Transparan\ndan Teratur',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.4,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.85)
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
