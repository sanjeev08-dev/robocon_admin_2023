import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../helper/flutter_bounce.dart';
import '../../helper/styles.dart';

class GenderSelectionWidget extends StatelessWidget {
  List<String> gendersList = ["Male", "Female"];
  String selectedGender;
  final ValueChanged<String> onSelectionChanged;
  GenderSelectionWidget(
      {Key? key,
      this.selectedGender = "Male",
      required this.onSelectionChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: getHeight(15, context),
          left: getWidth(10, context),
          right: getWidth(10, context)),
      width: width(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender *",
            style: textStyle(
              context: context,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              gendersList.length,
              (index) => Bounce(
                onPressed: () {
                  onSelectionChanged(gendersList[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: gendersList[index] == selectedGender
                        ? Theme.of(context).shadowColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(
                      getWidth(5, context),
                    ),
                    border: Border.all(
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                  width: width(context) * 0.15,
                  height: getHeight(60, context),
                  padding: EdgeInsets.all(getWidth(0, context)),
                  child: Column(
                    children: [
                      Expanded(
                        child: FittedBox(
                          child: Opacity(
                            opacity: index == 2 ? 0 : 1,
                            child: Icon(
                              _getIcon(
                                gendersList[index],
                              ),
                              color: gendersList[index] == selectedGender
                                  ? Colors.white
                                  : Theme.of(context).shadowColor,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        gendersList[index],
                        style: textStyle(
                            context: context,
                            color: gendersList[index] == selectedGender
                                ? Colors.white
                                : Theme.of(context).shadowColor,
                            fontSize: FontSize.H4),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  IconData? _getIcon(gender) {
    switch (gender) {
      case "Male":
        return FontAwesomeIcons.person;
      case "Female":
        return FontAwesomeIcons.personDress;
      case "other":
        return FontAwesomeIcons.person;
      default:
        return FontAwesomeIcons.person;
    }
  }
}
