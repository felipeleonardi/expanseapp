import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeRaisedButton extends StatelessWidget {
  final String textBtn;
  final Function submitHandler;

  AdaptativeRaisedButton(
    this.textBtn,
    this.submitHandler,
  );

  Widget _getCupertinoBtn(BuildContext ctx) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      child: CupertinoButton(
        color: Theme.of(ctx).primaryColor,
        child: Text(
          textBtn,
          style: TextStyle(fontSize: 16),
        ),
        onPressed: () => submitHandler(),
      ),
    );
  }

  Widget _getFlatButton(BuildContext ctx) {
    return RaisedButton(
      color: Theme.of(ctx).primaryColor,
      textColor: Theme.of(ctx).textTheme.button.color,
      child: Text(
        textBtn,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () => submitHandler(),
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
