import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar{
  CustomSnackBar({
    Key? key,
    required String message,
    String btnLabel = 'ok',
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onOk
  }) : super(
    key: key, 
  content: Text(message), 
  duration: duration, 
  action: SnackBarAction(
    label: btnLabel, onPressed: (){
    if (onOk != null){
      onOk();
    }
  }));
}