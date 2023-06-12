import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/styles.dart';

class TransportWidget extends StatelessWidget {
  List<String> bloodGroups = [
    "Train",
    "Flight",
    "Bus",
    "Personal Vehicle",
  ];
  String? selectedTransport;
  void Function(String?)? onChanged;

  TransportWidget({Key? key, this.selectedTransport, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getWidth(10, context)),
      child: Row(
        children: [
          Text(
            "Mode of Transport ",
            style: textStyle(
              context: context,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            width: getWidth(20, context),
          ),
          DropdownButton<String>(
            value: selectedTransport,
            icon: Icon(
              Icons.arrow_downward_outlined,
              color: Theme.of(context).primaryColor,
            ),
            hint: Text(
              "Select Mode of Transport",
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
