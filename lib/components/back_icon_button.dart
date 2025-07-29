import 'package:flutter/material.dart';

import '../utils/constants.dart';

Widget buildBackIconButton(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
    splashRadius: Constants.splashRadius,
    splashColor: Colors.transparent,
  );
}
