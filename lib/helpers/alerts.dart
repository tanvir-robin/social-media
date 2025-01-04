import 'package:flutter_easyloading/flutter_easyloading.dart';

class Alerts {
  static void showLoading({String message = 'Loading...'}) {
    EasyLoading.show(status: message);
  }

  static void showSuccess({String message = 'Success!'}) {
    EasyLoading.showSuccess(message);
  }

  static void showError({String message = 'Error!'}) {
    EasyLoading.showError(message);
  }

  static void showInfo({String message = 'Info'}) {
    EasyLoading.showInfo(message);
  }

  static void showToast({String message = 'Toast'}) {
    EasyLoading.showToast(message,
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}
