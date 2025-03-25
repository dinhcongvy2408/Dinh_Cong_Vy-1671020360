# Ứng Dụng Quản Lý Lịch Học

## Giới thiệu
Ứng dụng quản lý lịch học được phát triển bằng Flutter và Firebase, giúp người dùng theo dõi và quản lý lịch học một cách hiệu quả.

## Công nghệ sử dụng
- **Frontend**: Flutter
- **Backend**: Firebase
  - Firebase Realtime Database
  - Firebase Core

## Cấu trúc dự án
```
lich_hoc_app/
├── lib/
│   ├── controllers/
│   │   └── quan_ly_lich.dart
│   ├── views/
│   │   └── screens/
│   │       └── man_hinh_chinh.dart
│   └── main.dart
```

## Cài đặt và chạy dự án

### Yêu cầu hệ thống
- Flutter SDK
- Android Studio hoặc VS Code
- Firebase CLI
- Git

### Các bước cài đặt
1. Clone repository
```bash
git clone [URL_REPOSITORY]
```

2. Cài đặt dependencies
```bash
flutter pub get
```

3. Cấu hình Firebase
- Tạo project trên Firebase Console
- Tải file `google-services.json` và đặt vào thư mục `android/app/`
- Cập nhật các thông tin cấu hình Firebase trong `main.dart`

4. Chạy ứng dụng
```bash
flutter run
```

## Tính năng chính
- Quản lý lịch học
- Đồng bộ dữ liệu realtime với Firebase
- Giao diện người dùng thân thiện với Material Design 3

## Tài liệu tham khảo
- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Firebase Core Package](https://pub.dev/packages/firebase_core)
- [Firebase Database Package](https://pub.dev/packages/firebase_database)

## Tác giả
[Your Name]

## Giấy phép
[License Type] 