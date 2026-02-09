import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar show({
    required String text,
    required Color color,
    IconData icon = Icons.check_circle,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(16),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'إغلاق',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  static SnackBar success(String text) {
    return show(
      text: text,
      color: Colors.green.shade600,
      icon: Icons.check_circle,
    );
  }

  static SnackBar error(String text) {
    return show(text: text, color: Colors.red.shade600, icon: Icons.error);
  }

  static SnackBar warning(String text) {
    return show(text: text, color: Colors.orange.shade600, icon: Icons.warning);
  }

  static SnackBar info(String text) {
    return show(text: text, color: Colors.blue.shade600, icon: Icons.info);
  }
}
