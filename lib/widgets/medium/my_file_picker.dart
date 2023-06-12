import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../helper/flutter_bounce.dart';
import '../../helper/styles.dart';

class FilePickerButton extends StatelessWidget {
  void Function(Uint8List?) onFileSelected;
  List<String>? extensions;
  bool isLoading;
  String title;
  String? filePath;
  FilePickerButton({
    Key? key,
    this.extensions,
    required this.title,
    required this.onFileSelected,
    required this.isLoading,
    this.filePath,
  }) : super(key: key);

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
            title,
            style: textStyle(
              context: context,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Bounce(
            onPressed: () async {
              if (Get.focusScope!.hasFocus) {
                Get.focusScope!.unfocus();
              }
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: extensions,
              );
              if (result != null) {
                onFileSelected(result.files.single.bytes);
              }
              // onTap!();
            },
            child: Container(
              margin: EdgeInsets.only(bottom: getHeight(15, context)),
              height: getHeight(50, context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  getWidth(1000, context),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(getWidth(2, context)),
                child: Center(
                  child: isLoading
                      ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: getHeight(40, context),
                        )
                      : filePath != null
                          ? Text(
                              "File uploaded",
                              style: textStyle(
                                context: context,
                                color: Colors.white,
                                fontSize: FontSize.H3,
                                isBold: true,
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Choose ${extensions!.join(' or ')} file",
                                  style: textStyle(
                                    context: context,
                                    color: Colors.white,
                                    fontSize: FontSize.H3,
                                    isBold: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: getWidth(5, context),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.file,
                                    size: getHeight(30, context),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
