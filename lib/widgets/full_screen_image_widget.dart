import 'package:flutter/material.dart';

class FullScreenImageWidget extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageWidget({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Avatar Image';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Stack(children: [
            const Center(child: CircularProgressIndicator()),
            Center(
              child: Hero(
                tag: 'imageHero',
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
