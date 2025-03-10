import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomSpringWave extends StatelessWidget {
  const CustomSpringWave({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitWave(
        color: Colors.teal, // لون الـ Animation متطابق مع الـ Theme
        size: 50.0,
      ),
    );
  }
}
