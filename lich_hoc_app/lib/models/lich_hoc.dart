class LichHoc {
  final String id;
  final String tenMonHoc;
  final String moTa;
  final DateTime thoiGianBatDau;
  final DateTime thoiGianKetThuc;
  final String diaDiem;
  final String tenGiangVien;
  final String maMonHoc;
  final bool daHoanThanh;

  LichHoc({
    required this.id,
    required this.tenMonHoc,
    required this.moTa,
    required this.thoiGianBatDau,
    required this.thoiGianKetThuc,
    required this.diaDiem,
    required this.tenGiangVien,
    required this.maMonHoc,
    this.daHoanThanh = false,
  });

  factory LichHoc.fromJson(Map<String, dynamic> json) {
    return LichHoc(
      id: json['id'],
      tenMonHoc: json['tenMonHoc'],
      moTa: json['moTa'],
      thoiGianBatDau: DateTime.parse(json['thoiGianBatDau']),
      thoiGianKetThuc: DateTime.parse(json['thoiGianKetThuc']),
      diaDiem: json['diaDiem'],
      tenGiangVien: json['tenGiangVien'],
      maMonHoc: json['maMonHoc'],
      daHoanThanh: json['daHoanThanh'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenMonHoc': tenMonHoc,
      'moTa': moTa,
      'thoiGianBatDau': thoiGianBatDau.toIso8601String(),
      'thoiGianKetThuc': thoiGianKetThuc.toIso8601String(),
      'diaDiem': diaDiem,
      'tenGiangVien': tenGiangVien,
      'maMonHoc': maMonHoc,
      'daHoanThanh': daHoanThanh,
    };
  }

  LichHoc copyWith({
    String? id,
    String? tenMonHoc,
    String? moTa,
    DateTime? thoiGianBatDau,
    DateTime? thoiGianKetThuc,
    String? diaDiem,
    String? tenGiangVien,
    String? maMonHoc,
    bool? daHoanThanh,
  }) {
    return LichHoc(
      id: id ?? this.id,
      tenMonHoc: tenMonHoc ?? this.tenMonHoc,
      moTa: moTa ?? this.moTa,
      thoiGianBatDau: thoiGianBatDau ?? this.thoiGianBatDau,
      thoiGianKetThuc: thoiGianKetThuc ?? this.thoiGianKetThuc,
      diaDiem: diaDiem ?? this.diaDiem,
      tenGiangVien: tenGiangVien ?? this.tenGiangVien,
      maMonHoc: maMonHoc ?? this.maMonHoc,
      daHoanThanh: daHoanThanh ?? this.daHoanThanh,
    );
  }
}
