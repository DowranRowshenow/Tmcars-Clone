import 'package:flutter/material.dart';

import '../../components/ripple_container.dart';
import '../../helper/constants.dart' as constants;
import '../../l10n/app_localizations.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.administrator),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          splashRadius: constants.splashRadius,
          splashColor: Colors.transparent,
        ),
      ),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TextField(
                    autocorrect: false,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    decoration: InputDecoration.collapsed(
                      hintText: AppLocalizations.of(context)!.yourMessage,
                    ),
                  ),
                ),
                RippleContainer(
                  padding: EdgeInsets.all(10),
                  onTap: () {},
                  borderRadius: 25,
                  color: Colors.transparent,
                  child: Icon(Icons.send_outlined, size: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
