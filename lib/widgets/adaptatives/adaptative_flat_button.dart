import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeFlatButton extends StatelessWidget {
  final String titleBtn;
  final Function datePickerHandler;
  final double fontSizeBtn;

  AdaptativeFlatButton(this.titleBtn, this.datePickerHandler,
      {this.fontSizeBtn = 14});

  Widget _getCupertinoBtn(BuildContext ctx) {
    return CupertinoButton(
      child: Text(
        titleBtn,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSizeBtn,
            color: Theme.of(ctx).primaryColor),
      ),
      onPressed: datePickerHandler,
    );
  }

  Widget _getFlatButton(BuildContext ctx) {
    return FlatButton(
      textColor: Theme.of(ctx).primaryColor,
      child: Text(
        titleBtn,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: datePickerHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Platform.isIOS
        ? _getCupertinoBtn(context)
        : _getFlatButton(context),
    );
  }
}
