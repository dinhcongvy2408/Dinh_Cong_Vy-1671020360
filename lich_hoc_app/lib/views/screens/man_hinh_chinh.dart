import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../controllers/quan_ly_lich.dart';
import '../../models/lich_hoc.dart';
import 'man_hinh_chi_tiet_lich.dart';
import 'man_hinh_them_sua_lich.dart';

class ManHinhChinh extends StatefulWidget {
  const ManHinhChinh({Key? key}) : super(key: key);

  @override
  State<ManHinhChinh> createState() => _ManHinhChinhState();
}

class _ManHinhChinhState extends State<ManHinhChinh> {
  CalendarFormat _dinhDangLich = CalendarFormat.week;
  DateTime _ngayDangXem = DateTime.now();
  DateTime _ngayDuocChon = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch học'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<QuanLyLich>(context, listen: false).layDanhSachLich();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _xayDungLich(),
          const SizedBox(height: 8),
          Expanded(
            child: _xayDungDanhSachLich(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManHinhThemSuaLich(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _xayDungLich() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _ngayDangXem,
      calendarFormat: _dinhDangLich,
      selectedDayPredicate: (day) {
        return isSameDay(_ngayDuocChon, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _ngayDuocChon = selectedDay;
          _ngayDangXem = focusedDay;
        });
      },
      onFormatChanged: (format) {
        setState(() {
          _dinhDangLich = format;
        });
      },
      onPageChanged: (focusedDay) {
        _ngayDangXem = focusedDay;
      },
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _xayDungDanhSachLich() {
    return Consumer<QuanLyLich>(
      builder: (context, quanLyLich, child) {
        if (quanLyLich.dangTai) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (quanLyLich.loiHienTai != null) {
          return Center(
            child: Text(
              'Có lỗi xảy ra: ${quanLyLich.loiHienTai}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final danhSachLichTheoNgay = quanLyLich.layLichTheoNgay(_ngayDuocChon);

        if (danhSachLichTheoNgay.isEmpty) {
          return const Center(
            child: Text('Không có lịch học nào cho ngày này'),
          );
        }

        danhSachLichTheoNgay
            .sort((a, b) => a.thoiGianBatDau.compareTo(b.thoiGianKetThuc));

        return ListView.builder(
          itemCount: danhSachLichTheoNgay.length,
          itemBuilder: (context, index) {
            final lichHoc = danhSachLichTheoNgay[index];
            return _xayDungItemLich(lichHoc);
          },
        );
      },
    );
  }

  Widget _xayDungItemLich(LichHoc lichHoc) {
    final dinhDangThoiGian = DateFormat('');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: lichHoc.daHoanThanh ? Colors.green : Colors.blue,
          child: Icon(
            lichHoc.daHoanThanh ? Icons.check : Icons.access_time,
            color: Colors.white,
          ),
        ),
        title: Text(
          lichHoc.tenMonHoc,
          style: TextStyle(
            decoration: lichHoc.daHoanThanh ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${dinhDangThoiGian.
                format(lichHoc.thoiGianBatDau)} - ${dinhDangThoiGian.
                format(lichHoc.thoiGianKetThuc)}'),
            Text('Địa điểm: ${lichHoc.diaDiem}'),
            Text('Giảng viên: ${lichHoc.tenGiangVien}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              icon: Icon(lichHoc.daHoanThanh ? Icons.refresh : Icons.check),
              onPressed: () {
                Provider.of<QuanLyLich>(context, listen: false)
                    .chuyenTrangThaiHoanThanh(lichHoc.id);
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManHinhChiTietLich(lichHoc: lichHoc),
            ),
          );
        },
      ),
    );
  }
}
