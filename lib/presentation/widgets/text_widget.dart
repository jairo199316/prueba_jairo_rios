import 'package:flutter/material.dart';
import 'package:prueba_jairo_rios/core/size_constans.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
  });

  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? SizeConstants.size20,
        fontWeight: fontWeight,
      ),
    );
  }
}
