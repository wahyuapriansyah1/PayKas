import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import '../models/member_model.dart';
import '../models/user_model.dart';

class KasProvider extends ChangeNotifier {
  // Current logged in user (Matching Stitch Profile)
  UserModel _currentUser = const UserModel(
    name: 'Alya Maharani',
    username: 'alyamaharani',
    email: 'alya.maharani@school.id',
    phone: '0812 3456 7890',
    className: 'Kelas XII IPA 1',
    role: 'Bendahara Kelas',
    avatarAsset: 'assets/images/profile_alya.png',
  );

  UserModel get currentUser => _currentUser;

  // Preferences
  bool _pushNotifications = true;
  bool _autoDarkMode = false;

  bool get pushNotifications => _pushNotifications;
  bool get autoDarkMode => _autoDarkMode;

  void togglePushNotifications(bool val) {
    _pushNotifications = val;
    notifyListeners();
  }

  void toggleAutoDarkMode(bool val) {
    _autoDarkMode = val;
    notifyListeners();
  }

  // Transactions list matching Stitch designs
  final List<TransactionModel> _transactions = [
    TransactionModel(
      id: 'tx_inc_1',
      title: 'Pembayaran Kas Budi',
      amount: 10000,
      type: TransactionType.income,
      category: 'Iuran Kas',
      date: DateTime.now(),
      person: 'Budi Santoso',
      method: 'QRIS',
      note: 'Iuran Minggu ke-3',
    ),
    TransactionModel(
      id: 'tx_exp_1',
      title: 'Pembelian Spidol Kelas',
      amount: 25000,
      type: TransactionType.expense,
      category: 'ATK Kelas',
      date: DateTime.now().subtract(const Duration(days: 1)),
      person: 'Bendahara',
      method: 'Tunai',
      note: 'Spidol Boardmarker & Tinta',
    ),
    TransactionModel(
      id: 'tx_inc_2',
      title: 'Pembayaran Kas Siti',
      amount: 10000,
      type: TransactionType.income,
      category: 'Iuran Kas',
      date: DateTime.now().subtract(const Duration(days: 1)),
      person: 'Siti Rahma',
      method: 'QRIS',
      note: 'Iuran Minggu ke-3',
    ),
    TransactionModel(
      id: 'tx_exp_2',
      title: 'Beli Spidol & Penghapus',
      amount: 35000,
      type: TransactionType.expense,
      category: 'ATK Kelas',
      date: DateTime(2023, 10, 22, 9, 15),
      person: 'Bendahara',
      method: 'Tunai',
      note: 'Penghapus papan & refill tinta',
    ),
    TransactionModel(
      id: 'tx_inc_3',
      title: 'Pembayaran KAS Minggu ke-2',
      amount: 350000,
      type: TransactionType.income,
      category: 'Iuran Kas',
      date: DateTime(2023, 10, 17, 11, 0),
      person: 'Siswa Kelas',
      method: 'QRIS',
      note: 'Kolektif 35 siswa',
    ),
    TransactionModel(
      id: 'tx_inc_4',
      title: 'Pembayaran KAS Minggu ke-1',
      amount: 320000,
      type: TransactionType.income,
      category: 'Iuran Kas',
      date: DateTime(2023, 10, 10, 10, 30),
      person: 'Siswa Kelas',
      method: 'QRIS',
      note: 'Kolektif 32 siswa',
    ),
  ];

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  List<TransactionModel> get recentTransactions => _transactions.take(5).toList();

  List<TransactionModel> get incomes =>
      _transactions.where((t) => t.type == TransactionType.income).toList();

  List<TransactionModel> get expenses =>
      _transactions.where((t) => t.type == TransactionType.expense).toList();

