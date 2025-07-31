import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/back_icon_button.dart';
import '../../components/ripple_container.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/navigation.dart';
import '../../providers/themes.dart';
import '../../utils/constants.dart';
import '../../utils/server.dart';

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
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.register),
        leading: buildBackIconButton(context),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(25),
                child: Image(
                  image: AssetImage(
                    context.watch<ThemeManager>().isDark()
                        ? Constants.drawerLogoDark
                        : Constants.drawerLogoLight,
                  ),
                  height: 85,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                child: isEmail
                    ? Row(
                        children: [
                          Text(
                            appLocalizations.emailField,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 5),
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
                            Constants.phoneCode,
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 10),
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
                margin: const EdgeInsets.only(top: 5, bottom: 5, left: 45),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: appColors.dividerColor!,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      if (mounted) {
                        setState(() => isChecked = !isChecked);
                      }
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      child: Text(
                        appLocalizations.acceptPolicy,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      onTap: () {
                        context.read<NavigationManager>().setScreen(
                          context,
                          ScreenState.webview,
                          url: Server.PRIVACY_POLICY_RU_URL,
                          title: appLocalizations.policy,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              RippleContainer(
                onTap: () {},
                color: Constants.colorAccent,
                padding: const EdgeInsets.all(15),
                borderRadius: Constants.buttonBorderRadius,
                child: Text(
                  appLocalizations.accept.toUpperCase(),
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                child: isEmail
                    ? GestureDetector(
                        child: Text(
                          appLocalizations.enterWithPhoneNumber,
                          style: TextStyle(
                            fontSize: 16,
                            color: appColors.text2ThemeColor,
                          ),
                        ),
                        onTap: () {
                          if (mounted) {
                            setState(() => isEmail = false);
                          }
                        },
                      )
                    : GestureDetector(
                        child: Text(
                          appLocalizations.enterWithEmail,
                          style: TextStyle(
                            fontSize: 16,
                            color: appColors.text2ThemeColor,
                          ),
                        ),
                        onTap: () {
                          if (mounted) {
                            setState(() => isEmail = true);
                          }
                        },
                      ),
              ),
              const SizedBox(height: 30),
              Text(
                appLocalizations.registerDescription,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
