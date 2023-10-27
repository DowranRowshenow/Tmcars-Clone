import 'package:flutter/material.dart';

import '../../components/back_icon_button.dart';
import '../../size_config.dart';
import '../../components/ripple_container.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Administrator"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackIconButton(),
      ),
      body: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(left: 10),
          height: getProportionateScreenHeight(50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                child: TextField(
                  autocorrect: false,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration.collapsed(
                    hintText: "Siziň hatyňyz...",
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              RippleContainer(
                margin: EdgeInsets.all(getProportionateScreenHeight(13)),
                onTap: () {},
                borderRadius: 30,
                color: Colors.transparent,
                child: Icon(
                  Icons.send_outlined,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(child: Container(), onRefresh: () async {}),
      ),
    );
  }
}