  // Class Members list (32 Students, 28 Lunas, 4 Belum Lunas = 87.5% matching Stitch)
  final List<MemberModel> _members = [
    const MemberModel(
      number: 1,
      id: 'm01',
      name: 'Ahmad Fauzan',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
      role: 'Bendahara 1',
    ),
    const MemberModel(
      number: 2,
      id: 'm02',
      name: 'Bunga Citra',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
      avatarAsset: 'assets/images/student_bunga.png',
    ),
    const MemberModel(
      number: 8,
      id: 'm08',
      name: 'Dimas Anggara',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: false,
    ),
    const MemberModel(
      number: 24,
      id: 'm24',
      name: 'Siti Rahma',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
      role: 'Sekretaris',
    ),
    const MemberModel(
      number: 3,
      id: 'm03',
      name: 'Aditya Pratama',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 4,
      id: 'm04',
      name: 'Anisa Maharani',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Tunai',
    ),
    const MemberModel(
      number: 5,
      id: 'm05',
      name: 'Bayu Wicaksono',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 6,
      id: 'm06',
      name: 'Cantika Dewi',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: false,
    ),
    const MemberModel(
      number: 7,
      id: 'm07',
      name: 'Daffa Rizky',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 9,
      id: 'm09',
      name: 'Eka Nurhayati',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 10,
      id: 'm10',
      name: 'Faisal Akbar',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Tunai',
    ),
    const MemberModel(
      number: 11,
      id: 'm11',
      name: 'Farhan Maulana',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 12,
      id: 'm12',
      name: 'Gita Permata',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 13,
      id: 'm13',
      name: 'Hafiz Prasetya',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: false,
    ),
    const MemberModel(
      number: 14,
      id: 'm14',
      name: 'Indah Kusuma',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 15,
      id: 'm15',
      name: 'Joko Susilo',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Tunai',
    ),
    const MemberModel(
      number: 16,
      id: 'm16',
      name: 'Kevin Jonathan',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 17,
      id: 'm17',
      name: 'Lestari Putri',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 18,
      id: 'm18',
      name: 'Muhammad Ilham',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 19,
      id: 'm19',
      name: 'Nabila Syahrini',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 20,
      id: 'm20',
      name: 'Oki Setiawan',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: false,
    ),
    const MemberModel(
      number: 21,
      id: 'm21',
      name: 'Putri Ayu',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 22,
      id: 'm22',
      name: 'Rian Hidayat',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 23,
      id: 'm23',
      name: 'Rizka Amanda',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Tunai',
    ),
    const MemberModel(
      number: 25,
      id: 'm25',
      name: 'Tegar Saputra',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 26,
      id: 'm26',
      name: 'Tiara Andini',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 27,
      id: 'm27',
      name: 'Umar Dani',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 28,
      id: 'm28',
      name: 'Vina Panduwinata',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 29,
      id: 'm29',
      name: 'Wahyu Nugroho',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 30,
      id: 'm30',
      name: 'Yoga Pratama',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Tunai',
    ),
    const MemberModel(
      number: 31,
      id: 'm31',
      name: 'Zahra Maulida',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
    const MemberModel(
      number: 32,
      id: 'm32',
      name: 'Zidane Al-Fatih',
      className: 'Kelas XII IPA 1',
      feeAmount: 50000,
      isPaid: true,
      paymentMethod: 'Transfer QRIS',
    ),
  ];

  List<MemberModel> get members => List.unmodifiable(_members);

  int get paidMemberCount => _members.where((m) => m.isPaid).length;
  int get unpaidMemberCount => _members.where((m) => !m.isPaid).length;
  double get paidPercentage =>
      _members.isEmpty ? 0 : (_members.where((m) => m.isPaid).length / _members.length) * 100;

  // Total Balance values matching Stitch mockup (Rp 2.450.000 saldo total)
  int _baseTotalPemasukan = 3200000;
  int _baseTotalPengeluaran = 750000;

  int get totalPemasukan => _baseTotalPemasukan;
  int get totalPengeluaran => _baseTotalPengeluaran;
  int get totalKas => _baseTotalPemasukan - _baseTotalPengeluaran; // 2.450.000

  // Month stats for banner
  int get masukBulanIni => 750000;
  int get keluarBulanIni => 250000;

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
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des'
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
      title: category.isNotEmpty ? category : 'Pemasukan Kas',
      amount: amount,
      type: TransactionType.income,
      category: category.isNotEmpty ? category : 'Pemasukan',
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
      category: category.isNotEmpty ? category : 'Pengeluaran',
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
    int amount = 10000,
    String weekName = 'Minggu 4',
  }) {
    final newTx = TransactionModel(
      id: 'tx_inc_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Pembayaran Kas - $weekName',
      amount: amount,
      type: TransactionType.income,
      category: 'Iuran Kas',
      date: DateTime.now(),
      person: _currentUser.name,
      method: method,
      note: 'Setoran $weekName',
    );

    _transactions.insert(0, newTx);
    _baseTotalPemasukan += amount;
    notifyListeners();
  }

  void addMember({
    required String name,
    required int number,
    String? role,
    bool isPaid = false,
  }) {
    final newMember = MemberModel(
      number: number,
      id: 'm_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      className: _currentUser.className,
      feeAmount: 50000,
      isPaid: isPaid,
      role: role,
    );
    _members.add(newMember);
    _members.sort((a, b) => a.number.compareTo(b.number));
    notifyListeners();
  }

  void toggleMemberStatus(String memberId) {
    final index = _members.indexWhere((m) => m.id == memberId);
    if (index != -1) {
      final current = _members[index];
      _members[index] = current.copyWith(
        isPaid: !current.isPaid,
        paymentDate: !current.isPaid ? DateTime.now() : null,
      );
      notifyListeners();
    }
  }

  void updateProfile({
    required String name,
    required String username,
    required String email,
    required String phone,
    String? className,
    String? role,
  }) {
    _currentUser = _currentUser.copyWith(
      name: name,
      username: username,
      email: email,
      phone: phone,
      className: className,
      role: role,
    );
    notifyListeners();
  }

  bool updatePassword(String oldPassword, String newPassword) {
    notifyListeners();
    return true;
  }
}
