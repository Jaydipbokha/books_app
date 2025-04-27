import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  String? text;
  Color? color;
  double? fontSize;
  String? fontFamily;
  TextAlign? textAlign;
  FontWeight? fontWeight;

  CustomText(this.text,
      {super.key,
      this.color,
      this.fontSize,
      this.fontFamily,
      this.textAlign,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color,
        fontSize: fontSize ?? 18,
      ),
      textAlign: textAlign,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
