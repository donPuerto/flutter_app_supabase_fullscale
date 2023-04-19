import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveHeader extends StatelessWidget {
  const WaveHeader({super.key});

  Widget _buildCard({
    required Color backgroundColor,
    required CustomConfig config,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: WaveWidget(
        config: config,
        backgroundColor: Colors.transparent,
        size: const Size(double.infinity, double.infinity),
        waveAmplitude: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 200,
      child: _buildCard(
        backgroundColor: Colors.purpleAccent,
        config: CustomConfig(
          gradients: [
            [Colors.red, const Color(0xEEF44336)],
            [Colors.red[800]!, const Color(0x77E57373)],
            [Colors.orange, const Color(0x66FF9800)],
            [Colors.yellow, const Color(0x55FFEB3B)],
          ],
          durations: [35000, 19440, 10800, 6000],
          heightPercentages: [0.20, 0.23, 0.25, 0.30],
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.topRight,
        ),
      ),
    );
  }
}
