import 'package:flutter/material.dart';

import '../helper/styles.dart';
import '../widgets/large/button.dart';
import '../widgets/large/text_field_container.dart';
import 'controller.dart';

class Large extends StatelessWidget {
  LoginController controller;

  Large({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context),
      height: height(context),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              "asset/bg_image.png",
              width: width(context),
              height: height(context),
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height(context) * 0.1,
                  width: width(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        getWidth(5, context),
                      ),
                      bottomRight: Radius.circular(
                        getWidth(5, context),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-3, 3),
                        blurRadius: getWidth(20, context),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "asset/robocon_logo.png",
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(
                    getWidth(20, context),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: getWidth(50, context),
                    vertical: getHeight(20, context),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      getWidth(10, context),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-3, 3),
                        blurRadius: getWidth(20, context),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Smart Digital Registration & Verification System",
                        style: textStyle(
                          context: context,
                          fontSize: FontSize.H1,
                          isBold: true,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          getWidth(5, context),
                        ),
                        child: Image.asset(
                          "asset/game_content.png",
                          height: getHeight(200, context),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(10, context),
                      ),
                      TextFieldContainer(
                        textEditingController: controller.usernameController,
                        title: "Username",
                        isLastField: false,
                      ),
                      TextFieldContainer(
                        textEditingController: controller.passwordController,
                        title: "Password",
                        isLastField: false,
                        keyboardType: controller.showPassword
                            ? TextInputType.text
                            : TextInputType.visiblePassword,
                        onToggle: () {
                          controller.showPassword = !controller.showPassword;
                          controller.update();
                        },
                        isPasswordType: true,
                      ),
                      SizedBox(
                        height: getHeight(20, context),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: getWidth(100, context),
                        ),
                        child: AppButton(
                          // icon: FontAwesomeIcons.google,
                          text: "Login",
                          iconSize: 30,
                          isLoading: controller.isLoading,
                          onTap: () {
                            controller.login(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: getHeight(10, context),
                      ),
                      Text(
                        "Provided By",
                        style: textStyle(
                          context: context,
                          fontSize: FontSize.H3,
                          isBold: true,
                        ),
                      ),
                      SizedBox(
                        height: getHeight(10, context),
                      ),
                      Image.asset(
                        "asset/fsmlogo.png",
                        height: getHeight(80, context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
