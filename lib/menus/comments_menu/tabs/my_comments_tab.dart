import 'package:flutter/material.dart';

import '../../../components/should_register.dart';
import '../../../utils/constants.dart';

class MyCommentsTab extends StatelessWidget {
  const MyCommentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Constants.isRegistered ? const SizedBox() : const ShouldRegister();
  }
}
