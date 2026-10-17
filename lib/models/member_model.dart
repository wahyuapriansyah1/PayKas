class MemberModel {
  final int number;
  final String id;
  final String name;
  final String className;
  final int feeAmount;
  final bool isPaid;
  final DateTime? paymentDate;
  final String paymentMethod;
  final String? role;
  final String? avatarUrl;
  final String? avatarAsset;

  const MemberModel({
    required this.number,
    required this.id,
    required this.name,
    this.className = 'Kelas XII IPA 1',
    this.feeAmount = 50000,
    required this.isPaid,
    this.paymentDate,
    this.paymentMethod = 'Transfer Bank',
    this.role,
    this.avatarUrl,
    this.avatarAsset,
  });

  MemberModel copyWith({
    int? number,
    String? id,
    String? name,
    String? className,
    int? feeAmount,
    bool? isPaid,
    DateTime? paymentDate,
    String? paymentMethod,
    String? role,
    String? avatarUrl,
    String? avatarAsset,
  }) {
    return MemberModel(
      number: number ?? this.number,
      id: id ?? this.id,
      name: name ?? this.name,
      className: className ?? this.className,
      feeAmount: feeAmount ?? this.feeAmount,
      isPaid: isPaid ?? this.isPaid,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      avatarAsset: avatarAsset ?? this.avatarAsset,
    );
  }
}
