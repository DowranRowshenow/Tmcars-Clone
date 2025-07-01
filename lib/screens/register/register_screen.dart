import 'package:flutter/material.dart';

import '../../components/ripple_container.dart';
import '../../helper/constants.dart' as constants;
import '../../helper/server.dart';
import '../../helper/strings.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

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
    final emailAddressController = TextEditingController();
    final phoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(Localization.register),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          splashRadius: constants.splashRadius,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(25),
                child: Image(
                  image: AssetImage(constants.drawerLogoDark),
                  height: 85,
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: isEmail
                    ? Row(
                        children: [
                          const Text(
                            Localization.emailField,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 5),
                          Flexible(
                            child: TextField(
                              key: const Key('emailAddressController'),
                              controller: emailAddressController,
                              autocorrect: false,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration.collapsed(
                                hintText: Localization.exampleEmail,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          const Text(
                            Localization.phoneCode,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: TextField(
                              key: const Key('phoneNumberController'),
                              controller: phoneNumberController,
                              autocorrect: false,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration.collapsed(
                                hintText: Localization.phoneNumber,
                              ),
                              onChanged: (value) => value.length <= 8
                                  ? phoneNumber = value
                                  : phoneNumberController.text = phoneNumber,
                            ),
                          ),
                        ],
                      ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 45),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) =>
                        setState(() => isChecked = !isChecked),
                  ),
                  Flexible(
                    child: GestureDetector(
                      child: Text(
                        Localization.acceptPolicy,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      onTap: () {
                        constants.navigate.changeScreen(
                          context,
                          constants.ScreenState.webview,
                          url: Server.PRIVACY_POLICY_RU_URL,
                          title: Localization.policy,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              RippleContainer(
                onTap: () {},
                color: constants.colorAccent,
                padding: EdgeInsets.all(15),
                borderRadius: constants.buttonBorderRadius,
                child: Text(
                  Localization.accept.toUpperCase(),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: isEmail
                    ? GestureDetector(
                        child: Text(
                          Localization.enterWithPhoneNumber,
                          style: TextStyle(
                            fontSize: 16,
                            color: constants.appColors.text2ThemeColor,
                          ),
                        ),
                        onTap: () => setState(() => isEmail = false),
                      )
                    : GestureDetector(
                        child: Text(
                          Localization.enterWithEmail,
                          style: TextStyle(
                            fontSize: 16,
                            color: constants.appColors.text2ThemeColor,
                          ),
                        ),
                        onTap: () => setState(() => isEmail = true),
                      ),
              ),
              SizedBox(height: 30),
              Text(
                Localization.registerDescription,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
