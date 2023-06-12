import 'package:flutter/material.dart';

import '../../helper/flutter_bounce.dart';
import '../../helper/styles.dart';

class YesNoButton extends StatelessWidget {
  void Function(bool) onChanges;
  String title;
  bool isShow;

  YesNoButton(
      {Key? key,
      required this.title,
      required this.isShow,
      required this.onChanges})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: getHeight(15, context),
        left: getWidth(10, context),
        right: getWidth(10, context),
      ),
      width: width(context) / 3,
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
          SizedBox(
            height: getHeight(2, context),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Bounce(
                  onPressed: () {
                    onChanges(false);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: getWidth(13, context),
                        height: getWidth(13, context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getWidth(100, context),
                          ),
                          border: Border.all(),
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          width: getWidth(9, context),
                          height: getWidth(9, context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getWidth(100, context),
                            ),
                            color: !isShow ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getWidth(3, context),
                      ),
                      Text(
                        "No",
                        style: textStyle(
                          context: context,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Bounce(
                  onPressed: () {
                    onChanges(true);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: getWidth(13, context),
                        height: getWidth(13, context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getWidth(100, context),
                          ),
                          border: Border.all(),
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          width: getWidth(9, context),
                          height: getWidth(9, context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getWidth(100, context),
                            ),
                            color: isShow ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getWidth(3, context),
                      ),
                      Text(
                        "Yes",
                        style: textStyle(
                          context: context,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                ),
                /*Bounce(
                  child: Container(
                    width: width(context) *
                        (ResponsiveWidget.isLargeScreen(context) ? 0.1 : 0.3),
                    decoration: BoxDecoration(
                      color: Color(0xFFCB0000),
                      */ /*border: Border.all(
                        color: !isShow
                            ? Theme.of(context).primaryColor
                            : Color(0xFFCB0000),
                        width: getWidth(4, context),
                      ),*/ /*
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          getWidth(100, context),
                        ),
                        bottomLeft: Radius.circular(
                          getWidth(100, context),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: getHeight(5, context),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "No",
                      style: textStyle(
                        context: context,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                  onPressed: () {
                    onChanges(false);
                  },
                ),
                Bounce(
                  child: Container(
                    width: width(context) *
                        (ResponsiveWidget.isLargeScreen(context) ? 0.1 : 0.3),
                    decoration: BoxDecoration(
                      color: Color(0xFF008404),
                      */ /*border: Border.all(
                        color: isShow
                            ? Theme.of(context).primaryColor
                            : Color(0xFF008404),
                        width: getWidth(4, context),
                      ),*/ /*
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          getWidth(100, context),
                        ),
                        bottomRight: Radius.circular(
                          getWidth(100, context),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: getHeight(5, context),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Yes",
                      style: textStyle(
                        context: context,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                  onPressed: () {
                    onChanges(true);
                  },
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
