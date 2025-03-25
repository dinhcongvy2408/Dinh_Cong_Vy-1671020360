import '../models/bmi_model.dart';

class TinhToanBMI {
  static double tinhBMI(double chieuCao, double canNang) {
    // Chuyển chiều cao từ cm sang m
    double chieuCaoMet = chieuCao / 100;
    return canNang / (chieuCaoMet * chieuCaoMet);
  }

  static String phanLoaiBMI(double bmi) {
    if (bmi < 18.5) {
      return 'Thiếu cân';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Bình thường';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Thừa cân';
    } else {
      return 'Béo phì';
    }
  }

  static BMI taoKetQuaBMI({
    required String id,
    required double chieuCao,
    required double canNang,
  }) {
    double chiSoBMI = tinhBMI(chieuCao, canNang);
    String ketQua = phanLoaiBMI(chiSoBMI);

    return BMI(
      id: id,
      chieuCao: chieuCao,
      canNang: canNang,
      chiSoBMI: chiSoBMI,
      ketQua: ketQua,
      ngayTinh: DateTime.now(),
    );
  }
}
