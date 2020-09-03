import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastr(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white
  );
}