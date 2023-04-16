import 'package:flutter/material.dart';

class WaveHeader extends StatelessWidget {
  final double height;

  const WaveHeader({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: _WavePainter(),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = const LinearGradient(
        // colors: [
        //   Color(0xFF4A4E69),
        //   Color(0xFF6B5B95),
        //   Color(0xFF9B4F96),
        //   Color(0xFFD53F8C),
        //   Color(0xFFFC5185)
        // ],
        colors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    var path = Path()
      ..lineTo(0, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.3,
          size.width * 0.5, size.height * 0.4)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.5, size.width, size.height * 0.4)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
