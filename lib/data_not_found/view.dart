import 'package:flutter/cupertino.dart';

import '../helper/styles.dart';

class DataNotFoundView extends StatelessWidget {
  const DataNotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context),
      height: height(context),
      child: Center(
        child: Text(
          "Please Scan QR for detail",
          style: textStyle(
            context: context,
            isBold: true,
            fontSize: FontSize.H1,
          ),
        ),
      ),
    );
  }
}
