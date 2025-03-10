import 'package:flutter/material.dart';

class CustomInitialWidget extends StatelessWidget {
  const CustomInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.currency_exchange, size: 80, color: Colors.teal),
          const SizedBox(height: 16),
          Text(
            'Select dates and currencies\nto see exchange rates!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
