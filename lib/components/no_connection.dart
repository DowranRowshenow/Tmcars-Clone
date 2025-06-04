import 'package:flutter/material.dart';

import '../helper/size_config.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        splashColor: Colors.transparent,
        focusColor: Colors.black12,
        hoverColor: Colors.black12,
        highlightColor: Colors.black12,
        onTap: onTap,
        child: Container(
          height: getProportionateScreenHeight(200),
          width: getProportionateScreenWidth(200),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 50),
              SizedBox(height: getProportionateScreenHeight(10)),
              const Text(
                'Internet ýok',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.refresh, size: 16),
                  Text('Täzeden synanyş'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
