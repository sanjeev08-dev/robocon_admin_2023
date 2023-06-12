import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/styles.dart';

class TypeWidget extends StatelessWidget {
  List<String> types = [
    "Organiser",
    "Participant",
    "Sponsor",
    "Volunteer",
    "Visitor",
  ];
  String? selectedType;
  void Function(String?)? onChanged;

  TypeWidget({Key? key, this.selectedType, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getWidth(10, context)),
      child: Row(
        children: [
          Text(
            "Registration as ",
            style: textStyle(
              context: context,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            width: getWidth(20, context),
          ),
          DropdownButton<String>(
            value: selectedType,
            icon: Icon(
              Icons.arrow_downward_outlined,
              color: Theme.of(context).primaryColor,
            ),
            hint: Text(
              "Select registration as",
              style: textStyle(
                context: context,
                color: Colors.grey,
              ),
            ),
            style: textStyle(context: context),
            onChanged: onChanged,
            items: List.generate(
              types.length,
              (index) => DropdownMenuItem<String>(
                value: types[index],
                child: Text(
                  types[index],
                  style: textStyle(
                    context: context,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
