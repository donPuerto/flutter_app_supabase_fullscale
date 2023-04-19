import 'package:flutter/material.dart';

class SkyBackground extends StatelessWidget {
  final double height;

  const SkyBackground({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF00B4DB),
            Color(0xFF0083B0),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: height * 0.2,
            left: -height * 0.2,
            child: const _Sun(),
          ),
          Positioned(
            top: height * 0.15,
            left: height * 0.2,
            child: const _Cloud(),
          ),
          Positioned(
            top: height * 0.1,
            right: height * 0.1,
            child: const _Cloud(),
          ),
        ],
      ),
    );
  }
}

class _Sun extends StatelessWidget {
  const _Sun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFC107).withOpacity(0.5),
            spreadRadius: 10,
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Cloud extends StatelessWidget {
  const _Cloud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.cloud,
          size: 40,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
