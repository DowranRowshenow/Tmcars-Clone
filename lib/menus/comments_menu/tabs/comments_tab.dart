import 'package:flutter/material.dart';

import '../../../components/should_register.dart';
import '../../../utils/constants.dart';

class CommentsTab extends StatelessWidget {
  const CommentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Constants.isRegistered ? const SizedBox() : const ShouldRegister();
  }
}
