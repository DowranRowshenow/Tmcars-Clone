import 'package:flutter/material.dart';

import '../../../components/should_register.dart';
import '../../../utils/constants.dart' as constants;

class CommentsTab extends StatefulWidget {
  const CommentsTab({super.key});

  @override
  State<CommentsTab> createState() => _CommentsTabState();
}

class _CommentsTabState extends State<CommentsTab> {
  @override
  Widget build(BuildContext context) {
    return constants.isRegistered ? Container() : ShouldRegister();
  }
}
