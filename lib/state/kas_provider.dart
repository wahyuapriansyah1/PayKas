import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import '../models/member_model.dart';
import '../models/user_model.dart';

class KasProvider extends ChangeNotifier {
  // Current logged in user
  UserModel _currentUser = const UserModel(
    name: 'Wahyu',
    username: 'wahyu123',
    email: 'wahyu@gmail.com',
    phone: '0812 3456 7890',
    className: 'Kelas X IPA 1',
  );

  UserModel get currentUser => _currentUser;

  // Transactions list
  final List<TransactionModel> _transactions = [
    TransactionModel(
      id: 'tx_inc_1',
      title: 'Iuran Kelas',
      amount: 100000,
      type: TransactionType.income,
      category: 'Iuran Kelas',
      date: DateTime(2025, 5, 12),
      person: 'Andi',
      method: 'Transfer Bank',
    ),
    TransactionModel(
      id: 'tx_exp_1',
      title: 'Pembelian ATK',
      amount: 75000,
      type: TransactionType.expense,
      category: 'ATK',
      date: DateTime(2025, 5, 11),
      person: 'Bendahara',
      method: 'Tunai',
      note: 'Kertas HVS dan spidol boardmarker',
    ),
    TransactionModel(
      id: 'tx_inc_2',
      title: 'Iuran Kelas',
      amount: 100000,
      type: TransactionType.income,
      category: 'Iuran Kelas',
      date: DateTime(2025, 5, 10),
      person: 'Budi',
      method: 'Transfer Bank',
    ),
    TransactionModel(
      id: 'tx_exp_2',
      title: 'Konsumsi Kelas',
      amount: 150000,
      type: TransactionType.expense,
      category: 'Konsumsi',
      date: DateTime(2025, 5, 8),
      person: 'Bendahara',
      method: 'Tunai',
      note: 'Snack rapat kelas',
    ),
    TransactionModel(
      id: 'tx_inc_3',
      title: 'Bonus Kelas',
      amount: 50000,
      type: TransactionType.income,
      category: 'Bonus',
      date: DateTime(2025, 5, 8),
      person: 'Bendahara',
      method: 'Transfer Bank',
      note: 'Juara kebersihan kelas',
    ),
    TransactionModel(
      id: 'tx_inc_4',
      title: 'Iuran Kelas',
      amount: 100000,
      type: TransactionType.income,
      category: 'Iuran Kelas',
      date: DateTime(2025, 5, 5),
      person: 'Citra',
      method: 'Transfer Bank',
    ),
    TransactionModel(
      id: 'tx_exp_3',
      title: 'Transportasi',
      amount: 100000,
      type: TransactionType.expense,
      category: 'Lainnya',
      date: DateTime(2025, 5, 5),
      person: 'Bendahara',
      method: 'Tunai',
    ),
    TransactionModel(
      id: 'tx_inc_5',
      title: 'Iuran Kelas',
      amount: 100000,
      type: TransactionType.income,
      category: 'Iuran Kelas',
      date: DateTime(2025, 5, 2),
      person: 'Dika',
      method: 'Transfer Bank',
    ),
    TransactionModel(
      id: 'tx_exp_4',
      title: 'Pembelian ATK',
      amount: 50000,
      type: TransactionType.expense,
      category: 'ATK',
      date: DateTime(2025, 5, 2),
      person: 'Bendahara',
      method: 'Tunai',
    ),
    TransactionModel(
      id: 'tx_exp_5',
      title: 'Konsumsi Kelas',
      amount: 125000,
      type: TransactionType.expense,
      category: 'Konsumsi',
      date: DateTime(2025, 4, 28),
      person: 'Bendahara',
      method: 'Tunai',
    ),
  ];

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  List<TransactionModel> get recentTransactions => _transactions.take(5).toList();

  List<TransactionModel> get incomes =>
      _transactions.where((t) => t.type == TransactionType.income).toList();

  List<TransactionModel> get expenses =>
      _transactions.where((t) => t.type == TransactionType.expense).toList();

