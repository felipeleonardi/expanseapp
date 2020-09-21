import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final String placeholder;
  final Function submitHandler;
  final TextEditingController ctrlField;
  final TextInputType keyboardType;

  AdaptativeTextField(
    this.placeholder,
    this.submitHandler,
    this.ctrlField,
    {this.keyboardType = TextInputType.text}
  );

  Widget _getCupertinoTextField() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10,),
      child: CupertinoTextField(
        placeholder: placeholder,
        controller: ctrlField,
        keyboardType: keyboardType,
        onSubmitted: (_) => submitHandler(),
      ),
    );
  }

  Widget _getTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: placeholder,
      ),
      controller: ctrlField,
      onSubmitted: (_) => submitHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Platform.isIOS
      ? _getCupertinoTextField()
      : _getTextField()
    );
  }
}
