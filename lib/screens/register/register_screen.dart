import 'package:flutter/material.dart';

import '../../components/ripple_container.dart';
import '../../components/back_icon_button.dart';
import '../../helper/constants.dart';
import '../../helper/server.dart';
import '../../helper/size_config.dart';
import '../../helper/themes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  bool isEmail = false;
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Ulgama girmek"),
        leading: const BackIconButton(),
      ),
      body: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getProportionateScreenHeight(15)),
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(25)),
              child: Image(
                image: themeManager.isDark()
                    ? const AssetImage('assets/images/drawer_logo_dark.webp')
                    : const AssetImage('assets/images/drawer_logo_light.webp'),
                height: getProportionateScreenHeight(85),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            Container(
              child: isEmail
                  ? Row(
                      children: [
                        const Text(
                          "Email:",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: getProportionateScreenWidth(5)),
                        Flexible(
                          child: TextField(
                            controller: emailAddressController,
                            autocorrect: false,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration.collapsed(
                              hintText: "example@gmail.com",
                              hintStyle: TextStyle(),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const Text(
                          "+993",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: getProportionateScreenWidth(10)),
                        Flexible(
                          child: TextField(
                            controller: phoneNumberController,
                            autocorrect: false,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration.collapsed(
                              hintText: "Telefon belgiňiz",
                              hintStyle: TextStyle(),
                            ),
                            onChanged: (value) {
                              if (value.length <= 8) {
                                phoneNumber = value;
                              } else {
                                phoneNumberController.text = phoneNumber;
                              }
                            },
                          ),
                        )
                      ],
                    ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: getProportionateScreenWidth(45),
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            Row(
              children: [
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    }),
                GestureDetector(
                  child: const Text(
                    "Düzgünnamany okadym we kabul etdim",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    navigate.changeScreen(
                      context,
                      ScreenState.webview,
                      url: Server.PRIVACY_POLICY_RU_URL,
                      title: 'Düzgünnama',
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            RippleContainer(
              onTap: () {},
              color: colorAccent,
              padding: EdgeInsets.all(getProportionateScreenHeight(15)),
              borderRadius: buttonBorderRadius,
              child: const Text(
                "TASSYKLAMAK",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            Container(
              child: isEmail
                  ? GestureDetector(
                      child: Text(
                        'Telefon belgisi bilen girmek',
                        style: TextStyle(
                          fontSize: 16,
                          color: appColors.text2ThemeColor,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          isEmail = false;
                        });
                      },
                    )
                  : GestureDetector(
                      child: Text(
                        'Email bilen girmek',
                        style: TextStyle(
                          fontSize: 16,
                          color: appColors.text2ThemeColor,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          isEmail = true;
                        });
                      },
                    ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            Text(
              "Ulgama girmek bilen, siz öz bildirişleriňizi we profiliňizi sazlap bilersiňiz, we özüňiziň başga telefonlaryňyza geçirip bilersiňiz",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appColors.textThemeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
