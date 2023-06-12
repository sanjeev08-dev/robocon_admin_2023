import 'package:flutter/material.dart';

import '../../helper/styles.dart';

class LineTitleWidget extends StatelessWidget {
  final String title;

  const LineTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: getWidth(
          15,
          context,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: getHeight(2, context),
              color: Theme.of(context).shadowColor,
            ),
          ),
          if (title.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(getWidth(10, context)),
              child: Text(
                title,
                style: textStyle(
                  context: context,
                  color: Theme.of(context).shadowColor,
                  fontSize: FontSize.H4,
                  isBold: true,
                ),
              ),
            ),
          Expanded(
            child: Container(
              height: getHeight(2, context),
              color: Theme.of(context).shadowColor,
            ),
          ),
        ],
      ),
    );
  }
}
