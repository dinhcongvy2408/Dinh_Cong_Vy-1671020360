import 'package:flutter/foundation.dart';
import '../models/lich_hoc.dart';
import '../services/dich_vu_lich.dart';

class QuanLyLich with ChangeNotifier {
  final DichVuLich _dichVuLich = DichVuLich();
  List<LichHoc> _danhSachLich = [];
  bool _dangTai = false;
  String? _loiHienTai;

  List<LichHoc> get danhSachLich => _danhSachLich;
  bool get dangTai => _dangTai;
  String? get loiHienTai => _loiHienTai;

  QuanLyLich() {
    layDanhSachLich();
  }

  Future<void> layDanhSachLich() async {
    _dangTai = true;
    _loiHienTai = null;
    notifyListeners();

    try {
      _danhSachLich = await _dichVuLich.layDanhSachLich();
      _dangTai = false;
      notifyListeners();
    } catch (e) {
      _loiHienTai = e.toString();
      _dangTai = false;
      notifyListeners();
    }
  }

  Future<void> themLichHoc(LichHoc lichHoc) async {
    _dangTai = true;
    notifyListeners();

    try {
      final lichHocMoi = await _dichVuLich.themLichHoc(lichHoc);
      _danhSachLich.add(lichHocMoi);
      _dangTai = false;
      notifyListeners();
    } catch (e) {
      _loiHienTai = e.toString();
      _dangTai = false;
      notifyListeners();
    }
  }

  Future<void> capNhatLichHoc(LichHoc lichHoc) async {
    _dangTai = true;
    notifyListeners();

    try {
      await _dichVuLich.capNhatLichHoc(lichHoc);
      final index = _danhSachLich.indexWhere((l) => l.id == lichHoc.id);
      if (index != -1) {
        _danhSachLich[index] = lichHoc;
      }
      _dangTai = false;
      notifyListeners();
    } catch (e) {
      _loiHienTai = e.toString();
      _dangTai = false;
      notifyListeners();
    }
  }

  Future<void> xoaLichHoc(String id) async {
    _dangTai = true;
    notifyListeners();

    try {
      await _dichVuLich.xoaLichHoc(id);
      _danhSachLich.removeWhere((l) => l.id == id);
      _dangTai = false;
      notifyListeners();
    } catch (e) {
      _loiHienTai = e.toString();
      _dangTai = false;
      notifyListeners();
    }
  }

  Future<void> chuyenTrangThaiHoanThanh(String id) async {
    final index = _danhSachLich.indexWhere((l) => l.id == id);
    if (index != -1) {
      final lichHoc = _danhSachLich[index];
      final lichHocCapNhat =
          lichHoc.copyWith(daHoanThanh: !lichHoc.daHoanThanh);
      await capNhatLichHoc(lichHocCapNhat);
    }
  }

  List<LichHoc> layLichTheoNgay(DateTime ngay) {
    final ngayChiNgay = DateTime(ngay.year, ngay.month, ngay.day);
    return _danhSachLich.where((lichHoc) {
      final ngayLichHoc = DateTime(
        lichHoc.thoiGianBatDau.year,
        lichHoc.thoiGianBatDau.month,
        lichHoc.thoiGianBatDau.day,
      );
      return ngayLichHoc.isAtSameMomentAs(ngayChiNgay);
    }).toList();
  }
}
