import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class MessageService {
  void showMessage(String message, MessageType type);
}

enum MessageType {
  error,
  success,
  info;

  Color get color {
    switch (this) {
      case MessageType.error:
        return Colors.red;
      case MessageType.success:
        return Colors.green;
      case MessageType.info:
        return Colors.blue;
    }
  }
}

class ToastMessageService implements MessageService {
  @override
  void showMessage(String message, MessageType type) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: type.color,
      textColor: Colors.white,
    );
  }
}
