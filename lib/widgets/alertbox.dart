import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertBox extends StatelessWidget {
  final String message;
  final Function onConfirm;


  const AlertBox({super.key, required this.message, required this.onConfirm});

  Future<void> show() async {
    return Get.defaultDialog(
      title: "Alert",
      middleText: message,
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        onConfirm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
