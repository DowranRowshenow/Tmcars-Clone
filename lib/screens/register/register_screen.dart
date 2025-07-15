import 'package:flutter/material.dart';

import '../../components/ripple_container.dart';
import '../../helper/constants.dart' as constants;
import '../../helper/server.dart';
import '../../l10n/app_localizations.dart';

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
  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          splashRadius: constants.splashRadius,
          splashColor: Colors.transparent,
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
                  image: AssetImage(
                    constants.themeManager.isDark()
                        ? constants.drawerLogoDark
                        : constants.drawerLogoLight,
                  ),
                  height: 85,
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: isEmail
                    ? Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.emailField,
                            style: const TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 5),
                          Flexible(
                            child: TextField(
                              key: const Key('emailAddressController'),
                              controller: emailAddressController,
                              autocorrect: false,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration.collapsed(
                                hintText: AppLocalizations.of(
                                  context,
                                )!.exampleEmail,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          const Text(
                            constants.phoneCode,
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
                              decoration: InputDecoration.collapsed(
                                hintText: AppLocalizations.of(
                                  context,
                                )!.phoneNumber,
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
                        AppLocalizations.of(context)!.acceptPolicy,
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
                          title: AppLocalizations.of(context)!.policy,
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
                  AppLocalizations.of(context)!.accept.toUpperCase(),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: isEmail
                    ? GestureDetector(
                        child: Text(
                          AppLocalizations.of(context)!.enterWithPhoneNumber,
                          style: TextStyle(
                            fontSize: 16,
                            color: constants.appColors.text2ThemeColor,
                          ),
                        ),
                        onTap: () => setState(() => isEmail = false),
                      )
                    : GestureDetector(
                        child: Text(
                          AppLocalizations.of(context)!.enterWithEmail,
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
                AppLocalizations.of(context)!.registerDescription,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
