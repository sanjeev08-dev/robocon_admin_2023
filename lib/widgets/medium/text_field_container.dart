import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../helper/flutter_bounce.dart';
import '../../helper/styles.dart';
import 'text_field.dart';

class TextFieldContainer extends StatelessWidget {
  TextEditingController textEditingController;
  TextInputType? keyboardType;
  bool readOnly;
  bool isLastField;
  IconData? icon;
  String? hint;
  String title;
  Color? primaryColor;
  Color? secondaryColor;
  int? maxLine;
  Function(String)? onChanged;
  bool isPasswordType;
  void Function()? onToggle;

  TextFieldContainer({
    Key? key,
    required this.textEditingController,
    this.keyboardType,
    this.readOnly = false,
    this.isLastField = false,
    this.hint,
    this.onChanged,
    this.primaryColor,
    this.secondaryColor,
    this.icon,
    this.maxLine,
    required this.title,
    this.onToggle,
    this.isPasswordType = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getWidth(10, context)),
      child: Opacity(
        opacity: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle(
                context: context,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: getHeight(5, context)),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(
                  getWidth(10, context),
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(-6, 6),
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 12)
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: getHeight(0, context)),
              child: AppTextField(
                textEditingController: textEditingController,
                icon: icon,
                isLastField: isLastField,
                key: key,
                onChanged: onChanged,
                keyboardType: keyboardType,
                hint: hint,
                maxLine: maxLine,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                readOnly: readOnly,
              ),
            ),
            if (isPasswordType)
              Row(
                children: [
                  Bounce(
                    onPressed: onToggle!,
                    child: Icon(
                      keyboardType != TextInputType.visiblePassword
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      color: Theme.of(context).primaryColor,
                      size: getWidth(15, context),
                    ),
                  ),
                  SizedBox(
                    width: getWidth(10, context),
                  ),
                  Text(
                    "Show Password",
                    style: textStyle(
                      context: context,
                      fontSize: FontSize.H4,
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
