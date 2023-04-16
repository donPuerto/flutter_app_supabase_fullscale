import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/drawer.dart';
// import '../widgets/greeting.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: appBackgroundColor,
        foregroundColor: appForegroundColor,
        actions: const [],
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            setState(() {
              _isDrawerOpen = true;
            });
          } else if (details.delta.dx < 0) {
            setState(() {
              _isDrawerOpen = false;
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(
            _isDrawerOpen ? 250 : 0,
            0,
            0,
          ),
          child: const Center(
            child: Text(
              'Swipe right to open drawer',
            ),
          ),
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
