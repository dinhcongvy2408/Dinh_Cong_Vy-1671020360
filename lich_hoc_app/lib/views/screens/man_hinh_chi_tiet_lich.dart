import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../controllers/quan_ly_lich.dart';
import '../../models/lich_hoc.dart';
import 'man_hinh_them_sua_lich.dart';

class ManHinhChiTietLich extends StatelessWidget {
  final LichHoc lichHoc;

  const ManHinhChiTietLich({Key? key, required this.lichHoc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dinhDangThoiGian = DateFormat('HH:mm');
    final dinhDangNgay = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết lịch học'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManHinhThemSuaLich(lichHoc: lichHoc),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Xác nhận xóa'),
                  content:
                      const Text('Bạn có chắc chắn muốn xóa lịch học này?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<QuanLyLich>(context, listen: false)
                            .xoaLichHoc(lichHoc.id);
                        Navigator.pop(context); // Đóng dialog
                        Navigator.pop(context); // Quay lại màn hình chính
                      },
                      child: const Text('Xóa'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThongTinItem('Tên môn học', lichHoc.tenMonHoc),
            _buildThongTinItem('Mã môn học', lichHoc.maMonHoc),
            _buildThongTinItem('Giảng viên', lichHoc.tenGiangVien),
            _buildThongTinItem('Địa điểm', lichHoc.diaDiem),
            _buildThongTinItem(
              'Thời gian',
              '${dinhDangNgay.
              format(lichHoc.thoiGianBatDau)} ${dinhDangThoiGian.
              format(lichHoc.thoiGianBatDau)} - ${dinhDangThoiGian.
              format(lichHoc.thoiGianKetThuc)}',
            ),
            _buildThongTinItem('Trạng thái',
                lichHoc.daHoanThanh ? 'Đã hoàn thành' : 'Chưa hoàn thành'),
            if (lichHoc.moTa.isNotEmpty)
              _buildThongTinItem('Mô tả', lichHoc.moTa),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<QuanLyLich>(context, listen: false)
              .chuyenTrangThaiHoanThanh(lichHoc.id);
          Navigator.pop(context);
        },
        child: Icon(lichHoc.daHoanThanh ? Icons.refresh : Icons.check),
      ),
    );
  }

  Widget _buildThongTinItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
