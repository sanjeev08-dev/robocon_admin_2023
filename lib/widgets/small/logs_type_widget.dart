import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robocon_admin_2023/helper/app_holder.dart';
import 'package:robocon_admin_2023/helper/app_holder.dart';
import 'package:robocon_admin_2023/helper/app_holder.dart';

import '../../helper/styles.dart';

class LogsTypeWidget extends StatelessWidget {

  String? selectedType;
  void Function(String?)? onChanged;

  LogsTypeWidget({Key? key, this.selectedType, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedType,
      icon: Icon(
        Icons.arrow_downward_outlined,
        color: Theme.of(context).primaryColor,
      ),
      hint: Text(
        "Select type",
        style: textStyle(
          context: context,
          color: Colors.grey,
        ),
      ),
      style: textStyle(context: context),
      onChanged: onChanged,
      items: List.generate(
        AppHolder.types.length,
            (index) => DropdownMenuItem<String>(
          value: AppHolder.types[index],
          child: Text(
            AppHolder.types[index],
            style: textStyle(
              context: context,
            ),
          ),
        ),
      ),
    );
  }
}
