import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveHeader extends StatelessWidget {
  final double height;

  const WaveHeader({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: height,
      child: Transform.rotate(
        angle: 3.14, // rotate by 180 degrees (pi radians)
        child: Stack(
          children: [
            WaveWidget(
              config: CustomConfig(
                gradients: [
                  [Colors.blue[800]!, const Color(0x7744A4D3)],
                  [Colors.blue, const Color(0x6656A5DC)],
                  [Colors.blueAccent, const Color(0x5587CEEB)],
                  [Colors.lightBlue, const Color(0x44B0E0E6)],
                ],
                durations: [32000, 21000, 18000, 5000],
                heightPercentages: [0.25, 0.26, 0.28, 0.31],
                gradientBegin: Alignment.centerLeft,
                gradientEnd: Alignment.centerRight,
              ),
              backgroundColor: Colors.transparent,
              size: const Size(double.infinity, double.infinity),
              waveAmplitude: 0,
            ),
          ],
        ),
      ),
    );
  }
}
