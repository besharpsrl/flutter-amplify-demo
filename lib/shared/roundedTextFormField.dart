import 'package:flutter/material.dart';

Widget roundedTextFormField(TextEditingController controller, String hintText, Color mainColor, Color backColor, Function validation, obscured) {
  return Padding(
      padding: EdgeInsets.only(bottom: 10, left: 50, right: 50),
      child: TextFormField(
          obscureText: obscured,
          controller: controller,
          validator: (value) => validation(value),
          style: TextStyle(color: mainColor),
          decoration: new InputDecoration(
            border: new OutlineInputBorder(borderRadius: BorderRadius.circular(100.0),),
            filled: true,
            hintStyle: new TextStyle(color: mainColor.withOpacity(0.5)),
            hintText: hintText,
            fillColor: backColor
          ),
      )
  );
}