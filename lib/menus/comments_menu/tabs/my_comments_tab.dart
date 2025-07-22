import 'package:flutter/material.dart';

import '../../../components/should_register.dart';
import '../../../utils/constants.dart' as constants;

class MyCommentsTab extends StatefulWidget {
  const MyCommentsTab({super.key});

  @override
  State<MyCommentsTab> createState() => _MyCommentsTabState();
}

class _MyCommentsTabState extends State<MyCommentsTab> {
  @override
  Widget build(BuildContext context) {
    return constants.isRegistered ? Container() : ShouldRegister();
  }
}
