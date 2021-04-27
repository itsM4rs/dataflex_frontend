import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class RoundedRectangleButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const RoundedRectangleButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: Text(text),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