  // Class Members list
  final List<MemberModel> _members = [
    const MemberModel(
      number: 1,
      id: 'm1',
      name: 'Andi',
      className: 'Kelas X IPA 1',
      feeAmount: 100000,
      isPaid: true,
      paymentMethod: 'Transfer Bank',
    ),
    const MemberModel(
      number: 2,
      id: 'm2',
      name: 'Budi',
      className: 'Kelas X IPA 1',
      feeAmount: 100000,
      isPaid: true,
      paymentMethod: 'Transfer Bank',
    ),
    const MemberModel(
      number: 3,
      id: 'm3',
      name: 'Citra',
      className: 'Kelas X IPA 1',
      feeAmount: 100000,
      isPaid: true,
      paymentMethod: 'E-Wallet',
    ),
    const MemberModel(
      number: 4,
      id: 'm4',
      name: 'Dika',
      className: 'Kelas X IPA 1',
      feeAmount: 100000,
      isPaid: false,
    ),
    const MemberModel(
      number: 5,
      id: 'm5',
      name: 'Eka',
      className: 'Kelas X IPA 1',
      feeAmount: 100000,
      isPaid: true,
      paymentMethod: 'Tunai (Jika Offline)',
    ),
    const MemberModel(
      number: 6,
      id: 'm6',
      name: 'Fani',
      className: 'Kelas X IPA 1',
      feeAmount: 100000,
      isPaid: true,
      paymentMethod: 'Transfer Bank',
    ),
    const MemberModel(
      number: 7,
      id: 'm7',
      name: 'Gilang',
      className: 'Kelas X IPA 1',
      feeAmount: 100000,
      isPaid: false,
    ),
  ];

  List<MemberModel> get members => List.unmodifiable(_members);

  // Cash Calculations (Fixed display values matching mockup exactly or dynamic based on edits)
  int _baseTotalPemasukan = 5200000;
  int _baseTotalPengeluaran = 2750000;

  int get totalPemasukan => _baseTotalPemasukan;
  int get totalPengeluaran => _baseTotalPengeluaran;
  int get totalKas => _baseTotalPemasukan - _baseTotalPengeluaran;

  // Formatting helpers
  static String formatRupiah(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount).replaceAll(' ', ' ');
  }

  static String formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Ags',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // Business logic actions
  void addPemasukan({
    required int amount,
    required String category,
    required String note,
    required DateTime date,
    required String method,
  }) {
    final newTx = TransactionModel(
      id: 'tx_inc_${DateTime.now().millisecondsSinceEpoch}',
      title: category.isNotEmpty ? category : 'Iuran Kelas',
      amount: amount,
      type: TransactionType.income,
      category: category.isNotEmpty ? category : 'Iuran Kelas',
      date: date,
      person: _currentUser.name,
      method: method,
      note: note.isNotEmpty ? note : null,
    );

    _transactions.insert(0, newTx);
    _baseTotalPemasukan += amount;
    notifyListeners();
  }

  void addPengeluaran({
    required int amount,
    required String category,
    required String note,
    required DateTime date,
    required String method,
  }) {
    final newTx = TransactionModel(
      id: 'tx_exp_${DateTime.now().millisecondsSinceEpoch}',
      title: category.isNotEmpty ? category : 'Pengeluaran Kelas',
      amount: amount,
      type: TransactionType.expense,
      category: category.isNotEmpty ? category : 'Lainnya',
      date: date,
      person: 'Bendahara',
      method: method,
      note: note.isNotEmpty ? note : null,
    );

    _transactions.insert(0, newTx);
    _baseTotalPengeluaran += amount;
    notifyListeners();
  }

  void payIuran({
    required String method,
    int amount = 100000,
  }) {
    final newTx = TransactionModel(
      id: 'tx_inc_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Iuran Kelas',
      amount: amount,
      type: TransactionType.income,
      category: 'Iuran Kelas',
      date: DateTime.now(),
      person: _currentUser.name,
      method: method,
    );

    _transactions.insert(0, newTx);
    _baseTotalPemasukan += amount;
    notifyListeners();
  }

  void updateProfile({
    required String name,
    required String username,
    required String email,
    required String phone,
  }) {
    _currentUser = _currentUser.copyWith(
      name: name,
      username: username,
      email: email,
      phone: phone,
    );
    notifyListeners();
  }

  bool updatePassword(String oldPassword, String newPassword) {
    // For prototype demonstration
    notifyListeners();
    return true;
  }
}
