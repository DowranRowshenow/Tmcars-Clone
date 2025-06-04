import 'package:flutter/material.dart';

import '../../components/back_icon_button.dart';
import '../../components/ripple_container.dart';
import '../../helper/size_config.dart';
import '../../helper/themes.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: appColors.themedSurface,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Administrator"),
        leading: const BackIconButton(),
      ),
      // The body will contain the message list and the input field at the bottom.
      // Using a Column to stack the message area and the input field.
      body: Column(
        children: [
          Expanded(
            // This Expanded widget will take up all available vertical space for messages.
            child: RefreshIndicator(
              // Assuming you want to pull-to-refresh the message list.
              // Replace ListView() with ListView.builder if you have a list of messages.
              child: ListView(
                reverse:
                    true, // Typically true for chat lists to show newest at bottom
                children: const [
                  // Example: Your message widgets would go here
                  // ListTile(title: Text("Hello")),
                  // ListTile(title: Text("How are you?")),
                ],
              ),
              onRefresh: () async {
                // Implement your refresh logic here (e.g., fetch older messages)
              },
            ),
          ),
          // This is your input field area.
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TextField(
                    autocorrect: false,
                    style: TextStyle(
                      color: appColors.textThemeColor,
                      fontSize: 18,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    decoration: InputDecoration.collapsed(
                      hintText: "Siziň hatyňyz...",
                      hintStyle: TextStyle(color: appColors.textHintThemeColor),
                    ),
                  ),
                ),
                RippleContainer(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  onTap: () {},
                  borderRadius: 25, // Adjusted border radius
                  color: Colors.transparent,
                  child: Icon(
                    Icons.send_outlined,
                    color: appColors.iconThemeColor,
                    size: getProportionateScreenWidth(24), // Explicit icon size
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
