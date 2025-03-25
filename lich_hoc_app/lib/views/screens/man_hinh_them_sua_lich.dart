import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/quan_ly_lich.dart';
import '../../models/lich_hoc.dart';

class ManHinhThemSuaLich extends StatefulWidget {
  final LichHoc? lichHoc;

  const ManHinhThemSuaLich({Key? key, this.lichHoc}) : super(key: key);

  @override
  State<ManHinhThemSuaLich> createState() => _ManHinhThemSuaLichState();
}

class _ManHinhThemSuaLichState extends State<ManHinhThemSuaLich> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tenMonHocController;
  late TextEditingController _moTaController;
  late TextEditingController _diaDiemController;
  late TextEditingController _tenGiangVienController;
  late TextEditingController _maMonHocController;
  late DateTime _thoiGianBatDau;
  late DateTime _thoiGianKetThuc;

  @override
  void initState() {
    super.initState();
    _tenMonHocController =
        TextEditingController(text: widget.lichHoc?.tenMonHoc ?? '');
    _moTaController = TextEditingController(text: widget.lichHoc?.moTa ?? '');
    _diaDiemController =
        TextEditingController(text: widget.lichHoc?.diaDiem ?? '');
    _tenGiangVienController =
        TextEditingController(text: widget.lichHoc?.tenGiangVien ?? '');
    _maMonHocController =
        TextEditingController(text: widget.lichHoc?.maMonHoc ?? '');
    _thoiGianBatDau = widget.lichHoc?.thoiGianBatDau ?? DateTime.now();
    _thoiGianKetThuc = widget.lichHoc?.thoiGianKetThuc ??
        DateTime.now().add(const Duration(hours: 1));
  }

  @override
  void dispose() {
    _tenMonHocController.dispose();
    _moTaController.dispose();
    _diaDiemController.dispose();
    _tenGiangVienController.dispose();
    _maMonHocController.dispose();
    super.dispose();
  }

  Future<void> _chonThoiGian(bool laBatDau) async {
    final TimeOfDay? thoiGian = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay.fromDateTime(laBatDau ? _thoiGianBatDau : _thoiGianKetThuc),
    );

    if (thoiGian != null) {
      final DateTime ngayHienTai =
          laBatDau ? _thoiGianBatDau : _thoiGianKetThuc;
      final DateTime thoiGianMoi = DateTime(
        ngayHienTai.year,
        ngayHienTai.month,
        ngayHienTai.day,
        thoiGian.hour,
        thoiGian.minute,
      );

      setState(() {
        if (laBatDau) {
          _thoiGianBatDau = thoiGianMoi;
        } else {
          _thoiGianKetThuc = thoiGianMoi;
        }
      });
    }
  }

  Future<void> _chonNgay(bool laBatDau) async {
    final DateTime? ngay = await showDatePicker(
      context: context,
      initialDate: laBatDau ? _thoiGianBatDau : _thoiGianKetThuc,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (ngay != null) {
      final DateTime thoiGianHienTai =
          laBatDau ? _thoiGianBatDau : _thoiGianKetThuc;
      final DateTime thoiGianMoi = DateTime(
        ngay.year,
        ngay.month,
        ngay.day,
        thoiGianHienTai.hour,
        thoiGianHienTai.minute,
      );

      setState(() {
        if (laBatDau) {
          _thoiGianBatDau = thoiGianMoi;
        } else {
          _thoiGianKetThuc = thoiGianMoi;
        }
      });
    }
  }

  void _luuLichHoc() {
    if (_formKey.currentState!.validate()) {
      final lichHoc = LichHoc(
        id: widget.lichHoc?.id ?? DateTime.now().toString(),
        tenMonHoc: _tenMonHocController.text,
        moTa: _moTaController.text,
        thoiGianBatDau: _thoiGianBatDau,
        thoiGianKetThuc: _thoiGianKetThuc,
        diaDiem: _diaDiemController.text,
        tenGiangVien: _tenGiangVienController.text,
        maMonHoc: _maMonHocController.text,
        daHoanThanh: widget.lichHoc?.daHoanThanh ?? false,
      );

      if (widget.lichHoc == null) {
        Provider.of<QuanLyLich>(context, listen: false).themLichHoc(lichHoc);
      } else {
        Provider.of<QuanLyLich>(context, listen: false).capNhatLichHoc(lichHoc);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lichHoc == null ? 'Thêm lịch học' : 'Sửa lịch học'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tenMonHocController,
                decoration: const InputDecoration(labelText: 'Tên môn học'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên môn học';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _maMonHocController,
                decoration: const InputDecoration(labelText: 'Mã môn học'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã môn học';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tenGiangVienController,
                decoration: const InputDecoration(labelText: 'Tên giảng viên'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên giảng viên';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _diaDiemController,
                decoration: const InputDecoration(labelText: 'Địa điểm'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa điểm';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _moTaController,
                decoration: const InputDecoration(labelText: 'Mô tả'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Thời gian bắt đầu'),
                        TextButton(
                          onPressed: () => _chonNgay(true),
                          child: Text(
                              '${_thoiGianBatDau.day}/${_thoiGianBatDau.month}/${_thoiGianBatDau.year}'),
                        ),
                        TextButton(
                          onPressed: () => _chonThoiGian(true),
                          child: Text(
                              '${_thoiGianBatDau.hour.toString().padLeft(2, '0')}:${_thoiGianBatDau.minute.toString().padLeft(2, '0')}'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Thời gian kết thúc'),
                        TextButton(
                          onPressed: () => _chonNgay(false),
                          child: Text(
                              '${_thoiGianKetThuc.day}/${_thoiGianKetThuc.month}/${_thoiGianKetThuc.year}'),
                        ),
                        TextButton(
                          onPressed: () => _chonThoiGian(false),
                          child: Text(
                              '${_thoiGianKetThuc.hour.toString().padLeft(2, '0')}:${_thoiGianKetThuc.minute.toString().padLeft(2, '0')}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _luuLichHoc,
                child:
                    Text(widget.lichHoc == null ? 'Thêm lịch học' : 'Cập nhật'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
