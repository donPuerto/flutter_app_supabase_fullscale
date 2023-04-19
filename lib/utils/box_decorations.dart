import 'package:flutter/material.dart';

BoxDecoration kRoundedBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(8.0),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 2.0,
      blurRadius: 5.0,
      offset: const Offset(0, 3),
    ),
  ],
);
