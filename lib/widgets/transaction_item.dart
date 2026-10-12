import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/transaction_model.dart';
import '../theme/app_theme.dart';
import '../state/kas_provider.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onTap;

  const TransactionListItem({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final iconColor = isIncome ? AppColors.incomeGreen : AppColors.expenseRed;
    final iconBg = isIncome ? AppColors.incomeBg : AppColors.expenseBg;
    final amountColor = isIncome ? AppColors.incomeGreen : AppColors.expenseRed;
    final arrowIcon = isIncome ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;

    final dateStr = KasProvider.formatDate(transaction.date);
    final amountFormatted = KasProvider.formatRupiah(transaction.amount);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            // Circular Arrow Icon
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(arrowIcon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            // Title & Subtitle Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${KasProvider.formatRupiah(transaction.amount)} • $dateStr • ${transaction.person}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Right-aligned colored amount
            Text(
              amountFormatted,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: amountColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
