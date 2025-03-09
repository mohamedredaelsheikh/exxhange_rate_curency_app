import 'package:flutter/material.dart';

class CustomErrorMessage extends StatelessWidget {
  final String errormassage;
  const CustomErrorMessage({super.key, required this.errormassage});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errormassage));
  }
}
