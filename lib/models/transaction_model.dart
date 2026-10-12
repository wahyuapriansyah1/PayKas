enum TransactionType {
  income,
  expense,
}

class TransactionModel {
  final String id;
  final String title;
  final int amount;
  final TransactionType type;
  final String category; // e.g. "Iuran Kelas", "Pembelian ATK", "Konsumsi", "Bonus", "Transportasi"
  final DateTime date;
  final String person; // e.g. "Andi", "Bendahara", "Budi"
  final String method; // "Transfer Bank", "Tunai", "E-Wallet"
  final String? note;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    required this.person,
    this.method = 'Transfer Bank',
    this.note,
  });

  TransactionModel copyWith({
    String? id,
    String? title,
    int? amount,
    TransactionType? type,
    String? category,
    DateTime? date,
    String? person,
    String? method,
    String? note,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      date: date ?? this.date,
      person: person ?? this.person,
      method: method ?? this.method,
      note: note ?? this.note,
    );
  }
}
