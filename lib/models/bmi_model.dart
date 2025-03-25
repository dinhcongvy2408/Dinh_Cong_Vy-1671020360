class BMI {
  final String id;
  final double chieuCao; // cm
  final double canNang; // kg
  final double chiSoBMI;
  final String ketQua;
  final DateTime ngayTinh;

  BMI({
    required this.id,
    required this.chieuCao,
    required this.canNang,
    required this.chiSoBMI,
    required this.ketQua,
    required this.ngayTinh,
  });

  factory BMI.fromJson(Map<String, dynamic> json) {
    return BMI(
      id: json['id'] as String,
      chieuCao: json['chieuCao'] as double,
      canNang: json['canNang'] as double,
      chiSoBMI: json['chiSoBMI'] as double,
      ketQua: json['ketQua'] as String,
      ngayTinh: DateTime.parse(json['ngayTinh'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chieuCao': chieuCao,
      'canNang': canNang,
      'chiSoBMI': chiSoBMI,
      'ketQua': ketQua,
      'ngayTinh': ngayTinh.toIso8601String(),
    };
  }
}
