import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;
  AdaptiveTextButton(this.text, this.handler);
  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? CupertinoButton(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: handler)
        : TextButton(
            onPressed: handler,
            child: Text(
              text,
              // style: Theme.of(context).textTheme.headline6,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
  }
}
