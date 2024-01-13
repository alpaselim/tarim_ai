import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Data/app_constants.dart';

class SnackbarService {
  static final SnackbarService _instance = SnackbarService._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory SnackbarService() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  SnackbarService._internal() {
    // initialization logic
  }

  Duration snacbarDuration = const Duration(seconds: 2);
  EdgeInsets snacbarPadding = const EdgeInsets.all(10);
  double snackbarRadius = 12.0;

  void showErrorSnackBar(String? message) {
    Get.showSnackbar(
      GetSnackBar(
        title: "Hata",
        message: message,
        icon: const Icon(Icons.error, color: kWhiteColor),
        duration: snacbarDuration,
        backgroundColor: kRedColor,
        snackPosition: SnackPosition.TOP,
        borderRadius: snackbarRadius,
        padding: snacbarPadding,
        margin: snacbarPadding,
      ),
    );
  }

  void showWarningSnackBar(String? message) {
    Get.showSnackbar(
      GetSnackBar(
        title: "Uyarı",
        message: message,
        icon: const Icon(Icons.warning_sharp, color: kWhiteColor),
        duration: snacbarDuration,
        backgroundColor: kOrangeColor,
        snackPosition: SnackPosition.TOP,
        borderRadius: snackbarRadius,
        padding: snacbarPadding,
        margin: snacbarPadding,
      ),
    );
  }

  void showSuccessSnackBar(String? message) {
    Get.showSnackbar(
      GetSnackBar(
        title: "Başarılı",
        message: message,
        icon: const Icon(Icons.check_box_rounded, color: kWhiteColor),
        duration: snacbarDuration,
        backgroundColor: kBlueColor,
        snackPosition: SnackPosition.TOP,
        borderRadius: snackbarRadius,
        padding: snacbarPadding,
        margin: snacbarPadding,
      ),
    );
  }
}

final SnackbarService snackbarService = SnackbarService();
