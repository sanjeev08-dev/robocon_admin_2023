import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/styles.dart';

class BloodGroupWidget extends StatelessWidget {
  List<String> bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  String? selectedBloodGroup;
  void Function(String?)? onChanged;

  BloodGroupWidget({Key? key, this.selectedBloodGroup, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getWidth(10, context)),
      child: Row(
        children: [
          Text(
            "Blood Group ",
            style: textStyle(
              context: context,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            width: getWidth(20, context),
          ),
          DropdownButton<String>(
            value: selectedBloodGroup,
            icon: Icon(
              Icons.arrow_downward_outlined,
              color: Theme.of(context).primaryColor,
            ),
            hint: Text(
              "Select blood group",
              style: textStyle(
                context: context,
                color: Colors.grey,
              ),
            ),
            style: textStyle(context: context),
            onChanged: onChanged,
            items: List.generate(
              bloodGroups.length,
              (index) => DropdownMenuItem<String>(
                value: bloodGroups[index],
                child: Text(
                  bloodGroups[index],
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
