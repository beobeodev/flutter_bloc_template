import 'package:flutter/material.dart';

class LoadingAds extends StatelessWidget {
  final double size;

  const LoadingAds({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size * 1.1,
            height: size * 1.1,
            child: const CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Loading ads...',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
