import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageBackground extends StatelessWidget {
  const ImageBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/images/background.svg',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: child,
        ),
      ],
    );
  }
}
