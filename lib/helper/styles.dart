import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle({
  Color? color,
  required BuildContext context,
  FontSize? fontSize,
  bool isBold = false,
  bool isItalic = false,
  bool haveShadow = false,
  TextDecoration textDecoration = TextDecoration.none,
  bool isCard = false,
}) {
  return isCard
      ? GoogleFonts.lora(
          color: color ?? Colors.black,
          fontSize: _getFontSize(fontSize ?? FontSize.H4, context),
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          decoration: textDecoration,
          shadows: haveShadow
              ? [
                  const Shadow(
                    blurRadius: 4,
                    color: Colors.white,
                    offset: Offset(-3, 3),
                  ),
                ]
              : null,
        )
      : GoogleFonts.openSans(
          color: color ?? Colors.black,
          fontSize: _getFontSize(fontSize ?? FontSize.H4, context),
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          decoration: textDecoration,
          shadows: haveShadow
              ? [
                  const Shadow(
                    blurRadius: 4,
                    color: Colors.white,
                    offset: Offset(-3, 3),
                  ),
                ]
              : null,
        );
}

_getFontSize(FontSize fontSize, BuildContext context) {
  switch (fontSize) {
    case FontSize.H1:
      return getHeight(30, context);

    case FontSize.H2:
      return getHeight(25, context);

    case FontSize.H3:
      return getHeight(20, context);

    case FontSize.H4:
      return getHeight(15, context);

    case FontSize.H5:
      return getHeight(10, context);

    case FontSize.H6:
      return getHeight(5, context);
    case FontSize.H7:
      return getHeight(1, context);
    case FontSize.TITLE:
      return getHeight(40, context);
  }
}

double width(BuildContext context) => MediaQuery.of(context).size.width;
double height(BuildContext context) => MediaQuery.of(context).size.height;

double getWidth(double size, BuildContext context) {
  double _width = MediaQuery.of(context).size.width;
  return _width * (size / 750);
}

double getHeight(double size, BuildContext context) {
  double _height = MediaQuery.of(context).size.height;
  return _height * (size / 750);
}

enum FontSize {
  H1,
  H2,
  H3,
  H4,
  H5,
  H6,
  H7,
  TITLE,
}
