import 'package:flutter/material.dart';

Widget roundedRectButton(String title, Color color, Color textColor, Function callback) {
  return GestureDetector(
      onTap: callback,
      child: Builder(builder: (BuildContext mContext) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Stack(
            alignment: Alignment(1.0, 0.0),
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(mContext).size.width - 100,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: color
                ),
                child: Text(title,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                padding: EdgeInsets.only(top: 16, bottom: 16),
              ),
            ],
          ),
        );
      })
  );
}