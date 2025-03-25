import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/quan_ly_lich.dart';
import 'views/screens/man_hinh_chinh.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    print('===== KHỞI TẠO FIREBASE =====');
    final FirebaseOptions firebaseOptions = FirebaseOptions(
      apiKey: 'AIzaSyDF1_xxYF7fcbnndS1iaK_m1ZnskptLAd0',
      appId: '1:44077152334:android:2bb4613abd6cce8c216b1f',
      messagingSenderId: '44077152334',
      projectId: 'myproject-6ec40',
      databaseURL: 'https://myproject-6ec40-default-rtdb.firebaseio.com',
      storageBucket: 'myproject-6ec40.firebasestorage.app',
    );

    final FirebaseApp app =
        await Firebase.initializeApp(options: firebaseOptions);
    print('Firebase đã khởi tạo thành công');
    print('Firebase App name: ${app.name}');
    print('Firebase Options: ${app.options.asMap}');

    final DatabaseReference testRef = FirebaseDatabase.instance.ref();
    print('Đang kiểm tra kết nối database...');
    await testRef.get();
    print('Kết nối database thành công!');
  } catch (e) {
    print('===== LỖI KHỞI TẠO FIREBASE =====');
    print('Chi tiết lỗi: $e');
    print('Stack trace: ${StackTrace.current}');
  }

  runApp(const UngDungChinh());
}

class UngDungChinh extends StatelessWidget {
  const UngDungChinh({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuanLyLich(),
      child: MaterialApp(
        title: 'Quản lý lịch học',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const ManHinhChinh(),
      ),
    );
  }
}
