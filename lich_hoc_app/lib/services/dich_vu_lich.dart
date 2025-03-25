import 'package:firebase_database/firebase_database.dart';
import '../models/lich_hoc.dart';

class DichVuLich {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('lichHoc');

  Future<List<LichHoc>> layDanhSachLich() async {
    try {
      print('===== DEBUG: Bắt đầu lấy dữ liệu từ Firebase =====');
      print('URL Database: ${_dbRef.toString()}');
      print('Path: ${_dbRef.path}');

      // Kiểm tra kết nối
      final DatabaseReference rootRef = FirebaseDatabase.instance.ref();
      print('Kiểm tra kết nối đến root...');
      final rootSnapshot = await rootRef.get();
      print('Root snapshot exists: ${rootSnapshot.exists}');

      // Lấy dữ liệu từ node lichHoc
      print('Đang lấy dữ liệu từ node lichHoc...');
      var snapshot = await _dbRef.get();
      print('Đã nhận snapshot từ Firebase');
      print('Snapshot tồn tại: ${snapshot.exists}');
      print('Giá trị snapshot: ${snapshot.value}');

      if (!snapshot.exists) {
        print('Node lichHoc không tồn tại, tạo node mới với dữ liệu mẫu...');
        // Tạo dữ liệu mẫu
        final Map<String, dynamic> sampleData = {
          'lich_mau': {
            'tenMonHoc': 'Môn học mẫu',
            'moTa': 'Đây là môn học mẫu',
            'thoiGianBatDau': DateTime.now().toIso8601String(),
            'thoiGianKetThuc':
                DateTime.now().add(const Duration(hours: 2)).toIso8601String(),
            'diaDiem': 'Phòng học mẫu',
            'tenGiangVien': 'Giảng viên mẫu',
            'maMonHoc': 'MH001',
            'daHoanThanh': false
          }
        };
        await _dbRef.set(sampleData);
        print('Đã tạo dữ liệu mẫu');
        snapshot = await _dbRef.get();
      }

      if (snapshot.exists && snapshot.value != null) {
        print('Snapshot có dữ liệu, bắt đầu chuyển đổi...');
        final Map<dynamic, dynamic> values =
            snapshot.value as Map<dynamic, dynamic>;
        print('Số lượng records: ${values.length}');

        final result = values.entries.map((e) {
          print('Đang xử lý record với key: ${e.key}');
          try {
            final data = Map<String, dynamic>.from(e.value as Map);
            data['id'] = e.key;
            return LichHoc.fromJson(data);
          } catch (parseError) {
            print('Lỗi khi xử lý record ${e.key}: $parseError');
            print('Dữ liệu gốc: ${e.value}');
            rethrow;
          }
        }).toList();

        print('Đã chuyển đổi thành công ${result.length} records');
        return result;
      }
      print('CẢNH BÁO: Không có dữ liệu trong snapshot');
      return [];
    } catch (e) {
      print('===== LỖI KHI LẤY DỮ LIỆU =====');
      print('Chi tiết lỗi: $e');
      print('Stack trace: ${StackTrace.current}');
      throw Exception('Không thể lấy danh sách lịch học: $e');
    }
  }

  Future<LichHoc> themLichHoc(LichHoc lichHoc) async {
    try {
      final newRef = _dbRef.push();
      final data = lichHoc.toJson();
      await newRef.set(data);
      return lichHoc.copyWith(id: newRef.key);
    } catch (e) {
      throw Exception('Không thể thêm lịch học: $e');
    }
  }

  Future<void> capNhatLichHoc(LichHoc lichHoc) async {
    try {
      final data = lichHoc.toJson();
      await _dbRef.child(lichHoc.id).update(data);
    } catch (e) {
      throw Exception('Không thể cập nhật lịch học: $e');
    }
  }

  Future<void> xoaLichHoc(String id) async {
    try {
      await _dbRef.child(id).remove();
    } catch (e) {
      throw Exception('Không thể xóa lịch học: $e');
    }
  }
}
